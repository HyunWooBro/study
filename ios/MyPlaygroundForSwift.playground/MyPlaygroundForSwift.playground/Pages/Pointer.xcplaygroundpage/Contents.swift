import ObjectiveC


UnsafePointer(<#T##from: OpaquePointer##OpaquePointer#>)

UnsafeMutablePointer(<#T##other: UnsafeMutablePointer<Pointee>##UnsafeMutablePointer<Pointee>#>)

UnsafeRawPointer(<#T##other: UnsafePointer<T>##UnsafePointer<T>#>)

UnsafeMutableRawPointer(mutating: <#T##UnsafeRawPointer#>)

unsafeBitCast

unsafeDowncast





func def(pointer: UnsafeRawPointer) {
    let c = "34"
}
var abc: Int = 0
def(key: &abc)



// PinLayout 예시

typealias Function = @convention(c) (AnyObject, Selector) -> Void
private static func extractMethodFrom(owner: AnyObject, selector: Selector) -> (() -> Void)? {
    guard let method = owner is AnyClass ? class_getClassMethod((owner as! AnyClass), selector) :
        class_getInstanceMethod(type(of: owner), selector)
        else { return nil }
    let implementation = method_getImplementation(method)

    let function = unsafeBitCast(implementation, to: Function.self)

    return {
        function(owner, selector)
    }
}


extension UIView: AutoSizeCalculable {
    private struct pinlayoutAssociatedKeys {
        static var pinlayoutAutoSizingRect = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
        static var pinlayoutAutoSizingRectWithMargins = UnsafeMutablePointer<Int8>.allocate(capacity: 1)
    }
    
    private var autoSizingRect: CGRect? {
        get {
            return objc_getAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutAutoSizingRect) as? CGRect
        }
        set {
            objc_setAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutAutoSizingRect, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var autoSizingRectWithMargins: CGRect? {
        get {
            return objc_getAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutAutoSizingRectWithMargins) as? CGRect
        }
        set {
            objc_setAssociatedObject(self, &pinlayoutAssociatedKeys.pinlayoutAutoSizingRectWithMargins, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


static private func swizzleViewWillLayoutSubviews(_ class_: AnyClass, to block: @escaping ViewWillLayoutSubviewsBlock) -> IMP? {
    let selector = #selector(UIViewController.viewWillLayoutSubviews)
    let method = class_getInstanceMethod(class_, selector)
    let newImplementation = imp_implementationWithBlock(unsafeBitCast(block, to: AnyObject.self))

    if let method = method {
        let oldImplementation = method_getImplementation(method)
        method_setImplementation(method, newImplementation)
        return oldImplementation
    } else {
        class_addMethod(class_, selector, newImplementation, "")
        return nil
    }
}
