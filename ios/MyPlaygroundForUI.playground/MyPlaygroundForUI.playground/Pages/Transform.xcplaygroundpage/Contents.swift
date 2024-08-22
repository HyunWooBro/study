import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        let view = UIView()
        self.view.addSubview(view)
//        view.snp.makeConstraints {
//            
//        }

        // 스케일
        let scale = CGAffineTransform(scaleX: 2, y: 2)
        // 회전
        let rotation = CGAffineTransform(rotationAngle: .pi)
        // 이동
        let translation = CGAffineTransform(translationX: 200, y: 200)

        UIView.animate(withDuration: 5) {
            view.transform = scale.concatenating(rotation).concatenating(translation)
        } completion: { _ in
            UIView.animate(withDuration: 5) {
                view.transform = .identity
            }
        }
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()





