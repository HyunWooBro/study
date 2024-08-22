import UIKit



// ===============================
// Container View Controller
// ===============================

let controller = UIViewController()

controller.addChild(UIViewController())
controller.children



// 뷰컨트롤에 자식 뷰컨트롤 추가하기
// 확인할 것은 라이프사이클 관련 메서드의 호출 관련된 내용
// 누가에 의해, 언제 호출되어야 하는가
// child.view 접근하는 순간 자식 뷰컨트롤의 viewDidLoad() 호출됨
// addSubview 에서 뷰컨트롤의 viewWillAppear() 호출됨
let storyboard = UIStoryboard(name: "Main", bundle: .main)
if let viewController = storyboard.instantiateViewController(identifier: "imageViewController") as? ImageViewController {
    // Add the view controller to the container.
    addChild(viewController)
    
    // addSubview() 를 호출하면 view 의 superview 가 바뀌는 것이 일반적이지만 뷰컨트롤의 뷰의 경우에는 바뀌지 않는다.
    
    view.addSubview(viewController.view)
    
    // Create and activate the constraints for the child’s view.
    onscreenConstraints = configureConstraintsForContainedView(containedView: viewController.view,
                                                               stage: .onscreen)
    NSLayoutConstraint.activate(onscreenConstraints)
    
    // Notify the child view controller that the move is complete.
    viewController.didMove(toParent: self)
}

// 애플 공식문서에서 Child View Controller (Contents View Controller) 추가하는 순서를 다음과 같이 명시
func show(child: UIViewController) {
    
    // Add the view controller to the container.
    addChild(child)
    view.addSubview(child.view)
      
    // Notify the child view controller that the move is complete.
    child.didMove(toParent: self)
}

// 애플 공식문서에서 Child View Controller (Contents View Controller) 제거하는 순서를 다음과 같이 명시
func hide(child: UIViewController) {
    
    child.willMove(toParent: nil)
    
    child.removeFromParent()
    
    child.view.removeFromSuperview()
}


// 일반적으로 하나의 UIViewController 를 사용하는 경우가 많긴 하지만 실제로 탭바 또는 네비게이션은 다른 UIViewController 를 관리하고 있다.

UINavigationController().viewControllers
UITabBarController().viewControllers




// UISearchController 처럼 하나의 뷰인 UISearchBar 를 관리하는 용도로 사용할 수 있다.
// UIViewController 는 MVC 모델에서 Controller 역할을 하는 것일 뿐이지 뷰에서 반드시 하나만 존재할 필요는 없다.
// UIWindow 의 rootViewController 를 통해 가장 상단의 뷰를 관리하는 컨트롤러를 두고 하위 컨트롤러를 관리하게 된다. 마치 UIView 가 하위 서브뷰를 두듯이. 하나의 뷰컨트롤러만으로 모든 뷰를 컨트롤할 수도 있고 여러 뷰컨트롤러가 나눠서 뷰를 처리할 수도 있다. 선택의 문제인 것이다.

UIWindow().rootViewController



// 모달 관련 (Modal 참조)
controller.presentedViewController
controller.presentingViewController
controller.definesPresentationContext


// 네비게이션 또는 탭바를 가지고 있으면 업데이트 한다.
controller.title
