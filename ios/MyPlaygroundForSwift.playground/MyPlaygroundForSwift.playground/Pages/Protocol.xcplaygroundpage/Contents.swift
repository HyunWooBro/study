import Foundation


// ===============================
// associatedtype
// ===============================

// 프로토콜 전용 Generic 이라고 할 수 있다.

// 예시
public protocol RawRepresentable {
    associatedtype RawValue
    init?(rawValue: Self.RawValue)
    var rawValue: Self.RawValue { get }
}



// ===============================
// 프로토콜 지향 프로그래밍 (Protocol Oriented Programming)
// ===============================

// POP 은 다음의 요소를 활용하는 프로그래밍 패러다임
// Protocol : 기본 인터페이스 역할
// Extension : 디폴트 구현 추가 가능
// Associatedtype : 다양한 타입에 대한 Generic 접근 가능
// AssociatedObject : 상태를 저장하지 못했던 Extension 한계 극복

// 컴포넌트 지향 프로그래밍과 유사하다. 상속을 피하고 유연한 확장을 하자는 것이다.



// ===============================
// optional 키워드
// ===============================

// 구현이 없는 메서드는 optional 키워드를 추가해 준다.
// 단, 이 기능은 objc 에 있는 기능이기 때문에 @objc 를 붙여줘야 한다.
// optional 키워드가 있는 프로토콜은 class 에만 적용 가능하다.

// 일반적으로 optional 을 사용하기 보다는 extension 을 통해 디폴트 구현을 하는 경우가 많다. 이런 식으로 처리하면 class 뿐만 아니라 enum 과 struct 에도 적용가능하다.

@objc protocol TestProtocol {
    @objc optional func methodA()
    @objc optional var integer: Int { get set }
}

// optional 은 필수로 구현할 필요가 없음
class ClassA: TestProtocol {
    func methodA() {
    }
}

var classA = ClassA()
classA.methodA()

// 프로토콜 타입으로 optional 메서드나 프로퍼티는 옵셔널로 정의되어 있는 것을 확인
var test: TestProtocol = ClassA()
test.methodA?()



// ===============================
// protocol Hashable: Equatable
// ===============================

// NSObject 는 기본적으로 Hashable 구현하고 있다. NSObject 는 Hashable 과 별개로 hash 프로퍼티도 가지며 hash 와 hashValue 는 같은 값을 가지게 된다. NSObject 에서는 hashValue 프로퍼티와 hash(into:) 메서드는 오버라이딩이 금지되어 있다. 결국 hash 프로퍼티만을 오버라이딩 하여 해시값을 결정할 수 있다.
// NSObject 는 같은 상태(프로퍼티) 값을 갖는 다고 하더라도 다른 해시값을 갖는다. 아마도 NSObject 자체가 별개의 객체를 표현하기 때문일 것이다. 예를 들어, 2개의 UIView 가 완전히 같은 상태라고 하더라도 같은 객체라고 할 수 없는 것처럼 말이다. 결국, NSObject 는 데이터를 담는 컨테이너라고 볼 수 있다. 컨테이너의 내용물이 완전히 갖다고 해서 같은 컨테이너는 아닌 셈이다.


// Hashable 을 준수하기 위해서는 hash(into:) 구현해야 함
// hashValue 는 위의 메서드를 구현하면 간접적으로 컴파일러가 값을 제공
// struct 또는 enum 의 경우, 사용자가 직접 구현하지 않으면 컴파일러가 자동으로 생성하는데 다음과 같은 단순한 규칙으로 구성된다고 한다.
// 참조: https://forums.swift.org/t/how-is-synthesized-hashable-implemented/15960

// struct 에서 hash(into:) 자동생성 예시
// 선언된 순서대로 combine()
struct Dog {
    let name: String
    let breed: String
    let age: Int
}

extension Dog: Hashable {
    func hash(into hasher: inout Hasher) { // Generated automatically
      hasher.combine(name)
      hasher.combine(breed)
      hasher.combine(age)
    }
}


