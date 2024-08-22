

// Sequence 를 준수하면 for-in 루프를 사용할 수 있고 프로토콜이 제공하는 map, filter 등을 사용할 수 있다.
// 주의: Sequence 는 반드시 배열을 의미하는 것이 아님


// Collection 은 Sequence 를 준수하는 프로토콜


// Array, Set, Dicionary 은 Sequence 와 Collection 를 모두 준수



// ===============================
// ArraySlice
// ===============================

// ArraySlice 는 새로운 객체를 할당하는 것이 아니라 기존 객체에 대한 뷰의 역할을 한다.

// Array.SubSequence 는 다음과 같이 정의되어 있다.
typealias SubSequence = ArraySlice<Element>

[1,2].prefix(<#T##maxLength: Int##Int#>)
[1,2].prefix(while: <#T##(Int) throws -> Bool#>)

[1,2].suffix(<#T##maxLength: Int##Int#>)

[1,2].drop(while: <#T##(Int) throws -> Bool#>)

let array = [1,2,3,4]

let slice = array[1...2]
slice.count
slice.contains(2)
slice.contains(3)

// ArraySlice -> Array 로 변환 (새로운 메모리 할당)
let array2 = Array(slice)



// ===============================
// Substring
// ===============================

// Substring 는 ArraySlice 처럼 새로운 객체를 할당하는 것이 아니라 기존 객체에 대한 뷰의 역할을 한다.

// String.SubSequence 는 다음과 같이 정의되어 있다.
typealias SubSequence = Substring

let text = "text"
let substring = text[text.startIndex...text.endIndex]
substring.count
substring.startIndex
substring.endIndex

// Substring -> String 으로 변환 (새로운 메모리 할당)
let string = String(substring)


