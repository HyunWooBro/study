

// ===============================
// 개요
// ===============================

// Swift 는 다중 상속을 허용하지 않는다.

// 상속보다는 POP(Protocol Oriented Programming) 을 권장하는 편이다.



// ===============================
// 테스트
// ===============================

// 배열 상속 테스트
class A {}

class B: A {}

let aa: [A] = []
let bb: [B] = []

// 자바와 달리 Swift 는 서브클래스 배열도 상속관계에 있음
if bb is [A] {
    print("true")
}

if aa is [Any] {
    print("true")
}


// 옵셔널도 가능
let aaa: A? = A()
let bbb: B? = B()

if bbb is A? {
    print("true")
}


// 다른 언어와 마찬가지로 반환타입은 하위클래스로 반환이 가능하다.
class C {
    func funA(a: A) -> A {
        return A()
    }
}

class D: C {
    override func funA(a: A) -> B {
        return B()
    }
}


// 배열 뿐만 아니라 옵셔널도 역시 상속관계에 영향 없음
protocol TestSub {
    var a: A? { get }
}

class TestClass: TestSub {
    var b: B? = B()
    
    var a: A? {
        return b
    }
}

let testClass = TestClass()

testClass.a
