import Foundation
import UIKit


// UICollectionViewCompositionalLayout 에 대한 정리


// ===============================
// NSCollectionLayoutDimension
// ===============================

// [.estimated]
// 초기 값은 preferredLayoutAttributesFitting() 을 거쳐 systemLayoutSizeFitting() 의 targetSize 파라미터로 전달되고 해당 축의 최종 값이 계산된다. (Size 플레이그라운드 페이지 참조)

// [.fractional]
// Inset 를 고려하여 결정된다. 예를 들어 전체 너비에 대해 fractionalWidth 가 1인 경우, 기본적으로 전체 너비만큼 부여받지만 Inset 가 존재하면 그만큼 차감된다.

// [.absolute]
// Inset 가 존재한다면 차감한 값이 실제 컨텐츠의 영역이다.



// ===============================
// boundarySupplementaryItems
// ===============================

// boundarySupplementaryItems 은 기본적으로 content 가 아니다.
// 따라서 contentInsets 의 top 이나 bottom 만큼 떨어져서 자리잡는다.
// 한편 leading 또는 trailing 만큼 가장자리에서 떨어져 위치한다.



// ===============================
// item vs. group
// ===============================

// size 를 갖게 하는 것과 다르게 하는 것과의 차이
// 페이징 처리 등에 group 활용 가능

// item
let itemSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(1.0),
    heightDimension: .fractionalHeight(1.0)
)
let item = NSCollectionLayoutItem(layoutSize: itemSize)

let groupSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(0.45),
    heightDimension: .absolute(150.0)
)
let group = NSCollectionLayoutGroup.horizontal(
    layoutSize: groupSize,
    subitems: [item]
)

// Supplementary
let headerSize = NSCollectionLayoutSize(
    widthDimension: .fractionalWidth(1.0),
    heightDimension: .absolute(50.0)
)
let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "", alignment: .top)
header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

// section
let section = NSCollectionLayoutSection(group: group)
section.orthogonalScrollingBehavior = .continuous
section.boundarySupplementaryItems = [header]
section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 10, bottom: 10, trailing: 10)

// Cell, Supplementary, Decoration 뷰가 새로이 등장하기 전에 호출됨
section.visibleItemsInvalidationHandler = { visibleItems, scrollOffset, layoutEnvironment in
    // 컨테이너의 컨텐츠 사이즈 높이 등에 접근 가능
    layoutEnvironment.container.contentSize.height
}


// ===============================
// UICollectionViewCompositionalLayout
// ===============================

// UICollectionViewListCell 은 보통 어떻게 높이를 세팅할까?
// UICollectionViewCompositionalLayout 에서 NSCollectionLayout... 류의 방식을 통해 설정하는 것과 달리 다음과 같이 직접 셀에서 지정해 줘야 하는 것으로 보인다.
// 1. 직접 AutoLayout 방식으로 제약 추가
// 2. systemLayoutSizeFitting() 메서드를 오버라이딩 하여 간접적으로 사이즈 설정



// ===============================
// 기타
// ===============================

// UICollectionViewCompositionalLayout 을 사용하면 scroll 방향에 따라  alwaysBounceVertical 또는 alwaysBounceHorizontal 가 자동으로 세팅되는 것으로 보인다.



let collectionView = UICollectionView()

// UICollectionViewCompositionalLayout 의 .fractionalWidth 은 UIScrollView 의 contentInset 을 고려하지 않고 Section 의 너비를 UICollectionView 전체 너비로 기본 설정함
var inset = collectionView.contentInset
inset.left = 10
inset.right = 10
collectionView.contentInset = inset



// !!!: UICollectionViewCompositionalLayoutConfiguration() 을 신규로 주입하지 않고 기존 configuration 의 속성만 수정하면 제대로 적용되지 않기 때문에 반드시 새로 주입해야 한다. (didSet 을 통한 옵저버로 구현된 것으로 보임)

// 이렇게 사용하는 것이 아니라
collectionView.collectionViewLayout = collectionViewLayout()
collectionView.configuration

// 이런 식으로 사용해야 하는 것으로 보임
var configuration = UICollectionViewCompositionalLayoutConfiguration()
let layout = collectionViewLayout()
layout.configuration = configuration
collectionView.collectionViewLayout = layout



// 방향
configuration.scrollDirection = .horizontal
configuration.scrollDirection = .vertical

