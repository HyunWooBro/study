


// ===============================
// 개념
// ===============================

// 단항 연산자는 공백없이 반드시 붙여서 사용
// 이항 연산자는 양쪽에 공백을 추가하거나 양쪽을 모두 붙여서 사용 가능 (비대칭적 사용 금지)
// 삼항 연산자는 ? 앞의 공백을 두어야 함



// ===============================
// 오버플로우 연산자
// ===============================

// Swift 에서는 기본적을 오버플로우가 발생하면 에러가 발생하지만 오버플로우 연산자를 사용하면 에러가 발생하지 않음

var a: Int8 = Int8.max
a = a &+ 1
//a = a + 1

var b: Int8 = Int8.min
b = b &- 1
//b = b - 1

var c: Int8 = 10
c = c &* 100
//c = c * 100


// ===============================
// 커스텀 타입의 연산자 메서드
// ===============================

// 커스텀 타입에서 연산자 메서드를 사용하려면 타입 메서드로 직접 구현 (비교 연산자는 관련 프로토콜를 추가하여 구현)

// prefix
// postfix
// infix (생략가능)

// Equtable => == 연산자 구현하면, != 연산자 자동 구현
// Comparable => < 연산자 구현하면, <=, >, >= 연산자 자동 구현

// == vs. ===
// == : 스택 영역의 값을 비교 (Class 의 경우, 내부 상태를 비교하기 위해서는 직접 구현해야 함)
// === : 힙 영역의 값(주소)를 비교 (Equtable 과 상관없이 기본적으로 구현됨)



// ===============================
// 사용자 정의 연산자
// ===============================

// 정해진 기호 내에서 마음껏 연결하여 생성 가능

// prefix
// postfix
// infix

// AdditionPrecedence
// MultiplicationPrecedence

// infix
infix operator **||||>: AdditionPrecedence
func **||||>(left: Int, right: Int) -> Int {
    return left + (right * 2)
}

var test = 4 **||||> 5

// prefix
prefix operator +*+
prefix func +*+(value: Int) -> Int {
    return value * 3
}

var test2 = +*+10

// postfix
postfix operator --*
postfix func --*(value: Int) -> Int {
    return value * 5
}

var test3 = 10--*

// postfix 를 활용하여 % 기능도 추가할 수 있다.
public struct Percent {
    let value: Double
}

postfix operator %
postfix func % (v: Double) -> Percent {
    return Percent(value: v)
}
postfix func % (v: Int) -> Percent {
    return Percent(value: Double(v))
}

var percent = 50%



// 사용자 정의 연산자의 우선순위도 지정 가능
precedencegroup FormPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}