// associated vlaue 가 있는 enum 에서 hash(into:) 자동생성 예시
// case 를 구분하기 위해서 discriminator 을 포함
enum List<T> {
    case empty
    indirect case node(value: T, rest: List<T>)
}

extension List: Equatable where T: Hashable {
    static func == (lhs: List, rhs: List) -> Bool {
        return false
    }
}

extension List: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) { // Generated automatically
        switch self {
        case .empty:
            hasher.combine(0) // discriminator
        case let .node(value: value, rest: rest):
            hasher.combine(1) // discriminator
            hasher.combine(value)
            hasher.combine(rest)
        }
    }
}


// enum 비교 테스트 (associated value 포함)
struct Data: Hashable {
    var aa: String?
    var bb: Int = 0
    
    static func == (lhs: Data, rhs: Data) -> Bool {
        return lhs.bb == rhs.bb
    }
}

enum CD: Hashable {
    case a(AnyHashable?)
    case b(AnyHashable?)
}

var p0: CD = CD.a(nil)
var p1: CD = CD.a(Data(aa: "abc", bb: 0))
var p2: CD = CD.a(Data(aa: "abc", bb: 0))
var p3: CD = CD.b(Data(aa: "abc", bb: 0))

if p0 == p1 {
    print("same")
}

if p1 == p2 {
    print("same")
}

if p2 == p3 {
    print("same")
}


// 해시값은 다르지만 비교는 같다면?
// 딕셔너리에 넣을 때는 다른 곳에 삽입되지만 서로를 비교하면 같다는 결과를 반환할 것이다.
struct ABC: Hashable {
    var str1: String
    var int1: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(str1)
        hasher.combine(int1)
    }
    
    static func == (lhs: ABC, rhs: ABC) -> Bool {
        return lhs.str1 == rhs.str1
    }
}

var abc1 = ABC(str1: "ddd", int1: 15)
var abc2 = ABC(str1: "ddd", int1: 10)

if abc1 == abc2 {
    print("same")
}

print(abc1.hashValue)
print(abc2.hashValue)


// 다른 객체라도 hash 를 이루는 요소의 타입과 입력된 값이 같다면 hashValue 의 값도 같다.
struct AAA: Hashable {
    let aaa: Int
    let bbb: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(aaa)
    }
    
    static func == (lhs: AAA, rhs: AAA) -> Bool {
        return lhs.aaa == rhs.aaa
    }
}

struct BBB: Hashable {
    let ddd: String?
    let eee: Int
    let fff: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(eee)
    }
    
    static func == (lhs: BBB, rhs: BBB) -> Bool {
        return lhs.eee == rhs.eee
    }
}

var aaa = AAA(aaa: 3, bbb: "ee")
var bbb = BBB(ddd: "3434", eee: 3, fff: "223232")

if aaa.hashValue == bbb.hashValue {
    print("same")
} else {
    print("not sname")
}


// == 비교시에는 == 연산자의 오버라이딩만 필요하고, dictonary 사용시에는 hash() 와 == 연산자 모두 적절하게 오버라이딩 해야 하는 것으로 보인다.
struct Cat: Hashable {
    let id: Int
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var cat1 = Cat(id: 1, name: "black")
print(cat1.hashValue)
var cat2 = Cat(id: 1, name: "white")
print(cat2.hashValue)

if cat1 == cat2 {
    print("same")
} else {
    print("not sname")
}

var catDic: [Cat : Int] = [:]
catDic[cat1] = 2
catDic[cat2] = 4
catDic[cat1]
catDic[cat2]

struct Rat: Hashable {
    let id: Int
    let name: String
    
    static func == (lhs: Rat, rhs: Rat) -> Bool {
        return lhs.id == rhs.id
    }
}

var rat1 = Rat(id: 1, name: "black")
print(rat1.hashValue)
var rat2 = Rat(id: 1, name: "white")
print(rat2.hashValue)

if rat1 == rat2 {
    print("same")
} else {
    print("not sname")
}

// hash() 오버라이딩 하지 않으면서 == 연산자만 오버라이딩 하면 불안정하여 시도할 때마다 결과가 달라질 수 있다.
var ratDic: [Rat : Int] = [:]
ratDic[rat1] = 3
ratDic[rat2] = 5
ratDic[rat1]
ratDic[rat2]

struct Pat: Hashable {
    let id: Int
    let name: String
    
