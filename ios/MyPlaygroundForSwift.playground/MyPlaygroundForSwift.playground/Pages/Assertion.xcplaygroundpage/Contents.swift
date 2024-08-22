

// ===============================
// 빌드 Optimization Level
// ===============================

// 디버그 빌드 디폴트 Optimization Level : -Onone
// 릴리즈 빌드 디폴트 Optimization Level : -O



// ===============================
// 체크 여부
// ===============================

// 디버그 빌드 O
// 릴리즈 빌드 O
// -Ounchecked O
fatalError(<#T##message: String##String#>) -> Never

// 디버그 빌드 O
// 릴리즈 빌드 X
// -Ounchecked X
assert(<#T##() -> Bool#>, <#T##message: String##String#>)

// 디버그 빌드 O
// 릴리즈 빌드 X
// -Ounchecked X
assertionFailure(<#T##message: String##String#>)

// 디버그 빌드 O
// 릴리즈 빌드 O
// -Ounchecked X
precondition(<#T##() -> Bool#>, <#T##message: String##String#>)

// 디버그 빌드 O
// 릴리즈 빌드 O
// -Ounchecked X
preconditionFailure(<#T##message: String##String#>) -> Never


// 대부분의 경우 fatalError, assert, assertionFailure 중에서 사용하는 것으로 보인다.
// 특히, assert 또는 assertionFailure 는 릴리즈 빌드에서는 전혀 영향을 끼치지 않으므로 최대한 활용하는 것이 좋다.
