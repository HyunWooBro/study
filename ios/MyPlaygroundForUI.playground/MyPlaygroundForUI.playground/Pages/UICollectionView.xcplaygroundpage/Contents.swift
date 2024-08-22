import UIKit


let collectionView = UICollectionView()


// ===============================
// 주요 프로퍼티
// ===============================

collectionView.delegate
collectionView.dragDelegate
collectionView.dropDelegate

collectionView.collectionViewLayout

collectionView.dataSource
collectionView.prefetchDataSource



// ===============================
// 주요 프로세스
// ===============================

// 1. 레이아웃 정보 등록
// 셀을 보관하는 큐에서 반환될 셀의 레이아웃 정보를 확인한다.

// 2. 데이터소스 셀 생성/재활용
// 큐에 남는 셀이 있으면 꺼내서 반환하고, 여유분이 없으면 생성하여 반환
// !!!: 이때, 이미 등록된 레이아웃 정보를 바탕으로 셀의 사이즈가 세팅되어 반환
// !!!: estimated 속성이라면 셀의 preferredLayoutAttributesFitting() 까지 호출되어 사이즈를 구함 (Size 페이지의 Self-Sizing 참조)



// ===============================
// dequeueReusableCell() vs. cellForItem()
// ===============================

collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
// dequeueReusableCell() 는 기본적으로 스크롤하면서 새로운 셀이 등장할 때 사용된다.
// 캐시된 셀을 되돌려 주거나 비어있다면 새로 생성하여 전달한다.
// 일반적으로 셀의 prepareForReuse() 을 호출하지만, reconfigureItems() 등을 통해 기존 셀은 유지하면서 내용만 갱신하는 경우 등에서는 호출되지 않을 수 있다.

collectionView.cellForItem(at: <#T##IndexPath#>)
// cellForItem() 은 기본적으로 보이는 셀 또는 터치한 셀을 얻어올 때 사용된다.
// iOS 15 이전에는 보이지 않는 셀을 요구할 시 nil 을 반환했지만 15 이후에는
// 몇 가지 경우에 한해서 유효한 셀을 반환할 수 있다.
                                                               


// ===============================
// collectionViewContentSize
// ===============================

collectionView.collectionViewLayout.collectionViewContentSize
// UICollectionView 는 UIScrollView 와 달리 컨텐츠의 사이즈를 계산하기 위해 contentSize 또는 contentLayoutGuide 를 직접 사용하지 않는 것으로 보이며 UICollectionViewLayout 의 collectionViewContentSize 를 사용하는 것으로 보인다. 물론, 결과적으로 contentSize 의 값을 업데이트할 것으로 보인다.



// ===============================
// reloadData()
// ===============================

collectionView.reloadData()
// 기본적으로 reloadData() 에 대한 완료 콜백을 제공되지 않아서 UICollectionView 를 상속해서 layoutSubviews() 에서 완료되는 시점을 찾는 편법 등을 사용한다. UICollectionViewDiffableDataSource 를 사용한다면 apply() 를 활용할 때 완료 콜백을 제공하기 때문에 편리하다. 결국, 신규 DataSource 를 이용하는 것이 최적화, 애니메이션, 편의성 모두에서 유리할 수 있다.

// 콜백을 제공하는 커스텀 콜렉션뷰 예제
// 출처: https://woongsios.tistory.com/105
class MyCollectionView: UICollectionView {
    
    private var reloadDataCompletion: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let completion = reloadDataCompletion else { return }
        completion()
        reloadDataCompletion = nil
    }

    // reloadData() 호출에 대한 콜백 기능 추가 버전
    func reloadDataWithCompletion(_ completion: (() -> Void)?) {
        reloadDataCompletion = completion
        reloadData()
    }
}



// ===============================
// Prefetching
// ===============================

collectionView.isPrefetchingEnabled = false
// 셀의 크기가 다이나믹하다면 Prefetching 기능을 꺼두는 것이 좋다.
// 참조: https://stackoverflow.com/questions/53714545/uicollectionview-prefetching-doesnt-work-with-dynamic-cell-sizing



// ===============================
// scrollToItem()
// ===============================

let indexPath = IndexPath(item: 5, section: 0)
collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
// 지정한 위치의 지정한 셀로 스크롤 (지정 가능한 위치는 다음과 같음)
// static var top: UICollectionView.ScrollPosition
// static var centeredVertically: UICollectionView.ScrollPosition
// static var bottom: UICollectionView.ScrollPosition
// static var left: UICollectionView.ScrollPosition
// static var centeredHorizontally: UICollectionView.ScrollPosition
// static var right: UICollectionView.ScrollPosition



// ===============================
// UICollectionViewFlowLayout
// ===============================

// UICollectionViewLayout 의 기본적인 구현 객체
// 크게 델리게이트 방식과 프로퍼티 방식을 지원한다. 전자는 로직을 담을 수 있는 반면, 후자는 고정된 값만을 주입할 수 있다는 차이점이 있다. 기본적으로 델리게이트 방식으로 정의가 되지 않으면 프로퍼티 값을 사용한다.

let flowLayout = UICollectionViewFlowLayout()

// 셀의 사이즈가 유동적이라면 Self-Sizing 활성화를 한다. .zero 가 아닌 값을 주면 활성화 되는데 셀 사이즈 관련 메서드나 프로퍼티를 정의하지 않으면 estimatedItemSize 에 설정한 값이 셀의 preferredLayoutAttributesFitting() 메서드로 전달되어 사이즈를 구한다.
flowLayout.estimatedItemSize = .init(width: 100, height: 200)
// automaticSize 값은 CGSize(width: 50, height: 50) 과 같음
flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
// 셀의 사이즈가 고정적이라면 Self-Sizing 비활성화를 위해 아래와 같이 설정해야 한다. 그리고 셀 사이즈 관련 메서드 또는 프로퍼티를 적절하게 설정하면 된다.
flowLayout.estimatedItemSize = .zero

// [셀 사이즈]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 CGSize(width: 50, height: 50))
flowLayout.itemSize

// [메인축 방향으로 셀 간격]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 10)
flowLayout.minimumLineSpacing

// [크로스축(메인축의 90도 회전) 방향으로 셀 간격]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 10)
flowLayout.minimumInteritemSpacing

// [헤더 사이즈]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 .zero)
flowLayout.headerReferenceSize

// [푸터 사이즈]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 .zero)
flowLayout.footerReferenceSize

// [섹션 패팅]
// 아래의 메서드가 정의되지 않으면
extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        <#code#>
    }
}
// 아래의 프로퍼티를 사용한다. (디폴트 .zero)
flowLayout.sectionInset
