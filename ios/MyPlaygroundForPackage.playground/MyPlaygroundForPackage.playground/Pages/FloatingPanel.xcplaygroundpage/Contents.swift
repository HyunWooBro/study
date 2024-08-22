import UIKit



// 출력하는 여러가지 방법

var controller = UIViewController()

var fpc = FloatingPanelController()

// 첫번째 (모달 방식)
controller.present(fpc)

// 두번째 (자식 뷰컨트롤 방식)
fpc.addPanel(toParent: controller)



fpc.show(animated: <#T##Bool#>, completion: <#T##(() -> Void)?#>)
fpc.hide(animated: <#T##Bool#>, completion: <#T##(() -> Void)?#>)


fpc.move(to: <#T##FloatingPanelState#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?#>)



// 스크롤 트랙킹 옵션
fpc.trackingScrollView



// 다음 델리게이트 메서드는 FloatingPanel 이 제거될 때 호출되어야 하지만 FloatingPanel 에서 지정한 방법으로 제거한 경우에만 호출되며 다음의 2가지가 있다.
// 1. isRemovalInteractionEnabled 를 이용하여 제거
// 2. handleBackdrop 을 이용하여 제거
// 그 외의 경우에는 수동으로 처리해 줘야할 것 같다.

func floatingPanelWillRemove(_ fpc: FloatingPanelController)


func floatingPanelDidRemove(_ fpc: FloatingPanelController)



// referenceGuide 의 superview 는 safeArea 를 고려하지 않기 때문에 길이가 짧은 tip 상태일 경우 탭바 등에 가려질 수 있다.
FloatingPanelLayoutAnchor(
    absoluteInset: inset,
    edge: .bottom,
    referenceGuide: .superview
)



// 차이 연구하기
public enum ContentMode: Int {
    /// The option to fix the content to keep the height of the top most position.
    case `static`
    /// The option to scale the content to fit the bounds of the root view by changing the surface position.
    case fitToBounds
}
