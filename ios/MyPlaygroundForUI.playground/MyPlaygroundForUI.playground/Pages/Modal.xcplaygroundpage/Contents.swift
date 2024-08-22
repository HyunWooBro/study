

// 모달 애니메이션 테스트
// -> 플레이그라운드에서는 제대로 테스트를 지원하지 않는 것으로 보인다.

//public enum UIModalTransitionStyle : Int, @unchecked Sendable {
//
//
//    case coverVertical = 0
//
//    case flipHorizontal = 1
//
//    case crossDissolve = 2
//
//    @available(iOS 3.2, *)
//    case partialCurl = 3
//}



//public enum UIModalPresentationStyle : Int, @unchecked Sendable {
//
//
//    case fullScreen = 0
//
//    @available(iOS 3.2, *)
//    case pageSheet = 1
//
//    @available(iOS 3.2, *)
//    case formSheet = 2
//
//    @available(iOS 3.2, *)
//    case currentContext = 3
//
//    @available(iOS 7.0, *)
//    case custom = 4
//
//    @available(iOS 8.0, *)
//    case overFullScreen = 5
//
//    @available(iOS 8.0, *)
//    case overCurrentContext = 6
//
//    @available(iOS 8.0, *)
//    case popover = 7
//
//
//    @available(iOS 7.0, *)
//    case none = -1
//
//    @available(iOS 13.0, *)
//    case automatic = -2
//}



import UIKit
import PlaygroundSupport

class MyViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
    override func viewDidLoad() {
        
        
        UIPickerView().do {
            self.view.addSubview($0)
            $0.dataSource = self
            $0.delegate = self
        }
        

        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            
            let vc = MyViewController2()
            
            self.modalTransitionStyle = .flipHorizontal
            self.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true)
        }
        
        
    }
}

class MyViewController2 : UIViewController {
    override func viewDidLoad() {
        
        UIImageView().do {
            self.view.addSubview($0)
            $0.image = UIImage(named: "heart charm.webp")
            $0.frame = .init(x: 0, y: 0, width: 500, height: 500)
        }
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



// definesPresentationContext 은 다음 두 옵션과 연계해서 사용됨
// currentContext
// overCurrentContext

let controller = UIViewController()

// present() 메서드를 통해 모달 방식으로 뷰컨트롤을 띄울 수 있으며 다음 프로퍼티가 세팅된다.

// 자신이 모달로 띄운 뷰컨트롤 반환
// 주의 : 항상 자신이 present() 로 띄운 뷰컨트롤이 반환되는 것이 아니다. definesPresentationContext 값 등을 고려하여 정해진다. 특히 탭바 > 네비게이션 > 뷰컨트롤A 계층에서 뷰컨트롤A에서 present() 로 다른 뷰컨트롤B를 띄운 경우, 뷰컨트롤A의 presentedViewController 는 nil 이며 탭바의 presentedViewController 가 뷰컨트롤B로 세팅된다.
controller.presentedViewController
// 자신을 모달로 띄운 뷰컨트롤 반환
// 주의 : 항상 자신을 present() 로 띄운 뷰컨트롤이 반환되는 것이 아니다. definesPresentationContext 값 등을 고려하여 정해진다. 특히 탭바 > 네비게이션 > 뷰컨트롤A 계층에서 뷰컨트롤A에서 present() 로 다른 뷰컨트롤B를 띄운 경우, 뷰컨트롤B의 presentingViewController 는 뷰컨트롤A가 아니라 탭바로 세팅된다.
controller.presentingViewController
controller.definesPresentationContext


