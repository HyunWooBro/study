import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        

        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.backgroundColor = .brown
        scrollView.layer.borderWidth = 0.5
        scrollView.frame = .init(x: 0, y: 0, width: 200, height: 300)
        scrollView.delegate = self
        

        let view = UIImageView()
        scrollView.addSubview(view)
        view.backgroundColor = .red
        view.frame = .init(x: 0, y: 0, width: 100, height: 200)
        
        
        
        scrollView.isScrollEnabled
        
        // true 일 경우 스크롤이 시작한 방향으로 락을 걸어 다른쪽 방향으로 스크롤 되는 것을 막는다.
        // 대각선 방향으로 시작했다면 어느 방향으로도 락을 걸지 않는다.
        scrollView.isDirectionalLockEnabled = true
        
        // 가장자리에서 스크롤 바운스 기능 활성화 여부
        scrollView.bounces = true
        // 스크롤 바운스 기능이 활성화 된 상태에서 true 인 경우 컨텐츠의 크기가 스크롤뷰 보다 작아도 수직 바운스 가능
        scrollView.alwaysBounceVertical = true
        // 스크롤 바운스 기능이 활성화 된 상태에서 true 인 경우 컨텐츠의 크기가 스크롤뷰 보다 작아도 수평 바운스 가능
        scrollView.alwaysBounceHorizontal = false
        
        // 페이징 기능 제공
        // 한계 : 스크롤뷰의 크기로만 페이징 하기 때문에 복잡한 응용을 하기에는 까다로움
        scrollView.isPagingEnabled = false
        
        
        scrollView.contentOffset
        
        // 컨텐츠와 스크롤뷰와의 패딩값
        // contentSize 에는 영향을 주지 않는다.
        scrollView.contentInset.top = 10
        
        scrollView.contentInsetAdjustmentBehavior = .never
        
        // true 이면 스테이스바를 터치시 최상단까지 자동 스크롤
        scrollView.scrollsToTop = true
        
        
        // 스크롤시 감속이 빨라서 비교적 빠르게 멈춤
        scrollView.decelerationRate = .fast
        // 스크롤시 감속이 보통 (디폴트)
        scrollView.decelerationRate = .normal
        
        
        // 다크모드에서
        scrollView.indicatorStyle = .white
        // 라이트모드에서
        scrollView.indicatorStyle = .black
        scrollView.scrollIndicatorInsets
        scrollView.verticalScrollIndicatorInsets
        scrollView.horizontalScrollIndicatorInsets
        scrollView.showsVerticalScrollIndicator
        scrollView.showsHorizontalScrollIndicator
        
        
        
        // 사각 영역이 화면에 포함되도록 스크롤
        scrollView.scrollRectToVisible(.init(x: 0, y: 700, width: 200, height: 200), animated: true)
        
        
        
        // contentSize vs. contentLayoutGuide 테스트
        // -> contentSize 는 iOS 2 부터 도입되었고 contentLayoutGuide 는 iOS 11 부터 도입됨
        // -> contentSize 또는 contentLayoutGuide 적용해도 되지만 둘 다 동시에 적용하면 contentLayoutGuide 의 값으로 적용된다. 내부적으로 contentLayoutGuide 의 크기를 contentSize 의 크기로 덮어 씌워지는 것으로 보인다. 즉, contentLayoutGuide 는 이후에 보조적인 역할을 하기 위해 추가된 것이고 스크롤뷰는 내부적으로 contentSize 값을 컨텐츠의 사이즈 값으로 여전히 사용하고 있음을 알 수 있다.
        
        scrollView.contentSize = .init(width: 200, height: 1000)
        
        scrollView.contentLayoutGuide.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // 초기에는 높이가 1000 이지만
        print(scrollView.contentSize)
        
        let button = UIButton()
        self.view.addSubview(button)
        button.configuration = UIButton.Configuration.plain()
        button.setTitle("contentSize 확인하기", for: .normal)
        button.backgroundColor = .green
        button.frame = .init(x: 300, y: 0, width: 200, height: 100)
        button.layer.borderWidth = 0.5
        button.addAction(UIAction(handler: { action in
            // 이후에는 200 으로 변경됨
            print(scrollView.contentSize)
        }), for: .touchUpInside)
        
        
    }
}

extension MyViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 유저가 터치를 떼었을 때 스크롤이 지속되고 있는지 여부
        print("scrollView.isDecelerating : \(scrollView.isDecelerating)")
        // 스크롤 중일 때 유저가 터치하고 있거나 터치를 떼더라도 유저가 의도한 방양일 경우 true 반환
        // 예를 들어, 유저가 터치하면서 스크롤 중일 때는 true, 유저가 터치를 떼어서 자동으로 스크롤 되게 하더라도 ture, 스크롤이 가장자리에 도달하여 반대방향으로 진행되면 유저가 진행한 방향이 아니므로 false 반환
        print("scrollView.isDragging : \(scrollView.isDragging)")
        // 스크롤 중일 때 유저가 터치하고 있을 경우에만 true
        print("scrollView.isTracking : \(scrollView.isTracking)")
        print("======================")
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



// 스크롤 가능한 조건
// 세로를 기준으로 스크롤이 가능하게 하려면 scrollView 의 높이보다 컨텐츠의 높이가 커야 한다.
// contentInset 이 존재한다면 컨텐츠의 높이와 더한다.
// LayoutGuide 를 사용한다고 가정한다면
// scrollView.contentLayoutGuide.layourFrame.height + scrollView.contentInset.top + scrollView.contentInset.bottom > scrollView.frameLayoutGuide.layoutFrame.height 이라면 스크롤 가능한 것이다.



// UIScrollView 의 frameLayoutGuide 가 활성화된 경우, UIScrollView 의 자식 뷰이면서 UIScrollView 에 대해 Constraint 를 추가 하더라도 UIScrollView 자체가 아닌 contentLayoutGuide 에 대해 설정되는 것으로 보인다. 그리하여 스크롤 하더라도 contentLayoutGuide 에 따라 함께 이동하는 것을 볼 수 있다. 자식 뷰를 floating 한 상태로 유지하고자 한다면 frameLayoutGuide 에 대해 Constraint 을 추가해야 한다.
