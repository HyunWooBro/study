import UIKit


// ===============================
// 개요
// ===============================

// UIView 는 CALayer 의 래핑 클래스에 가깝다.
// CALayer 는 드로잉, 애니메이션 등의 핵심 렌더링을 담당하며 UIView 는 UIResponder 를 상속하여 터치이벤트 처리 등을 추가한 형태이다.


// UIView 와 CALayer 는 얼핏보면 많은 중복되어 보이는 프로퍼티를 가지고 있는 것처럼 보인다. 예를 들어, UIView 의 clipsToBounds 와 CALayer 의 masksToBound 는 결과적으로 같은 역할을 한다. 하나의 값을 수정하면 자동으로 다른 하나의 값도 더불어 수정되기 때문이다. 실제로 UIView 의 clipsToBounds 를 디스어셈블하면 CALayer 의 masksToBound 를 호출하는 것을 확인할 수 있다.
// 그럼에도 UIView 에서 추가 작업을 하는 경우도 있기 때문에 UIView 와 CALayer 모두에 비슷한 프로퍼티가 있다고 하더라도 CALayer 보다는 UIView 에서 처리하도록 권장하고 있다.
// 참조: https://stackoverflow.com/questions/1177775/how-is-the-relation-between-uiviews-clipstobounds-and-calayers-maskstobounds


let view = UIView()
let layer = CALayer()

// 바운드를 기준으로 클리핑
view.clipsToBounds
layer.masksToBounds

// 마스크 적용 (원본에서 마스크의 불투명 또는 반투명한 부분만 출력됨)
view.mask
layer.mask

