import ObjectiveC
import UIKit
import FloatingPanel


// ===============================
// Method Swizzling
// ===============================

method_exchangeImplementations(<#T##Method#>, <#T##Method#>)


class_addMethod(<#T##cls: AnyClass?##AnyClass?#>, <#T##name: Selector##Selector#>, <#T##imp: IMP##IMP#>, <#T##types: UnsafePointer<CChar>?##UnsafePointer<CChar>?#>)


class_getInstanceMethod(<#T##AnyClass?#>, <#T##Selector#>)


method_getImplementation(<#T##m: Method##Method#>)


method_getTypeEncoding(<#T##m: Method##Method#>)


// Kingfisher
- (void)swizzleSelector:(SEL)selector fromClass:(Class)original toClass:(Class)stub {

    Method originalMethod = class_getInstanceMethod(original, selector);
    Method stubMethod = class_getInstanceMethod(stub, selector);
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"Couldn't load NSURLSession hook."];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}


// SkeletonView
func swizzle(selector originalSelector: Selector, with swizzledSelector: Selector, inClass: AnyClass, usingClass: AnyClass) {
    guard let originalMethod = class_getInstanceMethod(inClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(usingClass, swizzledSelector)
        else { return }

    if class_addMethod(inClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)) {
        class_replaceMethod(inClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}


// EmptyDataSet-Swift 예시
extension UIScrollView: UIGestureRecognizerDelegate {
    
    @objc private func tableViewSwizzledReloadData() {
        tableViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    @objc private func collectionViewSwizzledReloadData() {
        collectionViewSwizzledReloadData()
        reloadEmptyDataSet()
    }
    
    private class func swizzleMethod(for aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(aClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector)
        
        let didAddMethod = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
    
    
    private static let swizzleReloadData: () = {
        let tableViewOriginalSelector = #selector(UITableView.reloadData)
        let tableViewSwizzledSelector = #selector(UIScrollView.tableViewSwizzledReloadData)
        
        swizzleMethod(for: UITableView.self, originalSelector: tableViewOriginalSelector, swizzledSelector: tableViewSwizzledSelector)
        
        let collectionViewOriginalSelector = #selector(UICollectionView.reloadData)
        let collectionViewSwizzledSelector = #selector(UIScrollView.collectionViewSwizzledReloadData)
        
        swizzleMethod(for: UICollectionView.self, originalSelector: collectionViewOriginalSelector, swizzledSelector: collectionViewSwizzledSelector)
    }()
}


// FloatingPanel 예시
private var originalDismissImp: IMP?
private typealias DismissFunction = @convention(c) (AnyObject, Selector, Bool, (() -> Void)?) -> Void
extension FloatingPanelController {
    private static let dismissSwizzling: Void = {
        let aClass: AnyClass! = UIViewController.self //object_getClass(vc)
        if let originalMethod = class_getInstanceMethod(aClass, #selector(dismiss(animated:completion:))),
           let swizzledImp = class_getMethodImplementation(aClass, #selector(__swizzled_dismiss(animated:completion:))) {
           originalDismissImp = method_setImplementation(originalMethod, swizzledImp)
        }
    }()
}

extension UIViewController {
    @objc
    fileprivate func __swizzled_dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        let dismissImp = unsafeBitCast(originalDismissImp, to: DismissFunction.self)
        let sel = #selector(UIViewController.dismiss(animated:completion:))

        // Call dismiss(animated:completion:) to a content view controller
        if let fpc = parent as? FloatingPanelController {
            if fpc.presentingViewController != nil {
                dismissImp(self, sel, flag, completion)
            } else {
                fpc.removePanelFromParent(animated: flag, completion: completion)
            }
            return
        }
        // Call dismiss(animated:completion:) to FloatingPanelController directly
        if let fpc = self as? FloatingPanelController {
            // When a panel is presented modally and it's not a child view controller of the presented view controller.
            if fpc.presentingViewController != nil, fpc.parent == nil {
                dismissImp(self, sel, flag, completion)
            } else {
                fpc.removePanelFromParent(animated: flag, completion: completion)
            }
            return
        }

        // For other view controllers
        dismissImp(self, sel, flag, completion)
    }
}


// ReactorKit 예시
+ (void)swizzleViewDidLoadOfClassNamed:(NSString *)className {
  Class class = NSClassFromString(className);
  if (!class) {
    return;
  }
  #pragma clang diagnostic push
  #pragma clang diagnostic ignored "-Wundeclared-selector"
  SEL oldSelector = @selector(viewDidLoad);
  SEL performBindingSelector = @selector(_reactorkit_performBinding);
  #pragma clang diagnostic pop

  Method oldMethod = class_getInstanceMethod(class, oldSelector);
  const char *types = method_getTypeEncoding(oldMethod);
  void (*oldMethodImp)(id, SEL) = (void (*)(id, SEL))method_getImplementation(oldMethod);

  IMP newMethodImp = imp_implementationWithBlock(^(__unsafe_unretained id self) {
    oldMethodImp(self, oldSelector);
    if ([self respondsToSelector:performBindingSelector]) {
      #pragma clang diagnostic push
      #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
      [self performSelector:performBindingSelector];
      #pragma clang diagnostic pop
    }
  });
  class_replaceMethod(class, oldSelector, newMethodImp, types);
}


// Hero 예시
extension CALayer {
  internal static var heroAddedAnimations: [(CALayer, String, CAAnimation)]? = {
    let swizzling: (AnyClass, Selector, Selector) -> Void = { forClass, originalSelector, swizzledSelector in
      if let originalMethod = class_getInstanceMethod(forClass, originalSelector), let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
      }
    }
    let originalSelector = #selector(add(_:forKey:))
    let swizzledSelector = #selector(hero_add(anim:forKey:))
    swizzling(CALayer.self, originalSelector, swizzledSelector)
    return nil
  }()

  @objc dynamic func hero_add(anim: CAAnimation, forKey: String?) {
    if let animationKey = forKey,
        CALayer.heroAddedAnimations != nil,
        let copiedAnim = anim.copy() as? CAAnimation {
        copiedAnim.delegate = nil // having delegate resulted some weird animation behavior
        CALayer.heroAddedAnimations?.append((self, animationKey, copiedAnim))
    }
    hero_add(anim: anim, forKey: forKey)
  }
}



// ===============================
// ISA Swizzling
// ===============================

object_setClass(<#T##Any?#>, <#T##AnyClass#>)


object_getClass(<#T##obj: Any?##Any?#>)


// FloatingPanel 예시
/// This extension makes sure SwiftUI views are not affected by iOS keyboard.
///
/// Credits to https://steipete.me/posts/disabling-keyboard-avoidance-in-swiftui-uihostingcontroller/
extension UIHostingController {
    public convenience init(rootView: Content, ignoresKeyboard: Bool) {
        self.init(rootView: rootView)

        if ignoresKeyboard {
            guard let viewClass = object_getClass(view) else { return }

            let viewSubclassName = String(
                cString: class_getName(viewClass)
            ).appending("_IgnoresKeyboard")

            if let viewSubclass = NSClassFromString(viewSubclassName) {
                object_setClass(view, viewSubclass)
            } else {
                guard
                    let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String,
                    let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0)
                else { return }

                if let method = class_getInstanceMethod(
                    viewClass,
                    NSSelectorFromString("keyboardWillShowWithNotification:")
                ) {
                    let keyboardWillShow: @convention(block) (AnyObject, AnyObject) -> Void = { _, _ in }
                    class_addMethod(
                        viewSubclass,
                        NSSelectorFromString("keyboardWillShowWithNotification:"),
                        imp_implementationWithBlock(keyboardWillShow),
                        method_getTypeEncoding(method)
                    )
                }
                objc_registerClassPair(viewSubclass)
                object_setClass(view, viewSubclass)
            }
        }
    }
}
