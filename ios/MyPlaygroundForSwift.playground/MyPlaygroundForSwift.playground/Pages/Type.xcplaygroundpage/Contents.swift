import Foundation
import SwiftUI
import UIKit


// ===============================
// Type vs. Self vs. self
// ===============================

// [Type]
// 1. 타입에 대한 메타타입을 나타냄

// [Self]
// 1. 런타임 시점의 class, struct, enum 타입을 나타냄
// 2. 프로토콜의 where 문과 함께 제약을 정의할 수 있음

// [self]
// 1. 현재 문맥을 감싸는 class, struct, enum 인스턴스를 나타냄
// 2. 메타타입 Type 의 값을 의미
// 3. 클로저를 감싸는 class, struct, enum 인스턴스를 캡처하기 위해
// 4. 이름 충돌을 방지하기 위해

// Self_2
protocol Drawable where Self: NSObject {
    // Self_1
    func draw() -> Self
}

class Painter: NSObject, Drawable {
    
    required override init() {
        super.init()
        
        33.self
        Int.self
    }
    
    // Self #1
    func draw() -> Self {
        // slef #1
        return self
    }
    
    func drawAfter() {
        DispatchQueue.main.async {
            // self #3
            self.draw()
        }
    }
    
    struct Brush {
        static func static1() { 
            // Self #1
            let instance = Self.static2(
                // self #2
                type: Painter.self
            )
            instance.draw()
        }
        
        // Type #1
        static func static2<T: Painter>(type: T.Type) -> T {
            return T()
        }
        
        var color = UIColor.clear
        
        mutating func draw(with color: UIColor) {
            // self #4
            self.color = color
            // Self #1
            Self.static1()
        }
    }
}



// ===============================
// Self 제약 관련
// ===============================

// 클래스가 아닌 경우 특별한 제약은 없음
enum NotClass {
    case a
    case b
    
    var computedProperty: Self {
        return .a
    }
    
    func func1(value: Self) -> Self {
        return value
    }
    
    func func2(closure: (Self) -> Self) -> [Self] {
        return [closure(.a), closure(.b)]
    }
}

// 클래스의 경우에는 몇가지 제약이 있음 (클래스의 상속 가능성 때문)
class Class {
    required init() { }
    
    // 저장 프로퍼티 타입으로 Self 사용 불가
    var storedProperty: Self?
    
    // 계산 프로퍼티에서 반환타입으로 Self 가능
    var computedProperty: Self {
        return self
    }
    
    // 메서드의 파마미터로 Self 사용 불가
    func func1(value: Self) { }
    
    // 클로저의 파라미터 및 반환타입, 그리고 메서드의 반환타입으로 Self 가능
    func func2(closure: (Self) -> Self) -> Self {
        return closure(self)
    }
    
    // 메서드의 반환타입으로 순수 Self 이외의 타입은 사용 불가
    func func3() -> [Self] {
        
    }
}

// 프로토콜을 통해 클래스의 제약을 우회할 수 있음
// 참조: https://stackoverflow.com/questions/55549509/self-type-as-argument-in-closure
protocol Workaround: Class {
    // 메서드의 반환타입으로 어떠한 형태의 Self 사용 가능
    func funcA() -> Self.Type
}

extension Workaround {
    func funcA() -> Self.Type {
        return Self.self
    }
    
    // 메서드의 파라미터로 Self 사용 가능
    func funcB(instance: Self, closure: @escaping (Self) -> Self) -> Self {
        closure(instance)
        // 프로토콜 확장에서의 self 는 프로토콜을 확장하는 class, struct, enum 인스턴스를 의미
        return self
    }
}



// ===============================
// some vs. any
// ===============================

// [some]
// 불투명 타입
// Swift 5.1 부터 도입
// 역 Generic 타입이라고도 한다. Generic 은 실제 타입을 내부에서는 알 수 없고 외부에서 결정하는 것이라면, 불투명 타입은 실제 타입을 외부에서는 알 수 없고 내부에서 결정하기 때문이다.

// [any]
// 추상화 타입
// Swift 5.6 부터 도입

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
    }
}


// 변수와 상수 유형을 정할 때 기본적으로 let 을 사용하고 변할 수 있는 경우에만 var 을 사용하는 것이 정석이듯이 기본적으로 some 을 사용하고 필요한 경우에만 any 을 사용하는 것을 권장한다고 한다.


