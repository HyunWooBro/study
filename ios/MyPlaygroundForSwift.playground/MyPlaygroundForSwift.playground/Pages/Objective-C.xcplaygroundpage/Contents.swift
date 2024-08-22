

// ===============================
// 개요
// ===============================



// ===============================
// NSObject
// ===============================

class

let object = NSObject()

object.perform



extension


UIView().perform(<#T##aSelector: Selector##Selector#>, on: <#T##Thread#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>, modes: <#T##[String]?#>)

performSelector(onMainThread: <#T##Selector#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>, modes: <#T##[String]?#>)



// ===============================
// @objc
// ===============================

// 스위프트는 가급적 스위프트 런타임으로 동작하려고 한다. 하지만 기존의 Objective-C 의 기능이 필요할 경우에는 Objective-C 런타임을 사용해야 한다. Objective-C 에서 Swift 에 접근할 수 있도록 보조하는 것이 바로 @objc 이다.


// @IBOutlet 및 @IBActiohn 는 @objc 를 이미 포함하는 것으로 보인다.


// KVC 를 사용하기 위해서는 @objc 가 필요한데 그럴려면 class 여야 가능함
// @IBOutlet Collection 을 사용하면 요소가 아니라 배열 자체에



// ===============================
// Swift <-> Objective-C 연동
// ===============================

// 브릿지 헤더 파일
