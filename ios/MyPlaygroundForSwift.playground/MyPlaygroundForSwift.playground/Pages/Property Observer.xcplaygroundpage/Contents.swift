import Foundation
import UIKit


// ===============================
// 개요
// ===============================

// 프로퍼티 옵저버는 (1) 변수형(var) 저장 프로퍼티에 추가하거나 (2) 계산 프로퍼티를 오버라이딩하여 추가할 수 있다.
var storedProperty = 10 {
    // 값이 바뀌기 바로 직전에 호출된다. newValue 생략 가능
    willSet(newValue) { }
    // 값이 바뀐 바로 직후에 호출된다. oldValue 생략 가능
    didSet(oldValue) { }
}



// ===============================
// 예시
// ===============================

// 기본 예시
class StoredSuper {
    var count = 1 {
        willSet {
            // 주의) newValue 는 상수이기 때문에 수정 불가
            // newValue = newValue > 9 ? 9 : newValue
            // 주의) willSet 이 종료된 직후 newValue 값으로 바뀌기 때문에 직접 count 값을 수정하는 것은 의미 없음
            // count = count > 9 ? 9 : count
            print("newValue : \(newValue), count : \(count)")
        }
        didSet {
            // set 의 결과를 바꾸기 위해서는 didSet 에서 처리
            // !!!: 기본적으로 자기 자신의 값을 변경하더라도 재귀적으로 호출되지 않는다. 단, 구현 방식에 따라 재귀적으로 호출될 수도 있다. 아래 예시 참조.
            count = count > 9 ? 9 : count
            print("oldValue : \(oldValue), count : \(count)")
        }
    }
}

let storedSuper = StoredSuper()
storedSuper.count = 10


// 오버라이딩 예시 (메서드 오버라이딩과 달리 덮어씌우지 않음)
class StoredSub: StoredSuper {
    override var count: Int {
        willSet {
            // 자식 -> 부모 순서로 호출됨
            print("StoredSub willSet")
        }
        didSet {
            // 부모 -> 자식 순서로 호출됨
            print("StoredSub didSet")
        }
    }
}

let storedSub = StoredSub()
storedSub.count = 10


// IBOutlet 예시 (IB와 연결된 직후에 초기화 하는 용도로 사용 가능)
@IBOutlet var texts: UITextView! {
    didSet {
        
    }
}



// ===============================
// 주의사항
// ===============================

// [최초 초기화 관련]
// 최초 초기화되는 경우에는 호출되지 않는다.
// lazy 를 활용하여 초기화 시점을 늦추는 경우에도 마찬가지다.
var number = 5 {
    didSet {
        // 5로 초기화 되더라도 호출되지 않는다.
    }
}

// [UIKit 프로퍼티 관련]
// UITextView 의 text 와 같은 프로퍼티에 옵저버 프로퍼티를 추가하면 여러 이슈가 발생한다.
override var text: String! {
    // 1. 코드로 변경하지 않으면 옵저버가 호출되지 않음
    didSet {
        // 2. text 를 세팅하면 재귀적으로 호출됨
        text = text + "."
    }
}

// 이 이슈의 원인은 UIKit 프로퍼티의 내부 구현 방식 때문인 것으로 보인다.
// 예를 들어, UITextView 내부 구현을 모방한 예시를 살펴보자.
// 아래와 같은 모습인 경우 앞에서 언급한 두가지 이슈가 발생하는 것을 확인할 수 있다.
// 참조: https://stackoverflow.com/questions/66853486/uitextfield-in-swift-text-didset-not-called-when-typing
class UITextViewDemo {
    private var internalText: String = ""
    var text: String  {
        get {
            internalText
        } set {
            internalText = newValue
        }
    }

    // This method is just to demonstrate that when you update the internalText didSet is not called
    func updateInternalTextWith(text: String) {
       internalText = text
    }
}
class MyTextView: UITextViewDemo {
    override var text: String {
        didSet {
            
        }
    }
}
let textView = MyTextView()
textView.text = "abc"
