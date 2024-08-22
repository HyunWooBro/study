import Foundation


// ===============================
// Selector
// ===============================

class Dog {
    var num = 1.0
    
    @objc var double: Double {
        get {
            return num * 2.0
        }
        set {
            num = newValue / 2.0
        }
    }
    
    @objc func run() {
        print("run")
    }
    
    @objc func run(abc: Int) {
        print("run")
    }
}

// 계산 프로퍼티의 getter, setter 접근
let getterSelector = #selector(getter: Dog.double)
let setterSelector = #selector(setter: Dog.double)

// 일반 메서드 접근
//let runSelector = #selector(Dog.run)
let runSelector = #selector(Dog.run(abc:))





// ===============================
// KeyPath
// ===============================

// KeyPath 의 의의는 런타임 접급을 위한 문자열 접근 방식을 사용하면서 컴파일타임에 타입을 체크할 수 있다는 것이다.

// forKey vs. forKeyPath
//

@objc
class ABC: NSObject {
    @objc var name = "234"
    @objc var arr: [ABC] = []
}

#keyPath(ABC.name)
#keyPath(ABC.arr.name)
\ABC.name
\ABC.arr.first?.name

var abc = ABC()
abc.arr += ([ABC(), ABC()])
abc.name
abc.value(forKey: "name")
abc.value(forKey: #keyPath(ABC.name))
abc[keyPath: \ABC.name]
abc.value(forKeyPath: #keyPath(ABC.name))
abc.value(forKey: #keyPath(ABC.arr))
print(abc.value(forKeyPath: #keyPath(ABC.arr.name)))
abc.setValue("567", forKey: #keyPath(ABC.name))
abc.setValue("567", forKeyPath: #keyPath(ABC.name))
abc.name

