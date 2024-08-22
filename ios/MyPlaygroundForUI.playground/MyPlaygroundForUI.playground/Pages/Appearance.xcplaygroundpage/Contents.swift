import Foundation
import UIKit


// UI바 커스터마이징 하는 많은 방식이 존재하기 때문에 특정 방식을 정해서 고수하는 것이 좋을 것 같다.


// ===============================
// UIAppearance
// ===============================

// UIAppearance 은 UIView 또는 UIBarItem 에서 상속받은 모든 클래스가 갖는 프록시 클래스
// appearance() 로 접근하여 설정한 내용은 이후에 신규 인스턴스에 적용되며 이전 인스턴스에는 적용되지 않음 (한편, 뷰계층에서 제거한 후 다시 넣으면 적용할 수 있음)
// 파라미터를 활용한 구체적인 UIAppearance 가 파라미터가 없는 UIAppearance 보다 우선순위가 높음
// 과거의 UIAppearance 방식과 iOS 13 부터 도입된 UIBarAppearance 방식을 함께 사용할 경우, UIAppearance 의 우선순위가 더 높아 신규 방식은 적용되지 않는 것으로 보인다.


// UIView 상속
UIView.appearance()
UINavigationBar.appearance()
UIButton.appearance()
UIImageView.appearance()


// UIBarItem 상속
UIBarButtonItem.appearance()
UITabBarItem.appearance()


// whenContainedInInstancesOf 파라미터를 활용하여 특정 클래스 대상으로만 적용 가능
UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIToolbar.self])



// ===============================
// 탭바 UIBarAppearance (iOS 13+)
// ===============================

// class UITabBarAppearance : UIBarAppearance
let tabBarAppearance = UITabBarAppearance()
print("configureWithOpaqueBackground")
tabBarAppearance.configureWithOpaqueBackground()
print(tabBarAppearance.backgroundColor)
print(tabBarAppearance.backgroundImage)
print(tabBarAppearance.backgroundEffect)
print(tabBarAppearance.shadowColor)
print(tabBarAppearance.shadowImage)
print("configureWithDefaultBackground")
tabBarAppearance.configureWithDefaultBackground()
print(tabBarAppearance.backgroundColor)
print(tabBarAppearance.backgroundImage)
print(tabBarAppearance.backgroundEffect)
print(tabBarAppearance.shadowColor)
print(tabBarAppearance.shadowImage)
print("configureWithTransparentBackground")
tabBarAppearance.configureWithTransparentBackground()
print(tabBarAppearance.backgroundColor)
print(tabBarAppearance.backgroundImage)
print(tabBarAppearance.backgroundEffect)
print(tabBarAppearance.shadowColor)
print(tabBarAppearance.shadowImage)


// class UITabBarItemAppearance : NSObject, NSCopying, NSSecureCoding
// 세로화면
tabBarAppearance.stackedLayoutAppearance
// 가로화면
tabBarAppearance.inlineLayoutAppearance
tabBarAppearance.compactInlineLayoutAppearance

// class UITabBarItemStateAppearance : NSObject
// normal 의 세부 설정이 세팅되어 있으면 다른 상태의 세부 설정에도 normal 세팅이 대신 적용됨
tabBarAppearance.stackedLayoutAppearance.normal
tabBarAppearance.stackedLayoutAppearance.disabled
tabBarAppearance.stackedLayoutAppearance.focused
tabBarAppearance.stackedLayoutAppearance.selected



// ===============================
// 네비게이션바 UIBarAppearance
// ===============================

// class UINavigationBarAppearance : UIBarAppearance
let navigationBarAppearance = UINavigationBarAppearance()
print("configureWithOpaqueBackground")
navigationBarAppearance.configureWithOpaqueBackground()
print(navigationBarAppearance.backgroundColor)
print(navigationBarAppearance.backgroundImage)
print(navigationBarAppearance.backgroundEffect)
print(navigationBarAppearance.shadowColor)
print(navigationBarAppearance.shadowImage)
print("configureWithDefaultBackground")
navigationBarAppearance.configureWithDefaultBackground()
print(navigationBarAppearance.backgroundColor)
print(navigationBarAppearance.backgroundImage)
print(navigationBarAppearance.backgroundEffect)
print(navigationBarAppearance.shadowColor)
print(navigationBarAppearance.shadowImage)
print("configureWithTransparentBackground")
navigationBarAppearance.configureWithTransparentBackground()
print(navigationBarAppearance.backgroundColor)
print(navigationBarAppearance.backgroundImage)
print(navigationBarAppearance.backgroundEffect)
print(navigationBarAppearance.shadowColor)
print(navigationBarAppearance.shadowImage)

// class UIBarButtonItemAppearance : NSObject, NSCopying, NSSecureCoding
// 일반 버튼
navigationBarAppearance.buttonAppearance
// 완료 버튼
navigationBarAppearance.doneButtonAppearance
// 뒤로가기 버튼
navigationBarAppearance.backButtonAppearance

// class UIBarButtonItemStateAppearance : NSObject
// normal 의 세부 설정이 세팅되어 있으면 다른 상태의 세부 설정에도 normal 세팅이 대신 적용됨
navigationBarAppearance.buttonAppearance.normal
navigationBarAppearance.buttonAppearance.disabled
navigationBarAppearance.buttonAppearance.focused
navigationBarAppearance.buttonAppearance.highlighted



// ===============================
// 툴바 UIBarAppearance
// ===============================

// class UIToolbarAppearance : UIBarAppearance
let toolBarAppearance = UIToolbarAppearance()
print("configureWithOpaqueBackground")
toolBarAppearance.configureWithOpaqueBackground()
print(toolBarAppearance.backgroundColor)
print(toolBarAppearance.backgroundImage)
print(toolBarAppearance.backgroundEffect)
print(toolBarAppearance.shadowColor)
print(toolBarAppearance.shadowImage)
print("configureWithDefaultBackground")
toolBarAppearance.configureWithDefaultBackground()
print(toolBarAppearance.backgroundColor)
print(toolBarAppearance.backgroundImage)
print(toolBarAppearance.backgroundEffect)
print(toolBarAppearance.shadowColor)
print(toolBarAppearance.shadowImage)
print("configureWithTransparentBackground")
toolBarAppearance.configureWithTransparentBackground()
print(toolBarAppearance.backgroundColor)
print(toolBarAppearance.backgroundImage)
print(toolBarAppearance.backgroundEffect)
print(toolBarAppearance.shadowColor)
print(toolBarAppearance.shadowImage)

// class UIBarButtonItemAppearance : NSObject, NSCopying, NSSecureCoding
// 일반 버튼
toolBarAppearance.buttonAppearance
// 완료 버튼
toolBarAppearance.doneButtonAppearance

// class UIBarButtonItemStateAppearance : NSObject
// normal 의 세부 설정이 세팅되어 있으면 다른 상태의 세부 설정에도 normal 세팅이 대신 적용됨
toolBarAppearance.buttonAppearance.normal
toolBarAppearance.buttonAppearance.disabled
toolBarAppearance.buttonAppearance.focused
toolBarAppearance.buttonAppearance.highlighted
