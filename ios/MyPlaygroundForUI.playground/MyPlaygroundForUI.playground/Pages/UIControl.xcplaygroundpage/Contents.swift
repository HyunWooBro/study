
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        // ===============================
        // Target/Action vs. UIAction
        // ===============================
        
        // 이벤트 처리는 Target/Action 방식과 신규 UIAction 방식으로 나눌 수 있다.
        // Target/Action 방식에서 target 과 action 은 이벤트 처리를 위임하는 방법이다. 설정한 이벤트가 발생하면 target 이 처리하도록 하는 것이다. 만약, target 이 nil 일 경우 Responder Chain 을 따라가며 Action 메시지를 처리하는 타겟을 찾을 때까지 검색한다.
        // 한편, #selector 를 통해 메서드의 이름을 넘길 때 메서드의 이름이 모호하지 않는다면 파라미터 없이 메서드명만 넘길 수도 있다.
        
        UIButton().do {
            $0.configuration = UIButton.Configuration.gray()
            $0.configuration?.title = "Target"
            $0.updateConfiguration()
            self.view.addSubview($0)
            $0.frame = .init(x: 0, y: 0, width: 100, height: 100)
            // 아래 이벤트의 대상은 button 이지만, for 에 해당하는 이벤트(touchUpInside)가 발생하면 처리는 self(뷰컨트롤)의 targetAction 메서드를 통해 처리하게 된다.
            $0.addTarget(self, action: #selector(targetAction), for: .touchUpInside)
            // 중복으로 등록해도 같은 파라미터에 대해서는 무시된다.
            $0.addTarget(self, action: #selector(targetAction), for: .touchUpInside)
        }
        
        
        // UIAction.Identifier 에 의해 유니크하게 구별됨
        UIButton().do {
            $0.configuration = UIButton.Configuration.gray()
            $0.configuration?.title = "Action"
            $0.updateConfiguration()
            $0.addAction(UIAction(handler: { action in
                print("UIAction1 called")
            }), for: .touchUpInside)
            $0.addAction(UIAction(handler: { action in
                print("UIAction2 called")
            }), for: .touchUpInside)
            self.view.addSubview($0)
            $0.frame = .init(x: 100, y: 0, width: 100, height: 100)
        }
        
        
        
        // ===============================
        // UIControl.Event
        // ===============================
        
        // 값변경 (UISwitch, UISegmentedControl, UISlider, UIPickerView 등)
        UIControl.Event.valueChanged
        
        // 터치업 (UIButton 등)
        UIControl.Event.touchUpInside
        
        // 편집변경 (UITextField)
        UIControl.Event.editingDidBegin
        UIControl.Event.editingDidEnd // 편집종료(모두)
        UIControl.Event.editingDidEndOnExit // 편집종료(리턴으로 종료할 경우)
        UIControl.Event.editingChanged // valueChanged 와 혼동 주의
        
        
        
        // ===============================
        // sendAction
        // ===============================
        
        // 이벤트를 직접 발생시킨다.
        // 특히, 코드로 값을 직접 변경하면 이벤트가 생성안되는 경우에 활용할 수 있다.
        UIControl().sendActions(for: <#T##UIControl.Event#>)
        
        
        
        // ===============================
        // Delegate vs. Action
        // ===============================
        
        // UITextField 처럼 delegate 와 action 을 모두 제공하는 경우가 있다.
        // delegate 와 action 을 동시에 설정해서 사용해도 모두 작동하는 것으로 보인다.
        
        
        
        // ===============================
        // Gesture vs. Action
        // ===============================
        
        // 아래 탭제스처의 대상은 제스처를 등록하는 view 이지만, 처리는 self(뷰컨트롤)의 tap 메서드를 통해 처리한다.
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tap)
        )
        view.addGestureRecognizer(tap)
        
    }
    
    // UIGestureRecognizer 에 대한 #selector 의 대상이 되는 메서드는 다음 2가지 형식이 가능하다.
    // @objc func do()
    // @objc func do(sender: Any)
    @objc func tap(_ sender: UITapGestureRecognizer) {
        print(sender.view ?? "")
        print(#function + " called : \(sender)")
    }
    
    // UIControl 의 addTarget 에 대한 #selector 의 대상이 되는 메서드는 다음 3가지 형식이 가능하다.
    // @objc func do()
    // @objc func do(sender: Any)
    // @objc func do(sender: Any, forEvent event: UIEvent)
    @objc func targetAction(_ sender: UIButton, forEvent event: UIEvent) {
        print(#function + " called")
        print(event)
    }

}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
