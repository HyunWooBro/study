import UIKit
import FlexLayout


// ===============================
// FlexLayout vs. AutoLayout
// ===============================

// FlexLayout 장점
// 1. 성능적 우위
// 2. 레이아웃이 직관적
// 3. UIStackView 보다 나은 사용성 (Z축 레이아웃 등)
// 4. SwiftUI 와 유사한 개발 방식이기 때문에 Preview 와 함께 사용하면 UIKit 의 방대한 라이브러리 지원을 받으면서 SwiftUI 의 직관적인 선언형 개발 방식을 접목할 수 있음



// ===============================
// 레이아웃 내부 프로세스
// ===============================

// FlexLayout 은 내부적으로 Yoga 프레임워크에 기반을 두고 있다. container.flex.layout() 호출되면 Yoga.cpp 의 YGNodelayoutImpl() 에서 핵심적인 레이아웃 로직이 실행된다.

// Yoga 는 내부적으로 뷰의 사이즈를 얻기 위해 sizeThatFits() 호출한다. 단, leaf 노드(하위 레이아웃이 없는 아이템)에서만 호출되며, 하위 아이템을 갖는 컨테이너에서는 호출되지 않는다. 즉, 컨테이너 자체에 컨텐츠가 포함되어 있더라도 컨텐츠의 사이즈만큼 컨테이너의 사이즈를 잡아주지 않는다.


// FlexLayout 가 레이아웃을 갱신하는 기본 과정은 다음과 같다.
// 1. Flex 레이아웃 정의
// 2. 뷰컨트롤의 viewDidLayoutSubviews() 또는 뷰의 layoutSubviews() 에서 root 컨테이너의 layout() 호출

// viewDidLayoutSubviews() 또는 layoutSubviews() 가 호출되지 않는 상황에서 갱신하는 과정은 다음과 같다.
// 1. Flex 속성/사이즈 변경
// 2. root 컨테이너의 layout() 호출

// FlexLayout 과 관련없는 뷰의 속성이 변경된 상황에서 갱신하는 과정은 다음과 같다.
// 1. 예를 들어, UILabel 의 text 를 변경
// 2. UILabel 의 Flex 에 접근하여 markDirty() 호출
// 3. root 컨테이너의 layout() 호출

let container = UIView()
let label = UILabel()
label.text = "changed"
// 다음과 같이 직접 레이아웃 요청 플래그를 설정한다.
label.flex.markDirty()
// 마지막으로 레이아웃 요청을 명시적으로 요청해야 한다.
container.flex.layout()
// 또는
container.setNeedsLayout()



// ===============================
// layout() 관련
// ===============================

// 상위 설정을 따름
container.flex.layoutDirection(.inherit)
// 왼쪽에서 오른쪽으로 사용하는 언어 사용시 (루트 Flex 뷰의 디폴트 값)
container.flex.layoutDirection(.ltr)
// 오른쪽에서 왼쪽으로 사용하는 언어 사용시
container.flex.layoutDirection(.rtl)

// 컨테이너의 가로/세로 길이 사용
container.flex.layout(mode: .fitContainer)
// 컨테이너의 가로 길이 사용 및 세로 길이는 내부 컨텐츠 길이에 따름
container.flex.layout(mode: .adjustWidth)
// 컨테이너의 세로 길이 사용 및 가로 길이는 내부 컨텐츠 길이에 따름
container.flex.layout(mode: .adjustHeight)

// layout() 예제
// container.pin.all() // 컨테이너의 사이즈를 상위뷰에 맞춘다.
// container.flex.layout() // 정의된 레이아웃을 구현한다.
// 위와 같은 형태가 전형적으로 PinLayout 와 FlexLayout 을 결합해 사용하는 방식이다.
// 여기서 4가지 조합을 비교해 본다.
// 1) pin.all() + flex.layout(mode: .fitContainer)
// => 기본적인 활용법으로, 컨테이너는 상위뷰와 사이즈를 맞추고 하위 레이아웃을 적절히 출력한다.
// 2) pin.left().right().top() + flex.layout(mode: .fitContainer)
// => 루트 컨테이너의 사이즈가 0이 되기 때문에 전혀 출력되지 않는다.
// 3) pin.left().right().top() + flex.layout(mode: .adjustHeight)
// => 지정한 pin 유지하면서 높이가 계산된다.
// 4) pin.all() + flex.layout(mode: .adjustHeight)
// => pin 의 왼쪽, 오른쪽, 상단을 유지하면서 하단은 무시하고 새로운 높이로 조정한다.

