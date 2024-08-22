import UIKit
import PlaygroundSupport
import SnapKit

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // UIImageView Intrinsic Content Size 테스트
        // -> 기본적으로 image 를 세팅하는 것만으로는 사이즈가 설정되지 않음
        // -> sizeToFit(), contentMode 설정, frame 지정, 또는 상위 레이아웃뷰에 의한 사이즈 지정 등의 방식으로 설정할 수 있음
        // -> UIImage 를 지정하면 intrinsicContentSize 값은 세팅되지만 frame 에는 영향 없음
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        stack.backgroundColor = .green
        self.view.addSubview(stack)
        
        let imageView = UIImageView()
//        imageView.frame = CGRect(x: 150, y: 200, width: 50, height: 50)
        imageView.backgroundColor = .black
        print(imageView.intrinsicContentSize)
        imageView.image = UIImage(named: "heart charm.webp")
        print(imageView.intrinsicContentSize)
        print(imageView.contentMode.rawValue)
//        imageView.contentMode = .left
        print(imageView.frame)
//        imageView.sizeToFit()
        print(imageView.contentMode.rawValue)
        print(imageView.frame)
//        imageView.frame = CGRect(x: 150, y: 200, width: 50, height: 50)
        stack.addArrangedSubview(imageView)
        print(imageView.frame)
        
        print(imageView.intrinsicContentSize)
        
        
        // Shadow 테스트
        // -> 그림자는 tint, background 색상이 있어야 렌더링된다.
        let imageView2 = UIImageView()
        imageView2.image = UIImage(systemName: "pencil")
        imageView2.tintColor = .black
//        imageView2.backgroundColor = .blue
        imageView2.sizeToFit()
        imageView2.frame = .init(x: 100, y: 50, width: 100, height: 100)
        // 알파값은 기본 레이어의 그림자에도 적용됨
        imageView2.alpha = 0.5
        // 그림자 색상 (디폴트 검정)
        imageView2.layer.shadowColor = UIColor.red.cgColor
        // 그림자 퍼짐정도 (디폴트 3)
        imageView2.layer.shadowRadius = 10
        // 그림자 오프셋 (디폴트 (0,-3))
        imageView2.layer.shadowOffset = .init(width: 0, height: 5)
        // 그림자 불투명도 (디폴트 0)
        imageView2.layer.shadowOpacity = 1
        self.view.addSubview(imageView2)
        
        
        
        // 부모뷰의 Shadow 테스트
        // -> 부모뷰에 tint, background 색상이 없는데 그림자가 있다면 자식뷰가 그림자를 받게 된다.
        // -> UIStackView 뿐만 아니라 일반 UIView 더라도 상관없는 것으로 보인다.
        let stack2 = UIStackView()
        self.view.addSubview(stack2)
//        stack2.backgroundColor = .green
        stack2.layer.shadowOpacity = 1
        stack2.alignment = .fill
        stack2.distribution = .fill
        stack2.frame = .init(x: 100, y: 150, width: 100, height: 100)
        
        // 자식뷰
        let imageView10 = UIImageView()
        stack2.addArrangedSubview(imageView10)
        imageView10.image = UIImage(systemName: "pencil")
        imageView10.tintColor = .black
        imageView10.sizeToFit()
        imageView10.frame.size = .init(width: 50, height: 50)
        imageView10.snp.makeConstraints {
            $0.size.equalTo(50)
        }
        
        
        
        // Shadow & border 클리핑 테스트
        // -> border 는 클리핑과 관계 없지만 그림자는 영향을 받는다.
        // -> 한편 border 을 지정할 때 클리핑을 함께 하는 이유는 자식뷰도 border 에 맞게 잘라내기 위해서다. (https://shimstone.github.io/ios/objc_corner_radius_clipstobound/)
        let view2 = UIView()
        view2.frame = .init(x: 200, y: 50, width: 100, height: 100)
        view2.backgroundColor = .brown
        view2.layer.cornerRadius = 50
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .init(width: 0, height: 10)
        self.view.addSubview(view2)
