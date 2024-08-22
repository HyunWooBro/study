import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        // 네비게이션에 삽입하기

        let searchController = UISearchController()
        // 첫번째
        navigationItem.searchController = searchController
        // 두번째
        navigationItem.titleView = searchController.searchBar

        // 첫번째 방법은 네비게이션 아래에 기본적으로 삽입되기 때문에 기본 네베게이션바에 삽입되기를 원한다면 두번째 방법을 선택해야 한다.
        // iOS 16 부터 SearchBarPlacement 를 도입했는데 stack 과 inline 옵션이 있는데 inline 옵션을 선택하면 다른 네비게이션 UI 와 같은 위치를 점유하는 것으로 보인다.
        
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
