import UIKit


// ===============================
// 개요
// ===============================

// 높은 접근 엑세스 -> 낮은 접근 엑세스
// private          선언 내부에서 접근가능   같은 파일내의 확장까지 공개
// fileprivate      파일 내부에서 접근가능
// internal         모듈 내부에서 접근가능   디폴트 접근 엑세스이며 생략 가능
// public           모듈 외부에서 접근가능   외부 모듈에서 상속 불가
// open             모듈 외부에서 접근가능   외부 모듈에서 상속 가능

// 현재 프레임워크를 외부 프레임워크에서 사용할 것이 아니라면 public 및 open 은 불필요



// ===============================
// 응용
// ===============================

// getter 와 setter 다른 접근 제어자 설정 가능
// public fileprivate(set)      읽기: public      쓰기: fileprivate
// private(set)                 읽기: internal    쓰기: private
// public internal(set)         읽기: public      쓰기: internal

// 저장 프로퍼티에 적용하는 방법
private(set) var storedProperty = 10

// 계산 프로퍼티에 적용하는 방법
private(set) var computedProperty: Int {
    get {
        return 3
    }
    set {
        
    }
}


// extension 에도 한번에 적용 가능
private extension UIView {
    
}


// 최상위 private 은 fileprivate 과 같음
private struct ABC { }
fileprivate struct ABC { }

