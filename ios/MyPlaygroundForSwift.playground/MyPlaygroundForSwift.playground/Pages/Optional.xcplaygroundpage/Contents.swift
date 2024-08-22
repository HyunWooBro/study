

// ===============================
// Bool 옵셔널
// ===============================

var str: String?

// 아래 구문은 str 가 nil 일 때는
// if nil == true {} 로 해석되고
// str 이 nil 가 아닐 때는
// if str.isEmpty == true {} 로 해석된다.
// 결과적으로 str 이 nil 이어서 조건이 거짓이 되는 것도 원래의 의도와 부합한다고 볼 수 있다.
// 즉, 일반적인 조건문에서 생략해도 무방한 '== true' 를 굳이 사용함으로써 얻을 수 있는 이점이 있는 것이다. 물론, 이 경우에는 없으면 에러가 발생한다.
if str?.isEmpty == true {
    
}

// 또는 다음 형식으로 사용하는 것도 괜찮아 보인다.
// nil 일 경우에 대해서도 명시적으로 표현한다.
if str?.isEmpty ?? false {
    
}



// ===============================
// 암시적 unwraping
// ===============================

var aaa: Int = 3
var bbb: Int? = 3

if aaa == bbb {
    print("same")
}



// ===============================
// 옵셔널 바인딩
// ===============================

// java 에서와 같이 nil 을 체크하고 사용하기 보다는 옵셔널 바인딩을 사용
var nilable: String? = nil
if nilable != nil {
    print(nilable!)
}

// if 문 안에서만 유효
if let nilable = nilable {
    print(nilable)
}

// guard 만 다음부터 유효
guard let nilable = nilable else {
    return
}
print(nilable)
