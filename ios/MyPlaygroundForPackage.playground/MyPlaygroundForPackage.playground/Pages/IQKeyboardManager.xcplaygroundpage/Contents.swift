import UIKit
import PlaygroundSupport
import IQKeyboardManagerSwift


// ===============================
// 개요
// ===============================

// 단 한줄로 활성화 가능
// !!!: 사실 정확하게 표현하자면 패키지를 import 하는 순간 적용된다.
IQKeyboardManager.shared.enable = true

// 키보드 외부 터치시 키보드 닫기 여부
IQKeyboardManager.shared.shouldResignOnTouchOutside = true

// 텍스트와 키보드와의 거리 (디폴트 10)
IQKeyboardManager.shared.keyboardDistanceFromTextField = 30.0

// 개별 UITextField/UITextView 에 대한 키보드와의 거리
let field = UITextField()
field.keyboardDistanceFromTextField = 50.0
let textView = UITextView()
textView.keyboardDistanceFromTextField = 50.0

// 키보드 위에 툴바 추가 여부 (디폴트 true)
IQKeyboardManager.shared.enableAutoToolbar = false



// ===============================
// 이슈정리
// ===============================

// IQKeyboardManager 사용시 다음 두가지 이슈가 발견되었다.
// 1. 키보드 숨길 때 상태복원이 안되는 경우가 존재
// => 스크롤이 있을 때 스크롤 하단에서는 복원을 하지만, 스크롤 중간에 있을 경우 굳이 스크롤을 되돌려 놓지 않는다.
// 2. 키보드 등장 속도와 뷰가 올라가는 속도가 맞지 않음
// => 속도가 다르다 보니 키보드가 올라가면서 텍스트뷰를 치는 것처럼 보인다.
// !!!: 결론적으로 IQKeyboardManager 이전에 사용했던 커스텀 방식과 결합하여 사용하도록 한다.


// ???: 왜 UITextView 에 한해 키보드가 등장할 때 keyboardWillShow 알림이 2번 호출될까?
// UITextView 에 대해 의도된 구현으로 보인다. 2번 호출되지 않아야 한다면 플래그 등을 통해 직접 통제해야 한다.
// 개별 UITextView 에 대해 처음 키보드가 등장할 때에만 해당하며 이후부터는 1번만 호출된다.
// 출처: https://github.com/hackiftekhar/IQKeyboardManager/issues/1697

// ???: 왜 keyboardWillShow 알림이 키보드가 등장할 때 뿐만 아니라 키보드를 통해 글자를 최초로 입력해도 호출될까?
// 이것은 IQKeyboardManager 패키지와 상관없이 iOS 자체의 구현 이슈로 보인다. IQKeyboardManager 를 제외한 상태에서도 발생하기 때문이다. 다만, 관련 이슈가 검색이 안되는 것은 의문이다.

// ???: 샘플에서는 적용되는 것을 볼 수 있는데 지금 프로젝트에서는 SearchBar 에서 적용이 안되지?
//

