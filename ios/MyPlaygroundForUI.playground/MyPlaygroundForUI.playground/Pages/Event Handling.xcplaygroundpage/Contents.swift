import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        // ===============================
        // 개요
        // ===============================
        
        // iOS 의 터치 이벤트 처리는 웹이나 안드로이드와 달리 부모뷰가 자식뷰의 터치 이벤트에 간섭할 수가 없다. 이벤트 사전에 부모뷰가 조작할 수 없고 이벤트가 끝나고도 부모뷰는 사후 처리를 할 수 없다. 물론, 부모뷰가 이벤트를 처리할 수 없으면 자식뷰에도 처리할 수 있는 기회가 주어지지 않는 다는 점만 제외한다면.

        // iOS 에서의 터치 이벤트 프로세스는 다음과 같다.
        // 1. Hit-Testing 을 통해 터치 이벤트를 처리할 수 있는 대상을 찾는다.
        //   a. 대상이 이벤트를 받기 위해서는 다음 4가지 조건을 만족해야 한다.
        //      isHidden == false
        //      isUserInteractionEnabled == true
        //      alpha > 0.01
        //      터치한 위치가 대상의 바운드 안에 포함
        //   b. a. 를 통과한 대상에 제스처가 등록되어 있다면 전달한다. 여기서 제스처가 인식된다면 프로세스를 멈춘다.
        //   c. 자식뷰에 대해서 a. 부터 반복한다. 이런 식으로 가장 안쪽의 frontmost 뷰를 찾는다.
        // 2. frontmost 뷰에게 터치 이벤트를 전달한다.
        // 전달된 터치 이벤트는 완료될 때까지 해당 뷰에게 전달된다.
        // 참조: https://smnh.me/hit-testing-in-ios
        
        // Hit-Testing 관련 메서드
        class HitTest: UIView {
            // 포인트 위치를 바운더리에 포함하는 inner most 뷰가 반환된다.
            override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
                <#code#>
            }
        }

        
        
        // ===============================
        // 응용
        // ===============================
        
        // 다양한 사례를 바탕으로 터치 이벤트 프로세스를 이해해 보자.
        
        // 1. 부모뷰의 범위를 벗어나는 자식뷰는 터치를 받을 수 있나?
        // => hitTest() 오버라이딩으로 우회하지 않는 이상 기본적으로 불가능하다.
        
        // 2. 부모뷰의 사이즈가 0(너비 또는 높이가 0)인 경우 자식뷰는 터치를 받을 수 있나?
        // => hitTest() 오버라이딩으로 우회하지 않는 이상 기본적으로 불가능하다.
        
        // 3. 부모뷰와 자식뷰가 모두 특정 이벤트(touchUpInside 등)를 처리할 수 있는 경우 누가 처리하는가?
        // => 자식뷰가 처리한다.
        
        // 4. 화면 전체를 덮는 뷰를 최상단에 추가하여 효과(배경을 어둡게 등)를 주었는데 계층 아래 뷰에 대한 터치가 가능하거나 불가능하게 하는 방법은?
        
        
        
        // ===============================
        // TouchEvent vs. Gesture
        // ===============================
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tap)
        )
        // 기본적으로 제스처가 이벤트를 인식하면 이벤트를 소모하여 frontmost 뷰에는 터치 이벤트가 전달이 되지 않는데, 아래의 플래그를 false 로 세팅하면 제스처가 이벤트를 인식한 후에도 frontmost 뷰에도 터치 이벤트를 전달하게 된다. (디폴트 true)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        

        view.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


// ===============================
// UIResponder
// ===============================

let responder = UIResponder()

// Responder 체인을 따라 기본적으로 superview 를 반환하며, 최상위 root 뷰의 경우에는 UIViewController 를 반환한다. UIViewController 는 최상위 root 뷰가 다른 superview 를 가진다면 superview 를, 아니면 UIWindow 를 반환하고 최종적으로 UIApplication 까지 거슬러 올라간다.
responder.next

// 일반적으로 키보드 인풋 대상이 된다.
responder.becomeFirstResponder()
responder.canBecomeFirstResponder

// 키보드 인풋 대상을 포기한다.
responder.resignFirstResponder()
responder.canResignFirstResponder

responder.isFirstResponder


