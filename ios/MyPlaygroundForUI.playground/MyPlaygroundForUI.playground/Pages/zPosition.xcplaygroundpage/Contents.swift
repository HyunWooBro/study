import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // zPosition 테스트
        // -> zPosition 은 기본적으로 같은 부모를 가진 형제 뷰 사이에 적용된다.
        // -> 아무리 자식 뷰에서 높은 zPostion 을 세팅해도 같은 형제 뷰가 아니라면 렌더링 순서에 영향을 주지 않는다.
        let view1 = UIView()
        self.view.addSubview(view1)
        
        let view2 = UIView()
        view2.frame = .init(x: 0, y: 0, width: 50, height: 50)
        view2.backgroundColor = .green
        view2.layer.zPosition = 1
        view1.addSubview(view2)
        
        let view3 = UIView()
        view3.frame = .init(x: 25, y: 25, width: 50, height: 50)
        view3.backgroundColor = .brown
        self.view.addSubview(view3)
        
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
