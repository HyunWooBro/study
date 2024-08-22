import UIKit


let controller = UIViewController()
let navigationController = UINavigationController()
let navigationItem = UINavigationItem()
let navigationBar = UINavigationBar()
let barButton = UIBarButtonItem()


// ===============================
// 기본 개념
// ===============================

// [UINavigationController]
// 네비게이션 컨트롤에 푸시된 경우에 상위 네비게이션 컨트롤 반환
// UINaviagationController 자신은 nil 을 반환
controller.navigationController

// [UINavigationItem]
// 네비게이션 스택에 푸시되는 각 뷰컨트롤 마다 갖는 네비게이션 아이템
// 네비게이션바에 삽입되는 UIBarButtonItem 관리
// 개별적으로 스타일 커스터마이징 가능
// UINaviagationController 자신은 nil 을 반환
controller.navigationItem

// [UINavigationBar]
// 네비게이션 스택을 관리하며, 네비게이션 스타일 관리
navigationController.navigationBar



// ===============================
// UINavigationController
// ===============================

// 네베게이션은 스택으로 뷰컨트롤러를 관리한다.
// 가장 앞의 뷰컨트롤러만 활성화되어 있고, 나머지 뷰컨트롤러는 비활성되어 뷰계층에서 나타나지 않는다.
navigationController.viewControllers
// 네비게이션 스택에서 최상위 뷰컨트롤
navigationController.topViewController
// 네비게이션 스택에서 최상위 뷰컨트롤 또는 네비게이션을 덮는 모달 뷰컨트롤
navigationController.visibleViewController
// 네비게이션 스택에 삽입
navigationController.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
// 네비게이션 스택에서 꺼내기
navigationController.popViewController(animated: <#T##Bool#>)
// 특정 뷰컨트롤이 최상에 위치할 때까지 네비게이션 스택에서 꺼내기
navigationController.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
// 하나의 뷰컨트롤이 남을 때까지 네비게이션 스택에서 꺼내기
navigationController.popToRootViewController(animated: true)


navigationController.hidesBarsOnTap
navigationController.setNavigationBarHidden(<#T##hidden: Bool##Bool#>, animated: <#T##Bool#>)
navigationController.isNavigationBarHidden


navigationController.hidesBarsOnTap
navigationController.hidesBarsOnSwipe
navigationController.hidesBarsWhenKeyboardAppears


navigationController.toolbar
navigationController.toolbarItems
navigationController.setToolbarItems(<#T##toolbarItems: [UIBarButtonItem]?##[UIBarButtonItem]?#>, animated: <#T##Bool#>)
navigationController.isToolbarHidden
navigationController.setToolbarHidden(<#T##hidden: Bool##Bool#>, animated: <#T##Bool#>)
navigationController.hidesBottomBarWhenPushed


// show vs. push
navigationController.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)



// ===============================
// UINavigationBar
// ===============================

// 네비게이션 아이템 스택 관리
navigationBar.items
navigationBar.topItem
navigationBar.backItem

// 스타일 관리
navigationBar.isHidden
navigationBar.tintColor
navigationBar.standardAppearance
navigationBar.compactAppearance
navigationBar.scrollEdgeAppearance


// ===============================
// UINavigationItem
// ===============================

// 가장 우측에 있는 버튼
navigationItem.rightBarButtonItem = barButton
// 우측에 삽입되는 버튼 모음 (순서대로 오른쪽에서 왼쪽으로 채워짐)
navigationItem.rightBarButtonItems?.append(barButton)
// 애니메이션 추가 버전
navigationItem.setRightBarButton(barButton, animated: true)
navigationItem.setRightBarButtonItems([barButton], animated: true)


// 가장 좌측에 있는 버튼
navigationItem.leftBarButtonItem = barButton
// 좌측에 삽입되는 버튼 모음 (순서대로 왼쪽에서 오른쪽으로 채워짐)
navigationItem.leftBarButtonItems?.append(barButton)
// 애니메이션 추가 버전
navigationItem.setLeftBarButton(barButton, animated: true)
navigationItem.setLeftBarButtonItems([barButton], animated: true)


// 뒤로가기 전용 버튼 (위의 왼쪽 버튼을 사용하면 뒤로가기 버튼은 무시됨)
navigationItem.backBarButtonItem = barButton


// 네비게이션 왼쪽 영역에 유저가 어떤 버튼이라도 삽입하면 시스템이 자동으로 뒤로가기 버튼을 넣어주지 않지만 아래 옵션을 true 로 설정하면, 기본 뒤로가기 버튼을 유지한 채로 왼쪽에 버튼 추가 가눙
navigationItem.leftItemsSupplementBackButton = true


// 네비게이션 중앙에 커스텀 뷰 넣기 (좌우 아이템과는 달리 자동으로 사이즈를 설정)
navigationItem.titleView


// 스타일 관리
navigationItem.standardAppearance
navigationItem.compactAppearance
navigationItem.scrollEdgeAppearance



// ===============================
// UINavigationControllerDelegate
// ===============================

// 네비게이션 애니메이션 콜백에 대해서는 다음과 같이 크게 3가지 검색 결과를 찾을 수 있다.
// 1. CATransaction 활용
// 2. transitionCoordinator 활용
// 3. UINavigationControllerDelegate 활용
// CATransaction 경우 일부 상황에서는 제대로 적용되지 않는 경우가 존재하며, transitionCoordinator 경우 일부 상황에서는 nil 인 경우가 있는 것으로 보인다. 확실한 방법은 아무래도 정석대로 UINavigationControllerDelegate 를 활용하는 것으로 보인다.
// 참조 : https://stackoverflow.com/questions/12904410/completion-block-for-popviewcontroller
// 참조 : https://stackoverflow.com/questions/9906966/completion-handler-for-uinavigationcontroller-pushviewcontrolleranimated
// 참조 : https://stackoverflow.com/questions/21743780/is-it-possible-to-push-a-view-controller-with-a-completion-block/43017103#43017103



// ===============================
// UINavigationBarDelegate
// ===============================

