import UIKit


let controller = UIViewController()
let tabBarController = UITabBarController()
let tabBarItem = UITabBarItem()
let tabBar = UITabBar()


// ===============================
// 기본 개념
// ===============================

// [UITabBarController]
// 탭바 컨트롤에 포함된 경우에 상위 탭바 컨트롤 반환
// UITabBarController 자신은 nil 을 반환
controller.tabBarController

// [UITabBarItem]
// UITabBarController 자신은 nil 을 반환
controller.tabBarItem

// [UITabBar]
tabBarController.tabBar



// ===============================
// UITabBarController
// ===============================

// 탭바 컨트롤이 관리하는 뷰컨트롤러 (일반적으로 네비게이션 컨트롤)
tabBarController.viewControllers
// 현재 선택된 뷰컨트롤
tabBarController.selectedViewController
tabBarController.setViewControllers(<#T##viewControllers: [UIViewController]?##[UIViewController]?#>, animated: <#T##Bool#>)
tabBarController.selectedIndex



// ===============================
// UITabBar
// ===============================

// 탭바 아이템 관리
tabBar.items
tabBar.selectedItem

// 스타일 관리
tabBar.isHidden
tabBar.standardAppearance
tabBar.scrollEdgeAppearance



// ===============================
// UITabBarItem
// ===============================

// 뱃지 관리
tabBarItem.badgeValue
tabBarItem.badgeColor

// 제목 및 이미지 관리
tabBarItem.title
tabBarItem.image
tabBarItem.selectedImage

// 스타일 관리
tabBarItem.standardAppearance
tabBarItem.scrollEdgeAppearance



// ===============================
// UITabBarControllerDelegate
// ===============================



// ===============================
// UITabBarDelegate
// ===============================



// ===============================
// 기타
// ===============================

// 탭바의 개수가 많아지면 More 탭이 나타남?
tabBarController.moreNavigationController

// 커스터마이징 (탭바의 순서 바꾸기?)
tabBarController.customizableViewControllers


