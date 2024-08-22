import UIKit


// ===============================
// 개요
// ===============================

// 모든 프로퍼티는 초기화 과정이 종료되기 전에 기본값을 가져야 한다.
// 기본값을 선언시 초기화 또는 init() 을 통한 초기화를 하든가 옵셔널 타입으로 선언해야 한다.

// struct 는 생성자를 작성하지 않아도 기본 memberwise init 제공
// 단, 별도로 생성자를 작성하면 제공 안됨 (확장에서 작성하면 우회 가능)
// 또한, 프로퍼티 중에서 하나라도 private 인 경우에도 제공 안됨

// 아래의 초기화 개념은 모두 클래스에만 적용됨



// ===============================
// designated init vs. convenience init
// ===============================

// 클래스의 생성자는 크게 designated init 과 convenience init 으로 나뉜다.
// convenience 키워드의 유무로 designated init 과 convenience init 구분된다.

// [designated init 규칙]
// designated init 에서는 부모 클래스의 init 을 호출해야 한다.
// designated init 자식 클래스에서 오버라이딩 가능

// [convenience init 규칙]
// convenience init 은 내부에서 반드시 같은 클래스의 다른 convenience init 또는 designated init 을 호출해야 한다. 최종적으로는 같은 클래스의 designated init 을 호출해야 한다.
// designated init 은 자식 클래스에서 오버라이딩 불가능



// ===============================
// required init
// ===============================

// 자식 클래스가 상속할 때 반드시 작성해야 하는 생성자를 명시
required init()

// !!!: 자식 클래스에서 designated init 을 따로 작성하지 않는 경우 부모 클래스의 모든 designated init 을 자동으로 제공받게 된다. 이 경우에는 required init 도 포함되어 있기 때문에 따로 작성하지 않아도 된다. 참고로, 부모 클래스의 designated init 을 자동으로 제공받거나 모든 designated init 을 오버라이딩하면 부모 클래스의 convenience init 역시 자동으로 제공된다.



// ===============================
// failable init
// ===============================

// 생성자에서 초기화가 불가능한 경우 nil 을 리턴할 수 있다.
// init 다음에 ? 을 삽입하여 표현한다.

// 예시
public /*not inherited*/ init?(named name: String)
UIImage(named: "abc")?.size

// 자식 클래스에서 failable init 오버라이딩할 때 nonfailable init 으로 변경이 가능



// ===============================
// 클래스의 2단계 초기화
// ===============================

// 1단계 : designated init 에서 부모 클래스가 아닌 자신에게 속한 프로퍼티에만 접근이 가능하며, 필요한 초기화를 마치고 부모 클래스의 init 호출한다.
// 2단계 : 부모 클래스의 init 호출이 끝나면 부모의 프로퍼티에도 접근이 가능해짐

override init() {
    // 자신의 프로퍼티에만 접근 가능
    super.init()
    // 부모의 프로퍼티에도 접근 가능
}



// ===============================
// init()
// ===============================

// NSObject 의 init() 을 활용하는 방식

// 예시
// UIView() 내부에서 UIView(frame: .zero) 호출
UIView()
UIView(frame: .zero)
// UIViewController() 내부에서 UIViewController(nibName: nil, bundle: nil) 호출
UIViewController()
UIViewController(nibName: nil, bundle: nil)
