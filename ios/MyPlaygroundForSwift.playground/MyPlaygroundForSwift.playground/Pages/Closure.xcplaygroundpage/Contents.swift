

// ===============================
// 클로저
// ===============================

// Swift 의 모든 메서드는 클로저이다.

// 클로저의 기본형태
{ [캡처 리스트] (파라미터1: 타입1, 파라미터2: 타입2, ...) -> 반환타입 in
    
}



// ===============================
// 경량 문법
// ===============================

// [trailing 클로저]
func function(closure: () -> Void) {
    
}
// 기본 호출
function(closure: { () -> Void in
    
})
// 마지막 파라미터가 클로저인 경우 다음과 같이 표현 가능
function() { () -> Void in
    <#code#>
}
// 파라미터가 클로저 뿐인 경우에는 괄호도 생략 가능
function { () -> Void in
    <#code#>
}

// [유추에 의한 생략]
let result: Bool = { () -> Bool in
    return true
}
// 문맥에 의해 유추가 가능하면 반환타입을 생략 가능
let result: Bool = { () in
    return true
}
// 파라미터가 없으면 생략 가능
let result: Bool = {
    return true
}
// 참고로 protocol 의 associatedtype 타입을 파라미터로 전달하는 경우 Void 형일 때는 역시 생략 가능
protocol _Protocol {
    associatedtype T
}
class _Class: _Protocol {
    typealias T = Void
    func function(closure: (T) -> Void) {
    }
}
_Class().function {
    
}

// [return 생략]
// 반환값이 한줄이라면 return 생략 가능
[1,2].filter { value in
    value % 2
}

// [단축 인자]
[1,2].sorted { lh, rh in
    return lh < rh
}
[1,2].sorted {
    return $0 < $1
}

// [인자 생략]
// 인자의 개수와 순서가 같다면 연산자만 표기 가능
[1,2].sorted(by: <)



// ===============================
// 캡처 리스트 테스트
// ===============================

// 클로저의 기본 캡처 리스트는 참조 타입으로 동작
func functionA() {
    var num = 0
    print("num : \(num)")
    
    let closure = {
        print("num : \(num)")
    }
    
    num = 20
    print("num : \(num)")
    closure()
}
functionA()

// 클로저의 캡처 리스트를 사용하면 값 타입은 그대로 값 타입으로 동작
func functionB() {
    var num = 0
    print("num : \(num)")
    
    let closure = { [num] in
        print("num : \(num)")
    }
    
    num = 20
    print("num : \(num)")
    closure()
}
functionB()

// 참조 타입은 캡처 리스트를 사용해도 여전히 참조 타입으로 변함은 없지만 weak 또는 unwoned 와 연계하여 메모리 이슈를 처리하는 데 사용
// [weak self]



// ===============================
// @escaping vs. @autoclosure
// ===============================

// @escaping 는 클로저가 메서드를 벗어나 저장되거나 다른 객체로 전달되도록 허용한다.

// @autoclosure 는 파라미터를 클로저로 만들어 준다. 대표적으로 assert 와 같이 릴리즈 빌드에서 실행되지 않는 함수가 있을 때 수식을 계산하는 오버헤드를 방지할 수 있다.
assert(<#T##() -> Bool#>)


// 옵셔널 클로저는 기본적으로 @escaping 설정이 디폴트
var action: () -> () = {}
func doit(completion: (() -> ())?) {
    action = completion!
}



// ===============================
// 클로저 중첩 에러 메시지
// ===============================

// 클로저 내부에 또 다른 클로저를 가지고 있을 때 내부 클로저에 에러가 발생하면 별 문제없는 외부 클로저에 에러가 표시되는 경우가 있으므로 주의할 필요가 있다.
// 이 문제를 해결하는 일반적인 해법은 컴파일러에게 타입 추론을 맞기지 않고 컴파일러가 충분히 에러를 찾을 수 있을 만큼 클로저의 파라미터 또는 리턴 타입을 알려주는 것이다.
class Test {
    
    func test() {
        
        var aaa: (Int) -> Void = { _ in }

        // Unable to infer closure type in the current context 이라는 에러가 발생하면 그나마 나은 상황이다. 오해할 수 있는 에러를 뱉어내고 있지 않기 때문이다.
        var bbb: (Int) -> Void = { value in

            aaa = {
                var ccc = $1
            }
        }

    }
    
    var bbb: Int? = 3
    
    private lazy var test2: Int? = {
        
        // 'nil' is not compatible with closure result type 'Int' 이라는 에러가 아래 구문에서 발생하고 있지만 사실은 aaa 클로저에 에러가 있기 때문에 발생하고 있다.
        guard let bbb = bbb else { return nil }

        var aaa = { _ in

        }
        
        return nil
    }()
}



// ===============================
// 주의사항
// ===============================

// 캡처리스트로 인해 다음과 같이 원치않는 상황이 발생할 수 있다.

func update(data: Data) {
    self.data = data
    
    // 다음 코드 영역은 처음 한번만 실행됨
    if intialized == false {
        intialized = true
        handler = { [weak self]
            guard let self else { return }
            // 1. self 없이 사용하는 경우 처음 실행될 때의 data 를 가리킴
            data
            // 2. self 와 함께 사용하는 경우 update(data:) 호출될 때마다 최신 data 를 가리킴
            self.data
        }
    }
}