// Flex 레이아웃에 포함시킬 것인지 여부
container.flex.isIncludedInLayout(<#T##Bool#>)



// ===============================
// isIncludedInLayout vs. display
// ==============================

// 레이아웃 프로세스에 참여 여부
container.flex.isIncludedInLayout(<#T##Bool#>)
// .none 속성을 가지면 뷰의 사이즈를 0으로 세팅
container.flex.display(<#T##Display#>)

// isIncludedInLayout 의 내부 알고리즘을 보면 isIncludedInLayout 가 false 이면 아예 레이아웃 프로세스에서 배제되는 것을 볼 수 있다.
static void YGApplyLayoutToViewHierarchy(UIView* view, BOOL preserveOrigin) {
    ...
    if (!yoga.isIncludedInLayout) {
        return;
    }
    ...
}

// display 의 내부 알고리즘을 보면 Flex 계층을 따라가며 자식 노드의 사이즈를 전부 0으로 만들어 주는 것을 볼 수 있다.
for (auto child : children) {
    if (child->getStyle().display() == YGDisplayNone) {
        YGZeroOutLayoutRecursively(child, layoutContext);
        child->setHasNewLayout(true);
        child->setDirty(false);
        continue;
    }
}

// !!!: display 방식이 isHidden 방식을 사용하는게 아니라 사이즈 자체를 0으로 만드는 것이다 보니 함정이 많다. 상위뷰가 isHidden 을 통해 숨겨지면 이후에 하위뷰에서 어떤 설정을 하더라도 렌더링되지 않는 반면, display 를 통해 사이즈를 0으로 만드는 경우 추후에 자식뷰의 사이즈가 수정되는 경우 하위뷰가 노출될 수 있기 때문이다.



// ===============================
// position(.absolute) 관련
// ===============================

// position 속성을 absolute 으로 설정하면 해당 아이템은 다른 아이템과는 독립적인 레이아웃으로 다루어진다. 대표적으로 (1) Z축으로 레이아웃하거나 (2) 화면 가장자리에 개별적으로 배치하는 레이아웃 용도로 사용된다.

// absolute 값을 가진 아이템의 define 으로 정의되는 자식 아이템의 position 속성은 relative 값을 갖는다.

// 다음은 position 속성이 absolute 값일 경우에만 유효한 메서드를 보여준다.
// 절대값 또는 퍼센트값 가능 (기준은 padding 고려하지 않은 컨테이너의 순수 Edge)
let item = UIView()
item.flex
    .position(.absolute)
    .left(45%)
    .top(40%)
    .right(45%)
    .bottom(50%)
    .all(50)
    .horizontally(10%)
    .vertically(50)

// !!!: root 컨테이너에서 layout(mode: .adjust...) 호출시, 자식 레이아웃에 absolute 아이템만 가진 경우 너비나 높이를 제대로 계산하지 못한다.



// ===============================
// define() 관련
// ===============================

// define 은 크게 (1) 자식 레이아웃 구조 정의 (2) flex 연관 뷰에 접근 용도로 활용 가능
container.flex.define {
    // 자식 Flex 레이아웃 구조를 정의
    $0.addItem(UIImageView())
    // 뷰에 접근하여 속성 접근 가능
    $0.view?.alpha = 0.5
    // 조건문, 반복문 등을 사용 가능
    for i in 1...3 {
        if i == 2 {
            $0.addItem()
        }
    }
}

// define() 을 여러번 호출해도 기존 define() 내용은 유지된다.
container.flex
    .define {
        $0.addItem(UIImageView())
    }
container.flex
    .define {
        $0.addItem(UIImageView())
    }

// 단, 중복되는 속성은 나중에 설정한 값으로 덮어씌워진다. (처음에 설정한 row 는 무시됨)
container.flex
    .direction(.row)
    .define {
        $0.addItem(UIImageView())
    }
container.flex
    .direction(.column)
    .define {
        $0.addItem(UIImageView())
    }

// define 안에는 조건문을 통해 유연하게 레이아웃을 잡을 수 있다.
container.flex
    .define {
        if isImageInserted {
            $0.addItem(UIImageView())
        } else {
            $0.addItem(UILabel())
        }
    }

// define 은 Yoga 에서 제공하는 기능도, FlexLayout 에서 제공하는 레이아웃 시스템도 아니다.
// 단지 편의 클로저에 가깝다. 위의 조건문을 가진 define 은 아래의 구문과 정확히 일치한다.

if isImageInserted {
    container.flex.addItem(UIImageView())
} else {
    container.flex.addItem(UILabel())
}

// 따라서 이후에 isImageInserted 의 값이 바뀐다고 해서 자동으로 레이아웃도 이것을 반영하는 시스템이 아니다.



// ===============================
// 주요 프로퍼티
// ===============================

// [메인축 방향]
// - direction : column 은 위에서 아래로, row 는 왼쪽에서 오른쪽으로 (DB 테이블 기준으로 용어를 보면 안됨)

// [메인축 정렬]
// - justifyContent

// [크로스축(메인축의 90도 회전) 정렬]
// - alignItems : 기본 정렬 (디폴트 값은 stretch)
// - alignSelf : 개별 아이템의 정렬 (디폴트 값인 auto 는 alignItems 를 따름)
// stretch 속성일 때 자신의 margin 은 무시하지만 컨테이너의 padding 은 고려함

// [넘침 처리]
// - wrap
// - alignContent : wrap 이 발생한 상황에서 정렬

// [갭]
// - columnGap : 세로 방향으로 간격 지정
// - rowGap : 가로 방향으로 간격 지정
// - gap : 모든 방향으로 간격 지정

// [사이즈]
// - width/minWidth/maxWidth
// - height/minHeight/maxHeight
// 절대값 또는 퍼센트값 가능 (퍼센트값의 기준은 컨테이너 사이즈에서 padding 제외한 사이즈)

// [사이즈 기본/확대/축소]
// - basis : grow 및 shrink 적용되기 전 초기 값
// - grow : 남은 공간에 대한 확대
// - shrink : 부족한 공간에 대한 축소
// 절대값 가능 (basis 퍼센트값도 가능)
// !!!: grow 와 shrink 는 함께 활용되는 경우가 많음 (가변적인 아이템의 경우 컨테이너의 남은 공간을 다 차지하거나 넘치게 되는 경우 컨테이너 크기 내에서 적절하게 조절되도록 하기 위해)

// [패딩/마진]
// - padding : 컨테이너 기준으로 자식 아이템에 대한 여백 (UIStackView 의 layoutMargins 와 유사)
// - margin : 아이템 기준으로 가장 가까운 아이템 또는 컨테이너에 대한 여백
// 절대값 또는 퍼센트값 가능 (퍼센트값의 기준은 컨테이너 사이즈에서 padding 제외한 사이즈)
// CSS 박스 모델과 달리 border 과 padding 의 시작 지점이 같음 (CSS 박스 모델에서는 border 영역 후 이어서 padding 영역 출력)
// padding 과 margin 모두 컨테이너 영역에서 공간을 확보 (전자와 후자 모두 자식 레이아웃이 작아지는 결과가 발생하기 때문)

let rootContainer = UIView()
rootContainer.flex.define {
    $0.addItem()
        .height(200)
        .backgroundColor(.placeholderText)
        .define {
            $0.addItem()
                .grow(1)
                .border(5, .red)
                .margin(10)
                .padding(10)
                .backgroundColor(.sky)
                .define {
                    $0.addItem()
                        .grow(1)
                        .margin(5)
                        .border(5, .orange)
                        .backgroundColor(.green)
                }
        }
}



// ===============================
// UIScrollView 관련
// ===============================

// 스크롤뷰 컨텐츠의 사이즈를 contentSize 또는 contentLayoutGuide 을 통해 설정하면 되는데, viewDidLayoutSubviews() 또는 layoutSubviews() 에서 layout() 호출 이후에 설정하게 되므로 여러번 호출되어도 이슈가 없는 contentSize 방식이 좋을 것 같다.



// ===============================
// 서브 컨테이너 결합
// ===============================

// Flex 컨테이너 또는 아이템이 또다른 Flex 컨테이너에 포함시킬 수 있다. 이때, 자식 컨테이너의 부모뷰가 Flex 레이아웃이 아니더라도 addItem() 하는 과정에서 Flex 레이아웃에 편입된다. 모든 자식이 Flex 레이아웃에 포함되어야 layout() 호출될 때 올바르게 레이아웃이 진행된다.

class A: UIView {
    let rootContainer = UIView().then {
        addSubview($0)
    }
    
    init() {
        rootContainer.flex.define {
            $0.addItem()
                .height(200)
                .define {
                    $0.addItem(B())
                }
        }
    }
}

class B: UIView {
    let rootContainer = UIView().then {
        addSubview($0)
    }
    
    init() {
        rootContainer.flex.define {
            $0.addItem(UIView())
        }
    }
}



// ===============================
// 애니메이션
// ===============================

// 일반 UIView 속성처럼 animation 블락에서 다음과 같이 처리한다.
let container = UIView()
let view = UIView()
view.flex.size(100)
UIView.animate(
    withDuration: 1.0,
    animations: {
        self.view.flex.size(0)
        self.container.flex.layout()
    }
)

// ???: 원리가 무엇일까?
// 사실 UIKit 의 내부 애니메이션 시스템으로 자동 지원하는 기능이다.


// ===============================
// 주의사항
// ===============================

// 최상위 view 에 직접 Flex 를 적용하는 것은 지양해야 하는 것으로 보인다.
// 1. 뷰컨트롤러 뷰에 Flex 로 관리되지 않는 다른 뷰를 추가하는 경우 예상치 못한 이슈가 발생할 수 있는 것으로 보인다.
// 2. 셀의 contentView 또는 하위 뷰 대신에 셀 자체에 Flex 를 적용하는 경우 여러 이슈가 발생하는 것으로 보인다.

// UICollectionViewCell 에 대해 FlexLayout 과 함께 UICollectionViewCompositionalLayout 사용시 아이템 및 그룹에 대한 NSDirectionalEdgeInsets 설정이 무시될 수 있다. 대신 컨테이너뷰에 대해 FlexLayout 의 패딩을 적용하여 해결할 수 있다.
