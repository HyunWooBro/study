import Foundation


// ===============================
// 플레이 그라운드 설정
// ===============================

// [Render Documentation]
// 체크하여 아래 마크업 내용을 렌더링 해보기 (RxSwift 예시)

/*:
 > # IMPORTANT: To use **Rx.playground**:
 1. Open **Rx.xcworkspace**.
 1. Build the **RxExample-macOS** scheme (**Product** → **Build**).
 1. Open **Rx** playground in the **Project navigator** (under RxExample project).
 1. Show the Debug Area (**View** → **Debug Area** → **Show Debug Area**).
 ----
 [Previous](@previous) - [Table of Contents](Table_of_Contents)
 */

// 코드 영역

/*:
 ----
## BehaviorSubject
Broadcasts new events to all subscribers, and the most recent (or initial) value to new subscribers.
![](https://raw.githubusercontent.com/kzaher/rxswiftcontent/master/MarbleDiagrams/png/behaviorsubject.png)
*/

// 코드 영역

/*:
 > In this example 🥗 is not printed because `drinksSubject` did not emit any values before 🥗 was received. The last drink (🍾) will be printed whenever `foodSubject` will emit another event.
 */

//: [Next](@next) - [Table of Contents](Table_of_Contents)


// [Build Active Scheme]
// 현재 스키마와 관련된 패키지를 사용할 수 있도록 한다.

// [Import App Types]
// 앱의 타입을 사용할 수 있도록 한다.



// ===============================
// 특정 타입의 커스텀 결과깂
// ===============================

// 다음 리스트는 플레이 그라운드에서 출력할 때 특별하게 포맷되는 타입이다.
/// - `String` and `NSString`
/// - `Int`, `UInt`, and the other standard library integer types
/// - `Float` and `Double`
/// - `Bool`
/// - `Date` and `NSDate`
/// - `NSAttributedString`
/// - `NSNumber`
/// - `NSRange`
/// - `URL` and `NSURL`
/// - `CGPoint`, `CGSize`, and `CGRect`
/// - `NSColor`, `UIColor`, `CGColor`, and `CIColor`
/// - `NSImage`, `UIImage`, `CGImage`, and `CIImage`
/// - `NSBezierPath` and `UIBezierPath`
/// - `NSView` and `UIView`

// 관련 프로토콜
public protocol CustomPlaygroundDisplayConvertible {

    /// A custom playground description for this instance.
    var playgroundDescription: Any { get }
}


// 일반 Date() 결과는 현지 시간에 맞춰서 출력되지만
Date()
// 다른 형태를 사용하면 기본 UTC 시간으로 출력된다.
Date().description
