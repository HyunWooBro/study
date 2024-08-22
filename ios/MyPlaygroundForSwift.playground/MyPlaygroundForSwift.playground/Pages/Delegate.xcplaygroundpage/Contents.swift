import UIKit


// delegate 는 제어권을 일부 나눠주는 작은 프레임워크 버전이라고 볼 수 있다.


// ===============================
// 주의사항 (weak 메모리 관리)
// ===============================

let collectionView = UICollectionView()


class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
}

func setupDelegate() {
    
    // weak open var delegate: UICollectionViewDelegate?
    // weak open var dataSource: UICollectionViewDataSource?
    // !!!: 일반적으로 UIKit 에서 사용되는 delegate 는 순환참조를 피하기 위해서 weak 타입으로 선언되어 있다. 따라서 단순히 레퍼런스를 전달한 것만으로는 참조가 유지되지 않는다.
    
    let delegate = CollectionViewDelegate()
    collectionView.delegate = delegate
    
    // setupDelegate() 가 끝나면 CollectionViewDelegate 레퍼런스는 무효화되고 weak 타입의 delegate 또한 무효화 횐다.
}



// ===============================
// 주의사항 (호출 조건)
// ===============================

// !!!: 일반적으로 delegate 를 발생시키는 경우는 UI 통해 인터렉션을 하는 경우에 한정하는 것으로 보이며, 코드로 값을 직접 변경하는 방식으로는 호출되지 않는 것으로 보인다. (delegate 뿐만 아니라 action 도 동일한 것으로 보임)

class Test: NSObject {
    func continfure() {
        let controller = UITabBarController()
        controller.delegate = self
        // 코드로 수정하는 경우 delegate 가 호출되지 않는다.
        controller.selectedIndex = 1
    }
}

extension Test: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}



