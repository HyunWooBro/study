

// ===============================
// 개념
// ===============================

// display style
public enum DisplayStyle : Sendable {
    case `struct`
    case `class`
    case `enum`
    case tuple
    case optional
    case collection
    case dictionary
    case set
}

do {
    struct Point {
        var x: Int
        var y: Int
    }
    
    let p = Point(x: 10, y: 10)
    
    // 내부적으로 Mirror 을 사용함
    print(String(reflecting: p))
    dump(p)
    
    
    let mirror = Mirror(reflecting: p)
    print(mirror.subjectType)
    print(mirror.displayStyle)
    print(mirror.children)
    
    mirror.children.forEach {
        print($0.label, "=", $0.value)
    }
}

// ===============================
// 응용
// ===============================

// private 멤버 접근
do {
    class ClassA {
        private var name = "abc"
    }
    
    var object = ClassA()
    // private 멤버 접근 에러
    //object.name
    
    let mirror = Mirror(reflecting: object)
    let name = mirror
        .children
        .first { label, _ in
            return label == "name"
        }?
        .value
}
