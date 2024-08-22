

// lazy 변수에는 3가지 종류가 있다.

// ===============================
// 1. instance 변수
// ===============================

// lazy 멤버 변수는 lazy 멤버 변수를 포함하여 다른 멤버 변수에 자유롭게 접근 가능
// lazy 변수의 초기화는 일반적인 변수의 초기화 방법인 (1) self-executing closure 또는 (2) 직접 대입 모두 가능하다.
class TestA {
    
    // #1
    lazy var a = {
        print("a initialized")
        print(d)
        return self.b
    }()
    
    // #1
    lazy var b = {
        print("b initialized")
        return 3
    }()
    
    // #2
    lazy var c = String("c initialized")
    
    var d = "test"
}

var aa = TestA()
aa.a



// ===============================
// 2. static 변수
// ===============================

// static 변수는 암묵적으로 lazy 속성 (호출될 때에만 초기화됨)
class ABC {
    static let bbb: Int = {
        print("bbb initialized")
        return 1
    }()
}

var abc = ABC()
ABC.bbb



// ===============================
// 3. global 프로퍼티
// ===============================

// global 변수는 암묵적으로 lazy 속성 (호출될 때에만 초기화됨)
//lazy var view = ABC()