//        view2.clipsToBounds = true
        print(view2.clipsToBounds)
        
        let view3 = UIView()
        view3.frame.size = .init(width: 50, height: 50)
        view3.backgroundColor = .gray
        view2.addSubview(view3)
        
        
        
        // UIImage.SymbolConfiguration 테스트
        // small
        let imageView3 = UIImageView()
        imageView3.image = UIImage(systemName: "apple.logo")!
        imageView3.sizeToFit()
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        imageView3.image = imageView3.image?.applyingSymbolConfiguration(configuration)
        imageView3.sizeToFit()
        // image 자체의 scale 과는 상관 없음
        print(imageView3.image?.scale)
        imageView3.layer.borderWidth = 0.5
        self.view.addSubview(imageView3)
        
        // medium
        let imageView4 = UIImageView()
        imageView4.image = UIImage(systemName: "apple.logo")!
        imageView4.sizeToFit()
        let configuration2 = UIImage.SymbolConfiguration(scale: .medium)
        imageView4.image = imageView4.image?.applyingSymbolConfiguration(configuration2)
        imageView4.sizeToFit()
        // image 자체의 scale 과는 상관 없음
        print(imageView4.image?.scale)
        imageView4.layer.borderWidth = 0.5
        self.view.addSubview(imageView4)
        imageView4.frame.origin = .init(x: 50, y: 0)
        
        // large
        let imageView5 = UIImageView()
        imageView5.image = UIImage(systemName: "apple.logo")!
        imageView5.sizeToFit()
        let configuration3 = UIImage.SymbolConfiguration(scale: .large)
        imageView5.image = imageView5.image?.applyingSymbolConfiguration(configuration3)
        imageView5.sizeToFit()
        // image 자체의 scale 과는 상관 없음
        print(imageView5.image?.scale)
        imageView5.layer.borderWidth = 0.5
        self.view.addSubview(imageView5)
        imageView5.frame.origin = .init(x: 100, y: 0)
        
        // 기본적으로 상위 레이아웃을 잡아주는 컨테이너가 없다면 설정값과 상관없이 frame 에 따라 렌더링 된다.
        let imageView6 = UIImageView()
        imageView6.image = UIImage(systemName: "apple.logo")!
        imageView6.frame.size = .init(width: 50, height: 50)
        print(imageView6.intrinsicContentSize)
        imageView6.layer.borderWidth = 0.5
        self.view.addSubview(imageView6)
        imageView6.frame.origin = .init(x: 150, y: 0)
        
        // 설정값에 따라 intrinsicContentSize 가 달라지는 것을 볼 수 있다.
        let imageView7 = UIImageView()
        imageView7.image = UIImage(systemName: "apple.logo")!
//        imageView7.frame.size = .init(width: 50, height: 50)
        let configuration4 = UIImage.SymbolConfiguration(pointSize: 30)
        imageView7.image = imageView7.image?.applyingSymbolConfiguration(configuration4)
        imageView7.sizeToFit()
        print(imageView7.intrinsicContentSize)
        imageView7.layer.borderWidth = 0.5
        self.view.addSubview(imageView7)
        imageView7.frame.origin = .init(x: 200, y: 0)
        
        
        
        // cornerRadius 테스트
        // 말 그대로 코너에서의 반지름 -> 각 모서리에서 cornerRadius 만큼의 반지름을 갖는 원의 사분면 중 하나가 위치하게 된다.
        let view4 = UIView()
        view4.frame = .init(x: 300, y: 0, width: 100, height: 50)
        view4.backgroundColor = .red
        view4.layer.cornerRadius = 25
        view4.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        self.view.addSubview(view4)
        
        
        
        // UIImageView 의 clipsToBounds 테스트
        // -> 스토리보드로 생성하는 것과 코드로 생성할 때 기본 세팅이 다른 경우가 종종 있다.
        // -> UIImageView 의 경우 스토리보드로 생성하면 clipsToBounds 가 true 이지만 스토리보드에서는 false 이다.
        // -> cliipsToBounds 가 false 이면 contentMode 에 의해 뷰의 바운드를 넘어가는 부분을 자르지 않는다.
        let imageView8 = UIImageView()
        imageView8.image = UIImage(named: "heart charm.webp")
        imageView8.clipsToBounds = true
        imageView8.frame = .init(x: 350, y: 100, width: 100, height: 50)
        imageView8.contentMode = .scaleAspectFill
        imageView8.layer.borderWidth = 0.5
        self.view.addSubview(imageView8)
        
        // 비교군
        let imageView9 = UIImageView()
        imageView9.image = UIImage(named: "heart charm.webp")
//        imageView9.clipsToBounds = true
        imageView9.frame = .init(x: 500, y: 100, width: 100, height: 50)
        imageView9.contentMode = .scaleAspectFill
        imageView9.layer.borderWidth = 0.5
        self.view.addSubview(imageView9)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
