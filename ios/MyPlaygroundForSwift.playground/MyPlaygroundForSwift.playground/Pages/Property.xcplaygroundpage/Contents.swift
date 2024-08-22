import Foundation


// ===============================
// 개요
// ===============================

// 프로퍼티는 계산 프로퍼티와 저장 프로퍼티로 나뉜다.
// 계산 프로퍼티는 var 속성만 가능하며 기본적으로 확장에 추가할 수 있다.
// 저장 프로퍼티는 lazy 및 let/var 속성이 가능하며 기본적으로 확장에 추가할 수 없다.
// 모두 오버라이딩이 가능하다.



// ===============================
// 계산 프로퍼티 (Computed Property)
// ===============================

// 계산 프로퍼티는 getter 및 setter 를 추가하여 값에 접근 및 값의 주입이 가능하다.
var computedProperty: Int {
    // 값에 읽기로 접근할 경우 호출된다.
    get { }
    // 값에 쓰기로 접근할 경우 호출된다.
    set(newValue) { }
}

// set 에서 자기 자신의 값을 설정하면 재귀적으로 호출된다. 따라서 값을 저장하기 위해서는 backing storage 역할을 하는 저장 프로퍼티를 함께 사용하는 것이 일반적이다.


// 기본 예시
class ComputedSuper {
    var computedProperty: Int {
        get {
            return 3
        }
        set {
            print("ComputedSuper set")
        }
    }
}

// 오버라이딩 예시
class ComputedSub: ComputedSuper {
    override var computedProperty: Int {
        get {
            let result = super.computedProperty
            print("result : \(result)")
            return 5
        }
        set {
            super.computedProperty = 2
            print("ComputedSub set")
        }
    }
}

let computedSub = ComputedSub()
computedSub.computedProperty = 10
print("ComputedSub get : \(computedSub.computedProperty)")

// get 전용 예시
class ComputedProperty {
    var getOnly: Int {
        get {
            return 3
        }
    }
}

// 계산 프로퍼티의 getter 및 setter 는 저장 프로퍼티를 오버라이딩하여 추가할 수도 있다.
class OveridingTest {
    var storedProperty = 3
}
class OveridingTestSuper: OveridingTest {
    override var storedProperty: Int {
        get {
            let result = super.storedProperty
            print("result : \(result)")
            return 5
        }
        set {
            super.storedProperty = 2
            print("ComputedSub set")
        }
    }
}



// ===============================
// 저장 프로퍼티 (Stored Property)
// ===============================

// 일반적으로 말하는 변수 또는 상수의 역할을 한다.

// 값 타입 또는 레퍼런스 타입에 따라 변수와 상수의 의미가 다르다.

// 초기화를 코드에서 접근하기 전까지 늦추는 lazy 속성을 사용할 수 있다. 자세한 내용은 'Lazy' 참조
