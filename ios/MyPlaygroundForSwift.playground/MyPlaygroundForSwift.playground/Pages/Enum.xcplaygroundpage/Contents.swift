


// if case let 테스트
enum EnumA {
    case a(Int, String)
    case b(Int)
}

var aa = EnumA.a(10, "a")
var bb = EnumA.b(3)

// 연관변수 바로 앞에 두어도 되지만
if case .b(let value) = bb {
    print(value)
}

// let 을 앞에서 한번 사용도 가능
if case let .a(number, text) = aa {
    print(number)
    print(text)
}


// if case 테스트
enum EnumB {
    case a
    case b
}

var test: EnumB = .b

if case .b = test {
    print("same")
}

// 연관 값이 없는 경우에는 다음과 같은 형식으로 사용하는 것이 일반적
if test == .b {
    print("same")
}