    static func == (lhs: Pat, rhs: Pat) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

var pat1 = Pat(id: 1, name: "black")
print(pat1.hashValue)
var pat2 = Pat(id: 1, name: "white")
print(pat2.hashValue)

if pat1 == pat2 {
    print("same")
} else {
    print("not sname")
}

var patDic: [Pat : Int] = [:]
patDic[pat1] = 3
patDic[pat2] = 5
patDic[pat1]
patDic[pat2]



// ===============================
// protocol Equatable
// ===============================

// == 또는 !=
// struct 또는 enum 의 경우, 자동생성될 수 있는데 아마도 각 변수를 == 연산자로 비교하거나, hashValue 를 비교하지 않을까 추측된다.
// !!!: Hashable 테스트 결과 hashValue 를 비교하지 않는다.



// ===============================
// protocol Comparable: Equatable
// ===============================

// >, <. <=. >=
// < 이렇게 하나를 구현하면 사용가능



// ===============================
// protocol Identifiable
// ===============================

// id 프로퍼티를 정의하도록 강제
struct ID: Identifiable {
    var id: Int {
        return 5
    }
}



// ===============================
// protocol CaseIterable
// ===============================

// enum 에서 정의된 모든 case 반환하는 allCases 제공
enum Fruit: CaseIterable {
    case apple
    case banana
    case pineapple
}

// enum 내에서 정의된 순서대로 반환되는 것으로 보임
Fruit.allCases



// ===============================
// typealias Codable = Decodable & Encodable
// ===============================

// Decodable
// Encodable
// 편의 타입 별칭



// ===============================
// protocol OptionSet : RawRepresentable, SetAlgebra
// ===============================

// description 테스트
struct BorderOptions: OptionSet {
    let rawValue: Int

    static let top = BorderOptions(rawValue: 1 << 0)
    static let left = BorderOptions(rawValue: 1 << 1)
    static let bottom = BorderOptions(rawValue: 1 << 2)
    static let right = BorderOptions(rawValue: 1 << 3)
    
    static let horizontal: BorderOptions = [.left, .right]
    static let vertical: BorderOptions = [.top, .bottom]
    static let all: BorderOptions = [.top, .bottom, .left, .right]
}

print(BorderOptions.top.rawValue.description)
print(BorderOptions.left.rawValue.description)
print(BorderOptions.bottom.rawValue.description)
print(BorderOptions.right.rawValue.description)



// ===============================
// ExpressibleBy...
// ===============================


// Eureka 예시 (String 및 Bool 값을 받으면 내부에서 적절하게 변환)
/**
 Enumeration that are used to specify the disbaled and hidden conditions of rows

 - Function:  A function that calculates the result
 - Predicate: A predicate that returns the result
 */
public enum Condition {
    /**
     *  Calculate the condition inside a block
     *
     *  @param            Array of tags of the rows this function depends on
     *  @param Form->Bool The block that calculates the result
     *
     *  @return If the condition is true or false
     */
    case function([String], (Form)->Bool)

    /**
     *  Calculate the condition using a NSPredicate
     *
     *  @param NSPredicate The predicate that will be evaluated
     *
     *  @return If the condition is true or false
     */
    case predicate(NSPredicate)
}

extension Condition : ExpressibleByBooleanLiteral {

    /**
     Initialize a condition to return afixed boolean value always
     */
    public init(booleanLiteral value: Bool) {
        self = Condition.function([]) { _ in return value }
    }
}

extension Condition : ExpressibleByStringLiteral {

    /**
     Initialize a Condition with a string that will be converted to a NSPredicate
     */
    public init(stringLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }

    /**
     Initialize a Condition with a string that will be converted to a NSPredicate
     */
    public init(unicodeScalarLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }

    /**
     Initialize a Condition with a string that will be converted to a NSPredicate
     */
    public init(extendedGraphemeClusterLiteral value: String) {
        self = .predicate(NSPredicate(format: value))
    }
}

