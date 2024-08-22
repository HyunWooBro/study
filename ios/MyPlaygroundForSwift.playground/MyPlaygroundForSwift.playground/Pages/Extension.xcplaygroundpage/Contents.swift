import UIKit


// ===============================
// 저장 프로퍼티 추가
// ===============================

// 기본적으로 확장에서는 저장 프로퍼티를 가질 수 없지만 다음의 방법을 사용하면 가능하다.

// objc_getAssociatedObject
// objc_setAssociatedObject

// objc_AssociationPolicy 는 다음 5가지의 선택지가 있다.
// weak 참조
// OBJC_ASSOCIATION_ASSIGN
// strong 참조
// OBJC_ASSOCIATION_RETAIN_NONATOMIC
// strong 참조, 복사본
// OBJC_ASSOCIATION_COPY_NONATOMIC
// strong 참조, 스레드 안전성
// OBJC_ASSOCIATION_RETAIN
// strong 참조, 복사본, 스레드 안전성
// OBJC_ASSOCIATION_COPY

// 일반적으로 효율적이며 강한 참조를 사용하는 OBJC_ASSOCIATION_RETAIN_NONATOMIC 를 사용하는 것으로 보인다.

// 예시
private struct AssociatedKeys {
    // key 는 Any 타입이 가능하지만 Void? 타입이 가장 간단한 것으로 보임
    static var key1: Void?
    static var key2 = 1234
    static var key3 = "string"
}

extension UIView {
    var index: Int {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.key1) as? Int ?? 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.key1, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

let view = UIView()
view.index = 3
print(view.index)



// ===============================
// 메서드 오버라이딩
// ===============================

// 기본적으로 확장에서는 메서드 오버라이딩이 허용되지 않지만 @objc 를 상위뷰에서 추가하는 방식으로 우회하여 오버라이딩을 할 수는 있다.

class Super: NSObject {
    @objc
    dynamic func abc() { }
}

class Child: Super {
}

extension Child {
    override func abc() { }
}


// 상위 클래스의 메서드를 하위 클래스의 확장에서 오버라이딩만 제한되어 있는 것이 아니라 상위 클래스의 확장에서 정읟된 메서드도 하위 클래스에서 오버라이딩이 제한되어 있다. 마찬가지로 @objc 를 통해 우회할 수는 있다.

class Fruit {
    func base() {
        
    }
}

extension Fruit {
    @objc
    func extend() -> Bool {
        return false
    }
}

class Banana: Fruit {
    override func base() {
        
    }
    
    override func extend() -> Bool {
        return true
    }
}


// 결국 오버라이딩은 클래스와 클래스의 상속 관계에서 사용하는 것이 기본이다.



// ===============================
// 프로토콜 디폴트 구현
// ===============================

// 클래스, 구조체, 열거형처럼 신규 메서드를 추가할 수도 있지만 프로토콜의 경우 인터페이스의 디폴트 구현도 추가할 수 있다.

protocol Car {
    func drive()
}

extension Car {
    // 디폴트 구현
    func drive() { }
    
    // 메서드 추가
    func explode() { }
}


// 프로토콜의 관점에서 디폴트 구현과 신규 메서드 추가는 의미적으로 다음과 같이 해석할 수 있겠다.
// - 디폴트 구현 : 프로토콜을 준수하는 타입에서 신규로 구현할 가능성은 남겨둔 상태로 기본적인 구현을 제공
// - 메서드 추가 : 프로토콜을 준수하는 타입에서 구현할 필요가 없는 기본적으로 제공하는 메서드



// ===============================
// 기타
// ===============================

// 프로토콜 확장에서는 다른 프로토콜을 준수할 수 없다.

protocol Protocol1 { }
protocol Protocol2 { }
// 가능
protocol Protocol3: Protocol1 { }
// 불가
extension Protocol3: Protocol2 { }
