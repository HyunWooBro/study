import Foundation


// ===============================
// 개요
// ===============================

// GC(Garbage Collection) 방식의 자바와는 달리 Swift 는 RC(Referece Counting) 방식으로 메모리를 관리한다. 특히, Swift 는 컴파일러에 의해 자동으로 레퍼런스 카운팅 되는 경우에는 ARC(Automatic Reference Couting) 방식을 사용한다.



// ===============================
// strong vs. weak vs. unowned
// ===============================

// strong : retain(reference) count 를 증가시키는 강한 참조이다.
// weak : retain(reference) count 를 증가시키지 않는 약한 참조이다. weak 변수는 옵셔널 타입만 가능하다. 강한 참조의 개수가 0이 되어 무효화되면 nil 로 세팅되기 때문이다.
// unowned : retain(reference) count 를 증가시키지 않는 약함 참조이다. 옵셔널 타입으로 사용할 수 없다. 개발자의 제어 하에 있는 경우에만 사용하여 코드를 간결하게 만들 수 있다. weak 의 경우에는 retain count 가 0이 되면 weak 변수를 전부 찾아 nil 로 세팅해야 하는 오버헤드가 있지만 unowned 에는 없다. Swift 5.0 부터 옵셔널 타입을 지원한다. !!!: unowned 는 Optional 타입을 강제로 unwraping 하는 것과 유사하다. 즉, 확실한 경우에만 사용하라는 것이다.

// 객체를 메모리에서 해제하기 위한 조건은 강한 참조의 개수가 0이 되는 것이다. 객체에 대한 약한 참조의 개수는 메모리 해제의 조건에 영향이 없다.



// ===============================
// Retain Cycle
// ===============================

// 메모리 관리에서 중요한 부분은 클로저에서 self 의 사용 여부이다. 클로저 내부에서 컨테이너 객체를 강하게 참조하고 컨테이너 객체는 클로저를 포함하면서 강하게 참조하는 상황에서 컨테이너 객체에 대한 참조를 잃는다면, 프로그램이 종료되기 전까지는 이들 객체를 해제할 방법이 없다. 이러한 이슈를 순환 참조(Retain Cycle) 라고 한다. 이러한 문제를 피하기 위해서는 클로저에서 self 를 참조할 때 약한 참조를 사용해야 한다.

// 클로저의 순환 참조를 피하는 정석은 [weak self] 를 사용하는 것이다. 단, 클로저 내부에 또 다른 클로저가 있을 경우에 다음의 경우를 주의해야 한다.
let outerClosure = { [weak self] in
    guard let self = self else { return }
    self.member
    let innerClosure = {
        // !!!: 내부 클로저에서도 외부 클로저의 강한 참조를 사용하면 Retain Cycle 이 발생할 수 있다.
        self.member
    }
}

// 앞선 예제처럼 [weak self] 과 함께 guard let self = self else { return } 문을 함께 사용하는 경우가 많다. 이 구문을 사용하는 것과 사용하지 않는 것을 비교해 보자.
// - 사용O : 클로저가 실행되기 전에 self 가 해제된 경우에는 클로저가 실행되지 않는다. 또한 클로저가 실행된 이후에는 self 의 해제를 지연시킬 수 있다.
// - 사용X : 클로저 실행 중에 self 가 해제되면 작업이 중간에 종료될 수 있다.

// escaping 가능한 클로저에서만 순환 참조가 발생할 수 있고, non-escaping 클로저에서는 순환 참조가 발생하지 않는다. 다음과 같이 escaping 클로저라 하더라도 완료 시점이 명확한 경우에는 순환 참조에 대한 우려가 적다.
// 1. GCD 실행
DispatchQueue.main.asyncAfter(deadline: 5) {
    
}
// 2. 애니메이션 실행
UIView.animate(withDuration: 5) {
    
}

// 순환 참조가 반드시 클로저에서만 발생하는 것은 아니다. 단순히 여러 객체가 서로를 순환해서 참조하는 경우에도 발생한다. 만약 A 객체가 B 객체를 참조하고 있고 B 객체에서도 A 객체를 참조하고 있다면 한 객체는 다른 객체를 weak 로 참조하는 것이 좋다.

// 참고로 아래 함수를 통해 retain count 값을 확인할 수 있다.
CFGetRetainCount(<#T##cf: CFTypeRef!##CFTypeRef!#>)



// ===============================
// 간단한 Retain Cycle 테스트
// ===============================

// ClassA <-> closure
class ClassA {
    
    var closure: () -> Void = { }
    
    func methodA() {
        closure = {
            _ = self
        }
    }
    
    func methodB() {
        closure = { [weak self] in
            _ = self
        }
    }
    
    deinit {
        print("ClassA deinit")
    }
}


var strongRef: ClassA? = ClassA()

// methodA() 를 호출하고 strongRef 를 무효화하더라도 deinit 이 호출되지 않는 것을 확인할 수 있다. ClassA 를 강하게 참조하고 있던 요소가 strongRef 뿐만 아니라 ClassA 내부의 closure 도 있기 때문이다.
//strongRef?.methodA()

// methodB() 를 호출하면 deinit 이 호출된다. 이때 ClassA 를 참조하는 객체는 2가지인데 하나는 강한 참조인 strongRef 와 약한 참조인 closure 로 구성되어 있다. 강한 참조의 개수가 0이 되므로 메모리에서 해제되는 것을 볼 수 있다.
//strongRef?.methodB()

strongRef = nil



// ===============================
// 복잡한 Retain Cycle 테스트
// ===============================

// ClassB -> ClassC -> closure -> ClassB -> ...
class ClassB {
    
    var classC = ClassC()
    
    func methodA() {
        classC.methodA {
            _ = self
        }
    }
    
    deinit {
        print("ClassB deinit")
    }
}

class ClassC {
    
    var closure: () -> Void = { }
    
    func methodA(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    deinit {
        print("ClassC deinit")
    }
}


var classB: ClassB? = ClassB()
classB?.methodA()

classB = nil
