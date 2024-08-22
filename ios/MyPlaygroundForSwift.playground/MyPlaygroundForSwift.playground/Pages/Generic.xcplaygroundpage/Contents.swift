import UIKit


// ===============================
// 개요
// ===============================

// Generic 은 class, struct, enum 과 같은 타입 또는 함수에 적용할 수 있으며, 프로토콜에는 associatedType 이라는 고유 Generic 방식을 갖는다.

// 타입에 적용된 Generic 은 유추가 불가능 하므로 사용자가 직접 타입을 지정해야 하는 반면, 함수에 적용된 Generic 은 직접 입력하는 대신 유추가 가능하도록 힌트를 제공해야 한다.

// 기본적으로 Generic 은 컴파일 타임에 타입이 정해진다.


class ABC<T> {
    
}

enum DEF<T> {
    
}

func abc<T>(value: T, closure: (T) -> T) -> T where T: UIView {
    return value
}

func def<T>(closure: (T) -> T) {
    return
}

func eee<T>(closure: () -> T) {
    let temp: T?
}

eee(closure: {
    return true
})

func bbb<T>(closure: (T) -> Void) {
    return
}

bbb(closure: { (a: Int) in
    
})



// ===============================
// Generic 타입 제약
// ===============================

// 다음 2가지의 Generic 타입의 제약을 주는 방식이 가능하다.

// 1.
func eee<T: UIView>(value: T) {
    
}

// 2.
func ccc<T>(value: T) where T: UIView {
    
}



// ===============================
// 예시
// ===============================

func clamp<T>(_ value: T, minVlaue: T, maxValue: T) -> T where T: Comparable{
    return min(max(value, minVlaue), maxValue)
}

