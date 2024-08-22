import UIKit

// ===============================
// 앱 아이콘 뱃지
// ===============================

// 아래 방식은 iOS 17 부터 Deprecated
UIApplication.shared.applicationIconBadgeNumber = 5
// 다음 API 는 iOS 16 에서부터 권장하는 방식
UNUserNotificationCenter.current().setBadgeCount(5)



// ===============================
// 탭바 아이콘 뱃지
// ===============================

// 첫번째 탭바 아이콘에 뱃지 설정
UIViewController().tabBarController?.tabBar.items?[0].badgeValue = "5"


