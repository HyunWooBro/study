import UIKit

// Accessibiliy 는 청각, 시각 등의 문제를 가진 사용자도 원활하게 사용할 수 있도록 지원하는 기능이다.






// Debug View Hierarchy 에서 뷰 계층을 보면 기본적으로 타입명만 표시되기 때문에 커스텀 타입이 아니고 기본 타입의 경우 구분하기 쉽지 않을 수 있다.
// 이럴 경우 접근성의 accessibilityLabel 을 활용하면 타입명 다음에 해당 내용이 덧붙여 출력되는 것을 확인할 수 있다. 한편, UILabel 와 같이 텍스트를 다루는 UI 의 경우에는 자동으로 accessibilityLabel 에도 입력되는 것으로 보인다.

// UILabel - def 로 표시됨
let label = UILabel()
label.text = "def"

// UIView - abc 로 표시됨
let view = UIView()
view.accessibilityLabel = "abc"


