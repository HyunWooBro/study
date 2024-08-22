import UIKit


// ===============================
// KVC (Key-Value Coding)
// ===============================

// 객체의 값을 직접적으로 접근하는 것이 아닌, Key 또는 KeyPath 를 통해 간접적으로 접근

// Objective-C 런타임에 의존하는 기술이기 때문에 다음의 조건을 만족해야 함
// 1. NSObject 상속 필요
// 2. @objc 어노테이션 필요



// ===============================
// KVO
// ===============================

// 과거 방식
// 오버라딩 필요
let view = UIView()
view.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, options: <#T##NSKeyValueObservingOptions#>, context: <#T##UnsafeMutableRawPointer?#>)
view.removeObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>)


view.observeValue(forKeyPath: <#T##String?#>, of: <#T##Any?#>, change: <#T##[NSKeyValueChangeKey : Any]?#>, context: <#T##UnsafeMutableRawPointer?#>)


// 신규 방식 (Swift 4 부터 도입)
view.observe(\.view.anchor, options: [.old, .new]) { (object, change) in
    change.oldValue
    change.newValue
}


// KeyPath 에 의해 접근하는 모든 프로퍼티는 다음을 준수해야 함
@objc dynamic


// UIKit 에서 제공하는 프로퍼티가 모두 KVO 의 대상이 되는 것은 아님
let textView = UITextView()
// 예를 들어, 다음 text 프로퍼티는 KVO 활용이 불가하다. 내부적으로 저장 프로퍼티로 따로 관리되기 때문으로 보임
textView.text
// 프로퍼티 옵저버도 역시 불가능하다. 자세한 내용은 'Property' 참조



// ===============================
// KVO vs. 프로퍼티 옵저버
// ===============================

// 프로퍼티 옵저버는 정의부에 종속되어 관찰하는 형태라면 KVO는 외부에서도 관찰이 가능
// 프로퍼티 옵저버는 NSObject 상속하지 않아도 가능
// KVO 는 내부 프로퍼티까지 관찰 가능


