

// API 설명에서는 알파값을 넣지 말라고 되어 있으나 iOS 푸시알람 화면을 보면 알파가 적용된 블러를 사용하고 있는 것을 볼 수 있다.


// UIVisualEffectView 아래에 뷰를 놓는 것과 contentView 의 서브뷰로 넣는 것의 차이는?
// -> 일반적으로 Blur 와 Vibrancy 를 함 께 사용할 때 Blur 의 서브뷰로 Vibrancy 를 두고 그 아래에 Vibrancy 효과를 입힐 뷰를 넣는 것으로 보인다.


/* UIVisualEffectView is a class that provides a simple abstraction over complex visual effects. Depending on the desired effect, the results may affect content layered behind the view or content added to the view's contentView. Please see the notes for each UIVisualEffect for more details.

 Proper use of this class requires some assistance on your part. Namely:

 • Avoid alpha values < 1 - By default, when a view is partially transparent, the system composites that view and all of its subviews in an offscreen render pass to get the correct translucency. However, UIVisualEffects require being composited as part of the content they are logically layered on top of to look correct. If alpha is less than 1 on the UIVisualEffectView or any of its superviews, many effects will look incorrect or won't show up at all. Setting the alpha on views placed inside the contentView is supported.

 • Judicious masking - Masks have similar semantics to non-opaque views with regards to offscreen rendering. Masks applied to the UIVisualEffectView itself are forwarded to all internal views, including the contentView. You are free to apply a mask to just the contentView. The mask you provide to UIVisualEffectView will not be the view that actually performs the mask. UIKit will make copies of the view to apply to each subview. To reflect a size change to the mask, you must apply the change to the original mask view and reset it on the effect view. Applying a mask to a superview of a UIVisualEffectView (via setMaskView: or the layer's mask property) will cause the effect to fail.

 • Correctly capturing snapshots - Many effects require support from the window that hosts the view. As such, attempting to take a snapshot of just the UIVisualEffectView will result in the snapshot not containing the effect at all or it appearing incorrectly. To properly snapshot a view hierarchy that contains a UIVisualEffectView, you must snapshot the entire UIWindow or UIScreen that contains it.
 */


import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect())
    
    override func viewDidLoad() {
        
        // vibrancy 테스트
        // -> 플레이그라운드에서는 에러가 발생한다.
        
//        let imageView = UIImageView(image: UIImage(named: "heart charm.webp"))
//        imageView.frame = view.bounds
//        imageView.contentMode = .scaleToFill
//        view.addSubview(imageView)
//
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
//        blurredEffectView.frame = imageView.bounds
//        view.addSubview(blurredEffectView)
//
//        let segmentedControl = UISegmentedControl(items: ["First Item", "Second Item"])
//        segmentedControl.sizeToFit()
//        segmentedControl.center = view.center
//
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyEffectView.frame = imageView.bounds
//
//        vibrancyEffectView.contentView.addSubview(segmentedControl)
//        blurredEffectView.contentView.addSubview(vibrancyEffectView)
        
        
        
        //public enum Style : Int, @unchecked Sendable {
        //
        //    case extraLight = 0
        //    case light = 1
        //    case dark = 2
        //
        //    case regular = 4
        //    case prominent = 5
        //
        //    case systemUltraThinMaterial = 6
        //    case systemThinMaterial = 7
        //    case systemMaterial = 8
        //    case systemThickMaterial = 9
        //    case systemChromeMaterial = 10
        //
        //    case systemUltraThinMaterialLight = 11
        //    case systemThinMaterialLight = 12
        //    case systemMaterialLight = 13
        //    case systemThickMaterialLight = 14
        //    case systemChromeMaterialLight = 15
        //
        //    case systemUltraThinMaterialDark = 16
        //    case systemThinMaterialDark = 17
        //    case systemMaterialDark = 18
        //    case systemThickMaterialDark = 19
        //    case systemChromeMaterialDark = 20
        //}
        
        UIImageView().do {
            self.view.addSubview($0)
            $0.image = UIImage(named: "heart charm.webp")
            $0.frame = .init(x: 0, y: 0, width: 500, height: 500)
        }
        
        self.view.addSubview(effectView)
        effectView.frame = .init(x: 0, y: 0, width: 500, height: 500)
        effectView.layer.borderWidth = 0.5
        effectView.layer.borderColor = UIColor.red.cgColor
        
        
        let swipeUp = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeUp)
        )
        swipeUp.direction = .up
        effectView.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeDown)
        )
        swipeDown.direction = .down
        effectView.addGestureRecognizer(swipeDown)
    }
    
    var index = 0
//    var array = [0, 1, 4, 5, 6, 7, 11, 12]
    
    @objc func swipeUp() {
        
        index += 1
        
//        guard let style = UIBlurEffect.Style(rawValue: array[index]) else { return }
        guard let style = UIBlurEffect.Style(rawValue: index) else { return }
        
        effectView.effect = UIBlurEffect(style: style)
        
        print(style.rawValue)
    }
    
    @objc func swipeDown() {
        
        index -= 1
        
//        guard let style = UIBlurEffect.Style(rawValue: array[index) else { return }
        guard let style = UIBlurEffect.Style(rawValue: index) else { return }
        
        effectView.effect = UIBlurEffect(style: style)
        
        print(style.rawValue)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()





