

// ===============================
// String 관련 테스트
// ===============================

var str = "abc"
str.contains("BC")
str.localizedCaseInsensitiveContains("BC")
str.lowercased()
str.uppercased()
str.capitalized
str.count
str.isEmpty
str.utf8
str.hasPrefix("a")
str.hasSuffix("c")


// UTF 관계없이 문자 단위를 표현 (단순 Int 타입이 아님)
// String.Index
let startIndex = "감사합니다".startIndex
let endIndex = "감사합니다".endIndex

"감사합니다".count
"abcde".count
"😄🥰".count



// ===============================
// 배열 관련 테스트
// ===============================

var intArray = [1,2,3]
intArray.count
intArray.capacity
intArray.append(contentsOf: [2,3,4])
intArray += [2,3,4]
intArray.count
intArray.capacity
intArray.append(1)
intArray.count
intArray.capacity

// 첫 원소 제거 후 반환 (반환할 원소가 없으면 크래쉬)
intArray.removeFirst()
// 마지막 원소 제거 후 반환 (반환할 원소가 없으면 크래쉬)
intArray.removeLast()
// 마지막 원소 제거 후 반환 (반환할 원소가 없으면 nil 반환)
intArray.popLast()



// ===============================
// Set 관련 테스트
// ===============================

var a: Set = ["A", "B", "C", "D"]
var b: Set = ["B", "C", "D"]
var c: Set = ["B", "C"]
var d: Set = ["D"]
a.capacity
b.capacity
c.capacity
d.capacity
// Set 집합 결합 메서드 (신규 Set 반환)
var union = a.union(b)
var intersection = a.intersection(b)
var subtract = a.subtracting(b)
var symmetric = a.symmetricDifference(b)
// Set 집합 결합 메서드 (기존 Set 반영)
a.formUnion(b)
a.formIntersection(b)
a.subtract(b)
a.formSymmetricDifference(b)
// Set 집합 비교 메서드
c.isSubset(of: b)
d.isStrictSubset(of: b)
b.isSuperset(of: c)
b.isStrictSuperset(of: d)
a.isDisjoint(with: d)
a == b
// 기타
var (inserted, memberAfterInsert) = d.insert("X")
print(inserted)
print(memberAfterInsert)
// map 의 결과는 배열
a.map { $0 + "_" }



// ===============================
// Dictionary 관련 테스트
// ===============================

var dic = [1:"1", 3:"3"]
dic.count
dic.capacity
dic.keys
dic.values
dic[1]
dic[2]
dic[3]
dic[3] = "33"
dic[3]
dic[5] = "5"
dic.count
dic.capacity
dic[7] = "7"
dic.count
dic.capacity



// ===============================
// Collection 관련 고차함수
// ===============================

[1,2].forEach(<#T##body: (Int) throws -> Void##(Int) throws -> Void#>)

[1,2].sorted(by: <#T##(Int, Int) throws -> Bool#>)

[1,2].sort(by: <#T##(Int, Int) throws -> Bool#>)

[1,2].first(where: <#T##(Int) throws -> Bool#>)

[1,2].last(where: <#T##(Int) throws -> Bool#>)

[1,2].firstIndex(where: <#T##(Int) throws -> Bool#>)

[1,2].lastIndex(where: <#T##(Int) throws -> Bool#>)

[1,2].removeAll(where: <#T##(Int) throws -> Bool#>)

[1,2].map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)

[1,2].flatMap(<#T##transform: (Int) throws -> Sequence##(Int) throws -> Sequence#>)

[1,2].compactMap(<#T##transform: (Int) throws -> ElementOfResult?##(Int) throws -> ElementOfResult?#>)

[1,2].filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)

[1,2].contains(where: <#T##(Int) throws -> Bool#>)

[1,2].allSatisfy(<#T##predicate: (Int) throws -> Bool##(Int) throws -> Bool#>)

[1,2].reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result##(_ partialResult: Result, Int) throws -> Result#>)

[1,2].max(by: <#T##(Int, Int) throws -> Bool#>)

[1,2].min(by: <#T##(Int, Int) throws -> Bool#>)

