import UIKit



// ===============================
// frame vs. bounds
// ===============================

// frame : 뷰가 회전되었을 때를 포함하여 뷰를 감싸는 최소 사각 영역
// bounds : 뷰의 회전을 고려하지 않는 뷰 자체의 최소 사각 영역



// ===============================
// intrinsicContentSize
// ===============================

// AutoLayout 사용시 뷰의 사이즈를 시스템에 전달하기 위해 사용한다.
// 제약과 관계 없이 내부 컨텐츠에 따라 사이즈가 결정되는 경우에 사용된다. 예를 들어, UILabel 경우 내부 컨텐츠에 따라 적절한 사이즈가 반환된다.
// 특히, 커스텀뷰를 만들어서 사용할 때 레이아웃 시스템에게 뷰의 사이즈를 알려주기 위해 오버라이딩해서 사용한다.

class TestView: UIView {
    
    var isExpanded = true
    
    override var intrinsicContentSize: CGSize {
        let width = isExpanded ? 100 : 50
        let height = isExpanded ? 200 : 100
        return .init(width: width, height: height)
    }
}



// ===============================
// sizeToFit vs. sizeThatFits
// ===============================

class TextView2: UIView {
    // 뷰의 최적화된 사이즈를 반환한다. (디폴트로 현재 사이즈를 넘기며 그대로 반환)
    // 자식 클래스에서 적절하게 오버라이딩해서 사용된다. (UIImageView 에서는 내부 이미지의 사이즈를 반환)
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return super.sizeThatFits(size)
    }
    
    // 내부적으로 sizeThatFits() 를 호출한다.
    override func sizeToFit() {
        super.sizeToFit()
    }
}



// ===============================
// systemLayoutSizeFitting (iOS 8+)
// ===============================

// AutoLayout 제약(Constraint)을 고려한 사이즈를 반환한다.
// AutoLayout 설정 후 곧바로 frame 사이즈를 확인하면 layoutSubview() 등에서 레이아웃이 적용되기 전이라 사이즈가 적절하게 계산되지 않지만 이 메서드를 사용하면 레이아웃이 계산된 것처럼 사이즈를 반환한다.
// 내부적으로 sizeThatFits() 을 호출하는 경우도 있다. (즉, 반드시 호출하지는 않는다.)

let view = UIView()

view.systemLayoutSizeFitting(<#T##CGSize#>, withHorizontalFittingPriority: <#T##UILayoutPriority#>, verticalFittingPriority: <#T##UILayoutPriority#>)

// [targetSize]
// 원하는 목표 사이즈를 입력

// 최대 사이즈로
UIView.layoutFittingExpandedSize
// 최소 사이즈로
UIView.layoutFittingCompressedSize

// [priority]
// targetSize 값에 대한 선호도

// 뷰의 현재 값을 유지
UILayoutPriority.required
// targetSize 값에 최대한 근접한 값을 반환
UILayoutPriority.fittingSizeLevel



// ===============================
// Self-Sizing 셀
// ===============================

// UICollectionView 의 경우 Self-Sizing 셀을 만들기 위해 다음과 같이 estimated 속성을 사용할 수 있다.
// 1. UICollectionViewFlowLayout 에서 estimatedItemSize
// 2. UICollectionViewCompositionalLayout 에서 NSCollectionLayoutDimension.estimated

// estimated 속성이 적용되면 UICollectionViewCell 의 preferredLayoutAttributesFitting() 이 호출되어 실제 값을 결정한다. preferredLayoutAttributesFitting() 는 내부적으로 UIView 의 systemLayoutSizeFitting() 호출한다. 셀이 처음 생성될 때는 내부적으로 sizeThatFits() 호출하고 갱신할 때는 호출하지 않는 것으로 보인다.
let cell = UICollectionViewCell()
cell.preferredLayoutAttributesFitting(<#T##layoutAttributes: UICollectionViewLayoutAttributes##UICollectionViewLayoutAttributes#>)


// UITableView 의 경우 Self-Sizing 셀을 만들기 위해 다음과 같이 automatic 속성을 사용할 수 있다.
let tableView = UITableView()
// rowHeight 프로퍼티의 값으로 UITableView.automaticDimension 설정
tableView.rowHeight = UITableView.automaticDimension
// 셀의 기본 높이 (Self-Sizing 셀을 위해서 0 이외의 값을 세팅)
tableView.estimatedRowHeight = 50



// ===============================
// 텍스트 사이즈 측정
// ===============================

var str = "abcd"

// 심플하게 사이즈 구하기
str.size(withAttributes: <#T##[NSAttributedString.Key : Any]?#>)

// 여러 정교한 옵션을 활용하여 사이즈 구하기
str.boundingRect(with: <#T##CGSize#>, options: <#T##NSStringDrawingOptions#>, attributes: <#T##[NSAttributedString.Key : Any]?#>, context: <#T##NSStringDrawingContext?#>)
