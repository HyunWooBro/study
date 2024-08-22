import UIKit
import EmptyDataSet_Swift


// ===============================
// 개요
// ===============================

// EmptyDataSet-Swift 는 EmptyDataSet 을 Swift 로 포팅하고 몇 가지 기능을 추가한 버전이다.

// EmptyDataSet 은 크게 3가지 요소로 구분할 수 있다.

// 1. EmptyDataSetDelegate : 이벤트 후킹 및 옵션 설정
// 2. EmptyDataSetSource : 데이터소스 프로토콜
// 3. emptyDataSetView : UIScrollView 의 확장 메서드



// ===============================
// 활용
// ===============================

// 컨텐츠를 주입하는 방식은 크게 3가지이다.

// 1. EmptyDataSetSource 에서 customView() 제외한 활용 (+ EmptyDataSetDelegate)
// 2. EmptyDataSetSource 에서 customView() 활용 (+ EmptyDataSetDelegate)
// 3. UIScrollView 확장 메서드인 emptyDataSetView 활용 (+ EmptyDataSetDelegate)

// !!!: 세번째 방식의 경우 emptyDataSetView 에서 제공하는 메서드를 보면 EmptyDataSetDelegate 의 기능도 포함하고 있는 것으로 보이나 shouldBeForcedToDisplay 같은 일부 속성은 emptyDataSetView 에서 설정해도 크게 의미가 없기 때문에 EmptyDataSetDelegate 을 활용하여 설정해야 한다. 버그로 보인다.

// 최종적으로 UIScrollView 확장 메서드인 reloadEmptyDataSet() 호출하여 적용



// ===============================
// 예시
// ===============================

// 다음과 같이 emptyDataSetView 를 이용한 클로저 방식이 직관적이고 편하다.
let tableView = UITableView()
tableView.emptyDataSetView { view in
    view.titleLabelString("titleString")
        .detailLabelString("detailString")
        .image(image)
        .imageAnimation(imageAnimation)
        .buttonTitle("buttonTitle", for: .normal)
        .buttonTitle("buttonTitle", for: .highlighted)
        .buttonBackgroundImage(buttonBackgroundImage, for: .normal)
        .buttonBackgroundImage(buttonBackgroundImage, for: .highlighted)
        .dataSetBackgroundColor(backgroundColor)
        .verticalOffset(verticalOffset)
        .verticalSpace(spaceHeight)
        .shouldDisplay(true, view: tableView)
        .shouldFadeIn(true)
        .isTouchAllowed(true)
        .isScrollAllowed(true)
        .isImageViewAnimateAllowed(isLoading)
        .didTapDataButton {
            // Do something
        }
        .didTapContentView {
            // Do something
        }
}

tableView.reloadEmptyDataSet()
