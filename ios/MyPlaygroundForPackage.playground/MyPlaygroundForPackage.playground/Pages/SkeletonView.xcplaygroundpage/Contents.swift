import UIKit
import PlaygroundSupport
import SkeletonView

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        UILabel().do {
            self.view.addSubview($0)
            $0.text = nil
            $0.isSkeletonable = true
            $0.frame = .init(x: 0, y: 0, width: 100, height: 100)
        }
        
        
        // text 가 nil 이나 "" 라면 스켈레톤뷰의 레이아웃이 부정확하게 표시될 수 있음을 주의
        
        let label1 = UILabel().then {
            $0.text = nil
            $0.isSkeletonable = true
        }
        
        let label2 = UILabel().then {
            $0.text = nil
            $0.isSkeletonable = true
        }
        
        UIStackView(arrangedSubviews: [label1, label2]).do {
            view.addSubview($0)
            $0.axis = .vertical
            $0.isSkeletonable = true
            $0.layer.borderWidth = 1.0
            $0.frame = .init(x: 0, y: 100, width: 200, height: 100)
        }
        
        
        let label3 = UILabel().then {
            $0.text = "nil"
            $0.isSkeletonable = true
        }
        
        let label4 = UILabel().then {
            $0.text = "nil"
            $0.isSkeletonable = true
        }
        
        UIStackView(arrangedSubviews: [label3, label4]).do {
            view.addSubview($0)
            $0.axis = .vertical
            $0.isSkeletonable = true
            $0.layer.borderWidth = 1.0
            $0.frame = .init(x: 200, y: 100, width: 200, height: 100)
        }
        
        print(label1.layer.bounds)
        
        print(label3.layer.bounds)
        
        
        self.view.isSkeletonable = true
        self.view.showAnimatedGradientSkeleton()
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



// ===============================
// DiffableDataSource 관련
// ===============================

// SkeletonView 는 기본적으로 UICollectionViewDataSource 및 UICollectionViewFlowLayout 을 가정하고 개발되어 있고, 신규 UICollectionViewDiffableDataSource 및 UICollectionViewCompositionalLayout 는 고려되지 않았다. 앞으로도 업데이트를 기대할 수 없을 것으로 보인다.


// 하지만 다음과 같은 방법으로 UICollectionViewDiffableDataSource 에 대해 우회하여 해결할 수 있다.
class SkeletonCollectionViewDiffableDataSource<Section: Hashable, Item: Hashable>: UICollectionViewDiffableDataSource<Section, Item>, SkeletonCollectionViewDataSource {
    
}
// 참조: https://github.com/Juanpe/SkeletonView/issues/279



// ===============================
// 주의사항
// ===============================
    
// UICollectionViewCompositionalLayout 의 경우에는 주 스크롤 방향과 다른 방향의 섹션에 대해서는 처리하지 못한다. 해당 섹션에 대해 상위뷰가 추가되어 isSkeletonable 이 설정되어 있지 않기 때문이다. 레이아웃이 정해진 후 수동으로 해당 뷰에 대해 플래그를 설정하면 해결할 수 있다.
// 참조: https://github.com/Juanpe/SkeletonView/issues/504


// 다음의 델리게이트를 디폴트로 사용하면 automaticNumberOfSkeletonItems 내부적으로 UICollectionViewFlowLayout 를 가정하고 구현되어 있기 때문에 제대로 개수를 구할 수 없으므로 직접 구현해야 한다.
func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    UICollectionView.automaticNumberOfSkeletonItems
}


// showSkeleton() 을 시작하면 현재 뷰부터 isSkeletonable 을 설정한 자식뷰를 재귀적으로 찾아서 스켈레톤뷰로 설정하게 된다. 즉, 뷰계층 상에서 중간에 isSkeletonable 이 빠진다면 더이상 자식뷰를 검색하지 않게 된다.



// ===============================
// 기타
// ===============================

// isHiddenWhenSkeletonIsActive 을 설정하면 스켈레톤뷰가 출력되는 동안에 숨길 수 있다.
let view = UIView()
view.isSkeletonable = true
view.isHiddenWhenSkeletonIsActive = true

// 스켈레톤뷰 활성화 여부
view.sk.isSkeletonActive

// 스켈레톤뷰 트리 구조 출력
view.sk.skeletonTreeDescription
