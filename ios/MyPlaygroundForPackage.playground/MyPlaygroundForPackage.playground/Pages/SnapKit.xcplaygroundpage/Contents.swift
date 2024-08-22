import UIKit
import PlaygroundSupport
import SnapKit

let view = UIView()


// Snapkit 연구

// SnapKit 은 기본적으로 UIKit 을 통해 생성한 제약과 별개로 동작한다. 즉, 이미 기존 방식으로 제약을 생성하더라도 SnapKit 은 이를 무시한다.
// SnapKit 은 확장 저장 프로퍼티를 사용하여 대상 객체에 고유의 제약 객체를 저장하여 활용한다.

// 제약을 신규로 만든다. (이미 같은 종류의 제약이 존재하더라도 별개로 추가)
view.snp.makeConstraints {
    // 양수이면 first 가 second 안쪽 또는 작게, 음수이면 first 가 second 바깥 또는 크게
    $0.edges.equalToSuperview().inset(5)
    // first = second + offset
    $0.edges.equalToSuperview().offset(5)
    // first = multiple * second
    $0.size.equalToSuperview().multipliedBy(0.5)
}

// 기존의 제약을 전부 지우고 신규로 만든다. (SnapKit 으로 생성한 것만)
// 제약을 완전히 제거한 후 다시 생성하는 것이기 때문에 여러 레이아웃 이슈가 존재하는 것으로 보인다.
view.snp.remakeConstraints { make in
    
}

// 기존의 제약을 업데이트 한다.
// 기존에 존재하지 않는 제약을 업데이트 하면 에러가 발생하지만, 이전에 SnapKit 으로 생성한 제약이 하나도 없는 경우에만 한정하여 makeConstraints() 처럼 동작한다.
view.snp.updateConstraints { make in
    
}

// 기존의 제약을 전부 지운다. (SnapKit 으로 생성한 것만)
view.snp.removeConstraints()


// prepareConstraints() 는 공개되어 있는 API 지만 따로 사용할 이유가 없는 것으로 보인다. 내부적으로 사용되는 API 이다.
view.snp.prepareConstraints { make in
    
}


// SnapKit 내부를 살펴보면 제약이 같다는 조건은 다음과 같다.
// 결국, constant 값을 제외한 다른 조건이 모두 같아야 같은 조건이라는 것이다.
internal func ==(lhs: LayoutConstraint, rhs: LayoutConstraint) -> Bool {
    // If firstItem or secondItem on either constraint has a dangling pointer
    // this comparison can cause a crash. The solution for this is to ensure
    // your layout code hold strong references to things like Views, LayoutGuides
    // and LayoutAnchors as SnapKit will not keep strong references to any of these.
    guard lhs.firstAttribute == rhs.firstAttribute &&
          lhs.secondAttribute == rhs.secondAttribute &&
          lhs.relation == rhs.relation &&
          lhs.priority == rhs.priority &&
          lhs.multiplier == rhs.multiplier &&
          lhs.secondItem === rhs.secondItem &&
          lhs.firstItem === rhs.firstItem else {
        return false
    }
    return true
}


// 디버깅
view.snp.makeConstraints {
    $0.size.equalToSuperview().labeled("부모뷰와 사이즈 같음")
}


// 테스트
class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        let view = UIView()
        self.view.addSubview(view)
        view.backgroundColor = .green
        view.snp.makeConstraints {
            $0.size.equalToSuperview().inset(50)
            $0.center.equalToSuperview()
        }
        
        let view2 = UIView()
        self.view.addSubview(view2)
        view2.backgroundColor = .red
        view2.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

