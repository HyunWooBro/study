import UIKit


// SwiftUI 의 Canvas 프리뷰 기능 관련 알아둘 사항 정리


// ===============================
// Live vs. Selectable
// ===============================

// Live 모드에서는 previewLayout 설정과는 무관하게 디바이스 사이즈로만 나오며 네트워크를 포함한 모든 인터렉션이 가능
// Selectable 모드에서는 fixed 사이즈 사용시 원하는 사이즈로 출력되며 네트워크를 포함하여 정지된 초기 상태만 표현

// Alert 의 경우 Live 모드에서 작동하게 하려면 시작시점과의 약간의 딜레이가 필요할 수 있음



// ===============================
// UIKit 적용
// ===============================

// UIViewRepresentable, UIViewControllerRepresentable, PreviewProvider 프로토콜을 사용하여 UIKit 뷰도 프리뷰 기능을 활용할 수 있음



// ===============================
// 디버깅 관련
// ===============================

// Xcode 13 이전에서는 프리뷰 Live 모드에서 직접적으로 지원을 했으나 이후에는 다음과 같이 프로세스를 찾아서 연결하면 프리뷰에서도 breakpoint 를 활용할 수 있다.
// Debug > Attach to Process
// 단, po 명령어를 통한 변수 값 확인은 어려운 것으로 보인다.

// View UI Hierarchy 를 통해 3D 레이아웃 보기도 가능하다. 단, 3D 보기를 하면 되돌아갈 때 다시 프리뷰가 로딩되어야 한다.

// 로그는 Previews 탭에서 확인 가능 (시뮬레이터 및 실기기 로그는 Executable 에서 확인 가능)



// ===============================
// 프리뷰 감지
// ===============================

// #if targetEnvironment(simulator) 와 같은 방식은 지원하지 않음
// 대신 ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" 조건으로 확인할 수 있음



// ===============================
// UIHostingController
// ===============================

// Canvas 프리뷰 사용시 SwiftUI 렌더링을 위한 UIHostingController 타입의 HostingViewController 가 추가되어 사용자의 뷰컨트롤 또는 뷰를 감싸고 있다. HostingViewController 의 기본 뷰인 Hosting view 의 자식뷰로 View Host 라는 뷰를 가지고 있는데 이 뷰는 padding() 또는 ignoresSafeArea() 등을 반영한 사이즈로 생성된다.



// ===============================
// 라이프사이클 관련
// ===============================

// 어떤 뷰컨트롤 또는 뷰를 프리뷰로 실행시 다음 UIApplicationDelegate 라이프사이클 메서드가 호출된다.
application(<#T##UIApplication#>, didFinishLaunchingWithOptions: <#T##[UIApplication.LaunchOptionsKey : Any]?#>)

// 단, 다음 UIWindowSceneDelegate 라이프사이클 메서드는 호출되지 않는다.
scene(<#T##UIScene#>, willConnectTo: <#T##UISceneSession#>, options: <#T##UIScene.ConnectionOptions#>)



// ===============================
// 기타
// ===============================

// Pin 기능 : 프리뷰를 Pin 기능을 통해 다른 프리뷰에서도 항상 포함되도록 하면 코딩과정에서 여러 각도에서 조망할 수 있음

// FlexLayout 관련 : UILabel 의 text 를 define 을 통해 접근하여 설정한 경우 Canvas 빌드가 실패하는 경우가 발생할 수 있다. 이 경우에는 root 컨테이너 define 구문 다음에 어떠한 메서드나 프로퍼티를 연결하면 해결된다. 물론, 시뮬레이터 및 기기에서는 해당 문제가 발생하지 않는다.

// UIKit 에서 프리뷰를 사용할 때 일반적으로 다음과 같이 소스 하단에 위치시키게 된다. 이때 주의할 점은 새롭게 import 하게 될 때 소스의 가장 마지막 import 다음줄에 추가된다는 것이다. 추가된 패키지가 디버그 빌드에서만 필요하다면 아무 문제가 없겠지만 릴리즈 빌드에서도 필요하다면 릴리즈 빌드시 에러가 발생할 것이다.
#if DEBUG
import SwiftUI
import MapKit

struct TestPreview: PreviewProvider {
    static var previews: some SwiftUI.View {
        
    }
}
#endif

// Canvas 프리뷰 기능은 디버그 빌드(-Onone)에서만 동작한다. 릴리즈 빌드(-O)에서는 사용할 수 없다.

// TODO: UserDefaults 관련 작동 방식 연구 필요
