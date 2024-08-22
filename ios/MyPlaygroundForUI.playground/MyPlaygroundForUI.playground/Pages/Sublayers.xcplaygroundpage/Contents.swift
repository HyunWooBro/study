import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // Sublayers 테스트
        // -> sublayers 는 뷰의 frame 이 변해도 업데이트 되지 않는다.
        let layer = CALayer()
        
        let view1 = UIView()
        self.view.addSubview(view1)
        view1.frame = .init(x: 0, y: 0, width: 100, height: 100)
        print(view1.layer.sublayers?.count ?? 0)
        view1.layer.addSublayer(layer)
        print(view1.layer.sublayers?.count ?? 0)
        layer.frame = view1.frame
        
        print(view1.layer.frame)
        print(view1.layer.sublayers![0].frame)
        
        view1.frame = .init(x: 0, y: 0, width: 150, height: 150)
        
        print(view1.layer.frame)
        print(view1.layer.sublayers![0].frame)
        
        
        
        // Sublayers 렌더링 순서 테스트
        // -> 자식뷰도 부모뷰의 레이어의 자식으로 취급된다.
        // 참조: https://stackoverflow.com/questions/28765608/why-adding-sublayer-overlaps-subviews
        // -> 자식뷰를 추가하거나 자식뷰의 서브레이어의 변화가 발생하면 레이어 배열의 앞으로 이동하는 것으로 보인다.
        let sublayer = CALayer()
        sublayer.frame = .init(x: 30, y: 40, width: 30, height: 30)
        sublayer.backgroundColor = UIColor.green.cgColor
        sublayer.name = "녹색 뷰"
        
        let view2 = UIView()
        self.view.addSubview(view2)
        view2.backgroundColor = .blue
        view2.frame = .init(x: 50, y: 50, width: 100, height: 100)
        print(view2.layer.sublayers?.count)
        
        let view3 = UIView()
        view2.addSubview(view3)
        view3.layer.name = "자식 뷰"
        view3.backgroundColor = .red
        view3.frame = .init(x: 20, y: 20, width: 40, height: 40)
        print(view2.layer.sublayers?.count)
        print(view3.layer.sublayers?.count)
        
        print(view2.layer.sublayers?.first?.name)
        
        // view3 에 자식레이어가 없으면 제대로 적용되지만 자식뷰가 있다면 sublayer 를 view3 레이어보다 낮게 삽입해도 렌더링 순서는 변하지 않는다.
        view2.layer.insertSublayer(sublayer, below: view3.layer)
//        view2.layer.addSublayer(sublayer)
        print(view2.layer.sublayers?.count)
        
        print(view2.layer.sublayers?.first?.name)
        
        let view4 = UIView()
        view3.addSubview(view4)
        view4.backgroundColor = .gray
        view4.frame = .init(x: 20, y: 10, width: 50, height: 50)
        print(view2.layer.sublayers?.count)
        print(view3.layer.sublayers?.count)
        
        print(view2.layer.sublayers?.first?.name)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