// some 은 프로토콜 메서드의 리턴 타입으로 사용할 수 없다.
protocol Shape {
    func describe(shape: any Shape) -> any Shape
    func describe(shape: some Shape) -> some Shape
}


// some 배열 초기화시에만, 같은 원소로만 가능
class Rectanle: Shape {}
class Triangle: Shape {}
var abc: [some Shape] = [Rectanle(), Rectanle()]
var def: [some Shape] = [Rectanle(), Triangle()]
var ghi: [some Shape] = []


// 또한 some 은 Generic 대신에 사용 가능
protocol Associated {
    associatedtype T
    func method(t: T)
}
class ClassA {
    func methodA<T: Associated>(param: T) { }
    func methodB(param: some Associated) { }
}
let classA = ClassA()
classA.methodA(param: <#T##Associated#>)
classA.methodB(param: <#T##Associated#>)


// Generic 을 컴파일타임에 컴파일러가 파악하듯이, some 도 컴파일타임에 컴파일러가 파악
// 하지만 둘다 직접적으로 개발자에게 제공하지 않는 것으로 보임



// ===============================
// any vs. Any...
// ===============================

// RawRepresentable 준수하면 -> any


// 연관변수(associatedtype)를 갖는 프로토콜은 직접 사용하면 에러가 발생하여 다음과 같이 구조체로 제공
// AnyHashable vs. any Hashable
// AnySequence vs. any Sequence
// AnyCollection vs. any Collection


var aa = [1,2,3]

var cc: any Collection = aa

var bb = AnyCollection(aa)

if bb is AnyCollection<Int> {
    print("anysequence")
}

func xxx<T>(a: T) {
    if a is any Sequence {
        print("xxx")
    }
}

func yyy(a: Any) {
    if a is any Sequence {
        print("yyy")
    }
}

xxx(a: [2])

yyy(a: [2])





// Int -> Int.Type
// 4   -> Int.self

func typeTest<T>(aaa: [T].Type, bbb: [T], ccc: Int.Type) {
    print(T.self)
    print([T].self)
    print(aaa)
    print(bbb)
    print(bbb.self)
    print(ccc)
    print(ccc.self)
//    print(Self)
    
}

typeTest(aaa: [Int].self, bbb: [3, 4], ccc: Int.self)



protocol ArrayType {}

extension Array: ArrayType {}
extension NSArray: ArrayType {}

protocol DictonaryType {}

extension Dictionary: DictonaryType {}
extension NSDictionary: DictonaryType {}

protocol SetType {}

extension Set: SetType {}
extension NSSet: SetType {}



var aaa = [1,2,3]
var bbb = [1:"efe"]

func testType(type: Any) {
    if type is (any Sequence) {
        print("type is Sequence")
    }
    
    if type is (any Collection) {
        print("type is Collection")
    }
    
    if type is (Array<Any>) {
        print("type is Array<Any>")
    }
    
    if type is ArrayType {
        print("type is ArrayType")
    }
    
    if type is Dictionary<AnyHashable, Any> {
        print("type is Dictionary<AnyHashable, Any>")
    }
    
    if type is DictonaryType {
        print("type is DictonaryType")
    }
}
print("test aaa")
testType(type: aaa)
print("test bbb")
testType(type: bbb)



// ===============================
// AnyHashable
// ===============================

// Swift 5.6 에서 추가된 any 를 이용할 수 있음
// AnyHashable -> any Hashable

// AnyHashable 테스트
let a: AnyHashable = "1"
let b: AnyHashable = "1"

if a == b {
    print("same")
} else {
    print("not same")
}


// AnyHashable 테스트
var dict = Dictionary<AnyHashable,Any>()
dict[1] = "integer"
dict["2"] = "string"
print(dict)



// ===============================
// 타입 변환
// ===============================

// Int -> String
var intToStr = String(10)

// String -> Int
var strToInt = Int("123")

// String -> Double
var strToDouble = Double("10.33")

// Int -> Double
var intToDouble = Double(10)

// Double -> Int
var doubleToInt = Int(10.5)

// String -> Data
var strToData: Data? = "string".data(using: .utf8)

// Data -> String
var dataToStr = String(decoding: strToData!, as: UTF8.self)

// String -> Date
var dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd\'T\'HH:mm:ss\'.000\'z"
dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
var strToDate = dateFormatter.date(from: "2023-01-01T01:00:00.000Z")

// Date -> String
var dateToStr = Date().formatted()

// Array -> Set
var arrToSet = Set([1,2,3,3])

// Set -> Array
var setToArr = Array(arrToSet)


Data(base64Encoded: <#T##Data#>)
Data(<#T##elements: Sequence##Sequence#>)
Data(bytes: <#T##UnsafeRawPointer#>, count: <#T##Int#>)
Data(contentsOf: <#T##URL#>)
Data(referencing: <#T##NSData#>)



// ===============================
// 튜플과 클로저
// ===============================

// 튜플과 클로저의 파라미터는 미묘한 관계를 갖는 것으로 보인다.

// String 과 Int 파라미터 2개를 갖는 함수
func closure(a: String, b: Int) { }

// String 과 Int 튜플을 closure 함수로 전달하지만 오류가 발생하지 않음
Observable<(String, Int)>.just(("123", 10))
    .map(closure)
    .subscribe(onNext: {
        print("onNext")
    })

// RxSwift 뿐만 아니라 기본 Collection map() 에서도 역시 오류가 없음
[1,2,3].map({
    return ("123", $0)
})
.map(closure)


// 얼핏보면 튜플은 클로저의 파라미터와 대응할 수 있다고 생각되지만 항상 그런 것은 아니다.

// 다음 코드는 출처에서 제시하는 예시 코드이다. 2018년도 결과와 비교하여 현재의 Swift 구현이 변경되었음을 알 수 있다.
// 출처: https://stackoverflow.com/questions/48793605/distinguishing-tuple-and-multi-argument-functions

func tuple(value: (Int, Int)) {}
func two(value: Int, value2: Int) {}

// (1)
func take(f: (Int, Int) -> Void) {}
take(f: tuple)  // 출처와 달리 현재는 오류가 발생하지 않는다.
take(f: two)

// (2)
func take(f: ((Int, Int)) -> Void) {}
take(f: tuple)
take(f: two)

// (3)
var f: (Int, Int) -> Void
f = tuple       // 출처와 달리 현재는 오류가 발생한다.
f = two

// (4)
var g: ((Int, Int)) -> Void
g = tuple
g = two         // 출처와 달리 현재는 오류가 발생한다.

// (1), (3), (4) 의 결과를 보면 현재 Swift 는 튜플과 클로저의 파라미터를 별개로 취급한다는 것을 알 수 있다. 그런데 (2) 의 결과를 보면 여전히 튜플과 파라미터를 동일하게 취급하는 특수한 경우를 남겨 놓았다. 바로 이 부분이 앞에서 살펴보았던 RxSwift 및 기본 고차 함수에서 체인 방식으로 연결이 가능했던 이유이다. Swift 업데이트를 통해 튜플과 클로저의 파라미터의 관계를 끊어가는 과정에서도 예외 사항을 남겨둘 수 밖에 없었던 것으로 보인다. (Xcode 15.0 기준)
// Xcode 15.2 에서는 (1) 의 오류가 사라졌다. 즉, 클로저 타입 변수는 완전히 일치하는 형태만 받아들이지만 클로저 타입 파라미터는 가리지 않고 받아들인다는 것이다.



// ===============================
// 튜플과 associatedtype
// ===============================

protocol SubType {
    associatedtype T
    func method(element: (T) -> Void)
}

class Sub: SubType {
    typealias T = (Int, Int)
    func method(element: (T) -> Void) { }
}

// T 는 튜플타입이지만 다음과 같이 개별 타입으로 표현 가능
var sub1 = Sub()
sub1.method { a, b in
    
}

// 물론 튜플타입으로 표현 가능
var sub2 = Sub()
sub2.method { a in
    a.0
    a.1
}



// ===============================
// 튜플과 case let
// ===============================

enum QWE {
    case a(Int, String)
}

var qwe = QWE.a(2, "")

// Deprecated
if case let .a(tuple) = qwe {
    tuple.0
    tuple.1
}



// ===============================
// Never
// ===============================

// Kingfisher 패키지에서의 사용 예시
/// The cache result for memory cache. Caching an image to memory will never fail.
public let memoryCacheResult: Result<(), Never>



// ===============================
// Range
// ===============================

// ClosedRange<Int>
let intRange = 0...9
// Range<Int>
let intRange2 = 0..<10

for _ in intRange {
    
}

intRange.lowerBound
intRange.upperBound
intRange.count
intRange.contains(0)
intRange.contains(9)
