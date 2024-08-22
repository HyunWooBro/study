

// ===============================
// 기본 하위 View 관련 이슈
// ===============================

// 스토리보드형 NIB 에서는 UIViewController 또는 UICollectionViewCell 를 다루는 경우, 각각 제거될 수 없는 view 와 contentView 가 명확하게 들어나며 이들의 서브뷰로만 뷰를 추가할 수 있다.
// 또한, 스토리보드형 또는 독립형 UITableViewCell NIB 에서는 기본적으로 contentView 가 제공되고 있다.
// 반면에 독립형 NIB 에서 UICollectionViewCell 를 다루는 경우, contentView 가 표시되지 않고 암묵적으로 사용된다. 셀에 직접 서브뷰를 추가하는 것처럼 보이지만 실제로는 contentView 의 서브뷰로 추가되는 것이다. 위의 스토리보드형 NIB 와 비교했을 때 일관성이 없어 혼동을 줄 여지가 있다.
// 이 버그는 Xcode 에 오랫동안 존재해온 것으로 보이며, 한 유저는 기본적으로 제공된 것을 지우고 새로 UICollectionViewCell 을 넣어서 해결하고 있다고 한다. 전자와 후자를 비교해 보면, 전자에서 스토리보드가 제공한 셀의 하위뷰는 installed 옵션이 보이며 제거가 가능하지만, 후자에서 직접 삽입한 셀의 하위뷰는 installed 옵션이 보이지 않으며 제거도 불가능하다.
// 참조: https://www.reddit.com/r/swift/comments/o5ns9s/do_you_use_contentview_in_uicollectionviewcell_if/


// ===============================
// NIB vs. 코드
// ===============================

// 같은 뷰를 사용하더라도 스토리보드에 삽입하는 것과 코드로 생성하는 것에서 기본 설정이 다를 수 있음을 주의
// 예를 들어, UIImageView 를 스토리보드에서 생성하면 clipsToBounds 가 디폴트로 true 이지만 코드로 생성하면 false
