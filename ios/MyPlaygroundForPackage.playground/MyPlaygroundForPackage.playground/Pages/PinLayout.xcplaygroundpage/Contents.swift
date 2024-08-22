import UIKit
import PlaygroundSupport
import PinLayout

class MyViewController : UIViewController {
    
    // FlexLayout 처럼 뷰컨트롤의 viewDidLayoutSubviews() 또는 뷰의 layoutSubviews() 에서 호출하는 것이 기본적이나 FlexLayout 과 유사하게 외부에서도 호출은 가능한 것으로 보인다. 단, FlexLayout 의 layout() 과 같은 메서드의 호출이 불필요할 뿐이다.
    
    // FlexLayout 을 백본으로 사용하면서 PinLayout 은 보조적으로 사용하는 것이 좋겠다.
    
    var view1 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(view1)
        view1.backgroundColor = .red
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // constant 값은 어떻게 추가하지?
        view1.pin
            .top(view.pin.safeArea)
            .left(view.pin.safeArea)
            .size(100)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()




// autoSizeThatFits


let view = UIView()

// pin
view.pin.safeArea

// edge
view.edge.bottom

// anchor
view.anchor.bottomCenter



// CALayer 에도 적용 가능
let layer = CALayer()
layer.pin.left()



// 애니메이션
view.frame.size = .init(width: 100, height: 100)
UIView.animate(
    withDuration: 1.0,
    animations: {
        self.view.pin.size(0)
    }
)

// ???: 원리가 무엇일까?
// 사실 UIKit 의 내부 애니메이션 시스템으로 자동 지원하는 기능이다.



// CGFloat 뿐만 아니라 Percent 값으로 설정 가능

