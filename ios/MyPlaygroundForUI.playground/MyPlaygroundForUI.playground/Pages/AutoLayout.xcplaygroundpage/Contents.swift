import UIKit
import PlaygroundSupport
import SnapKit

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // Contraints 에는 Priority 가 있는데 1 ~ 1000 까지 설정할 수 있고 높을 수록 높은 우선순위를 갖는다. Hugging 보다 Compression Resistance 가 높은 이유는 아마도 자신의 크기가 확장되는 것보다 축소되어 잘리는 것이 더 치명적이기 때문일 것이다. 디폴트 우선순위는 다음과 같다.
        // 직접 제약 설정시 => 1000
        // Compression Resistance => 750
        // Hugging => 250

        // 제약이 충돌되면 우선순위에 따라 결정되는데 우선순위까지도 갖다면 시스템이 임의로 제약을 파괴하면서 만족할 때까지 이 과정을 반복한다. 파괴되는 제약은 렌더링이 빠른 순서인 것 처럼 보인다.
        
        
        let stack = UIStackView().then {
            view.addSubview($0)
            $0.axis = .horizontal
            $0.backgroundColor = .green
            $0.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(200)
            }
        }
        
        UILabel().do {
            stack.addArrangedSubview($0)
            $0.backgroundColor = .red
            $0.text = "abc"
            // 기본적으로 현재 레이블의 Hugging 제약이 파괴되지만 다음 주석을 풀면 그 다음 레이블이 파괴된다.
//            $0.snp.contentHuggingHorizontalPriority = 251
        }
        
        UILabel().do {
            stack.addArrangedSubview($0)
            $0.backgroundColor = .yellow
            $0.text = "def"
        }
        
        UILabel().do {
            stack.addArrangedSubview($0)
            $0.backgroundColor = .brown
            $0.text = "xyz"
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


// ===============================
// 기본 개념
// ===============================

// Constraints
// Hugging Resistance
// Compression Resistance
// Priority
// Margin
// UIStackView



// ===============================
// AutoLayout vs. Autoresizing
// ===============================

translatesAutoresizingMaskIntoConstraints



// ===============================
// setNeedsLayout() vs. layoutIfNeeded()
// ===============================

// 단순히 바로 레이아웃을 적용하는지, 다음 업데이트 사이클에서 적용하는지의 차이가 아니다.
// 전자가 레이아웃 재갱신이 필요하다는 플래그를 세팅하는 것이라면, 후자는 호출된 뷰를 기준으로 자신과 모든 자식뷰에서 레이아웃 재갱신이 필요하다는 플래그가 세팅된 뷰에 대해 바로 적용하는 것이다.


// 각 메서드의 구현은 아마 다음과 같을 것이다.

var isLayoutNeeded = false

func setNeedsLayout() {
    // 플래그 값을 세팅하면 기본적으로 다음 런루프에서 레이아웃을 설정할 것이다.
    isLayoutNeeded = true
}

// layoutIfNeeded() 를 호출하면 곧바로 레이아웃 설정을 한다.
func layoutIfNeeded() {
    if isLayoutNeeded {
        layoutSubviews()
        // 자식들의 layoutSubviews() 도 호출
        subviews.forEach {
            $0.layoutIfNeeded()
        }
        isLayoutNeeded = false
    }
}

// 레이아웃을 구성하는 요소(제약, 사이즈, 자식뷰 등)를 변경하면 isLayoutNeeded 를 true 로 변경할 것으로 보이며, setNeedsLayout() 를 호출하면 수동으로 isLayoutNeeded 를 true 로 세팅하는 방식일 것이다.


// 애니메이션 블락에서는 layoutIfNeeded() 만을 사용해야 한다. 그 이유는 일반적으로 애니메이션을 시작하기 전에 한번 호출하여 이전 레이아웃 변경을 정리하고, 애니메이션 블락에서 다시 한번 호출하여 애니메이션을 적용한다.


// 레이아웃 변경을 원하는 뷰가 아닌 상위뷰에 setNeedsLayout() 또는 layoutIfNeeded() 을 적용해야 한다고 한다. 아마 그 이유는 특정 뷰의 레이아웃은 자기 자신 뿐만 아니라 부모뷰에 의해 결정되는 부분도 있기 때문일 것이다. 다시 말하면 상위뷰에서 setNeedsLayout() 또는 layoutIfNeeded() 호출하는 것은 상황에 따라 필수가 아니라는 것이다.



// ===============================
// setNeedsUpdateConstraints() vs. updateConstraintsIfNeeded()
// ===============================



// ===============================
// Margin 정리 (Layout Margin)
// ===============================

// 기본적으로 적용되지 않는다.
// constrain to margin 세팅
// UIStackView().isLayoutMarginsRelativeArrangement 세팅

// relative to margin 스토리보드

// safe area relative margin

// preserve superview margin



// ===============================
// AutoLayout 관련 UIkit 프로퍼티 및 메서드
// ===============================

// UIKit 의 기본 레이아웃 시스템으로 AutoLayout 을 사용하기 때문에 많은 프로퍼티 및 메서드가 AutoLayout 기준으로 작성되어 있다.

// 소개
layoutSubView()
systemLayoutSizeFitting()



// 가급적 frame 수치를 이용하지 말고 AutoLayout 을 사용하는 것이 좋다.
// frame 은 라이프사이클에 따라 정확히 결정되는 시기와 활용 시기의 차이가 발생할 수 있다.
// 문제는 Layer 을 다룰 경우인데 이 경우에도 제약을 거는 방법은 있는 것으로 보인다.
// 이런 레이아웃 시스템에 기반을 두는 경우, 아무리 직접 frame 등을 설정해 놓았다 하더라도 시스템에 의해 덮어씌워지는 경우가 많기 때문에 관리가 힘들다.
