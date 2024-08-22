


// 프레임워크 단위로는 따로 import 를 하지 않으나 다른 프레임워크를 사용하기 위해서는 import 가 필요하다.
// 일반적으로 다른 프레임워크의 타입을 사용하기 위해서는 사용하는 파일마다 import 를 하는 것이 보통이지만 메서드의 파라미터로 노출되는 경우는 제한적으로 필요 없는 것으로 보인다. 예를 들어, 자신의 A 프레임워크에서 B 프레임워크를 래핑하는 클래스를 하나 만든 경우, 이 클래스를 정의한 파일에서는 B 프레임워크를 import 해야 하지만 다른 파일에서 이 클래스를 사용하는 경우 심지어 메서드의 파라미터로 B 프레임워크의 타입이 노출되더라도 해당 파일에서는 B 프레임워크를 import 하지 않아도 문제가 없을 수 있다.

// example)
// A 파일
import EasyTipView

class TooltipUtils {
    static func show(ddd: EasyTipView.ArrowPosition) {
        
    }
}

// B 파일
TooltipUtils.show(ddd: .any)    // 1
//TooltipUtils.show(ddd: EasyTipView.ArrowPosition.any) // 2


// B 파일은 EasyTipView 를 import 할 필요없이 ArrowPosition 이라는 EasyTipView 패키지의 타입을 활용할 수 있다. 단, 2번처럼 타입을 직접 접근하는 경우에는 에러가 발생하여 import 가 필요하다.




// 외부 프레임워크에서 extension 을 통해 추가 기능을 제공하는 경우, 어느 하나의 파일에서만 외부 프레임워크를 import 하면 다른 모든 파일에서는 import 없이 extension 의 추가 기능이 제공된다.
