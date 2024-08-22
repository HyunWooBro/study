import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // 기본적으로 버튼의 normal 상태에 대한 설정만 세팅하면 다른 상태에 대한 설정이 부재하더라도 normal 상태의 설정을 이용하도록 되어 있다.
        
        
        
        // Old Style 버튼 정의
        // Create UIButton
        let myButton = UIButton(type: .system)
        // Position Button
        myButton.frame = CGRect(x: 20, y: 20, width: 100, height: 50)
        // Set text on button
        myButton.setTitle("Tap me", for: .normal)
          
        // Make text italic
        myButton.titleLabel?.font = .italicSystemFont(ofSize: 10)
        
        self.view.addSubview(myButton)
        
        
        
        // UIButton 의 Configuration 테스트
        let font = UIFont.preferredFont(forTextStyle: .headline)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = "#춘식이".size(withAttributes: attributes)
        
        var titleContainer = AttributeContainer()
        titleContainer.font = font

        var configuration = UIButton.Configuration.gray()
        configuration.attributedTitle = AttributedString("#춘식이", attributes: titleContainer)
        configuration.baseForegroundColor = .link
        configuration.baseBackgroundColor = .lightGray.withAlphaComponent(0.1)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 7, bottom: 2, trailing: 7)
        
        let button = UIButton(configuration: configuration)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = size.height / 2
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.1).cgColor
        button.frame = CGRect(x: 200.0, y: 10.0, width: size.width + 30.0, height: size.height + 10.0)
        button.clipsToBounds = true

        self.view.addSubview(button)
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()



// ===============================
// UIButton 커스터마이징
// ===============================

// UIButton 을 커스터마이징하는 방법은 크게 4가지이다.
// 1. titleLabel, imageView 등의 속성을 직접 수정
// 2. UIAppearance 활용
// 3. UIAction 활용 (iOS 14+)
// 4. UIButton.Configuration 활용 (iOS 15+)



// ===============================
// UIButton UIAction 세팅 (iOS 14+)
// ===============================

// 세부적인 커스타마이징은 어렵고 타이틀과 이미지 정도만 세팅이 가능하다.

let button = UIButton(primaryAction: UIAction(
    title: "제목",
    image: UIImage(systemName: "pencil"),
    handler: {action in
        
    })
)

button.addAction(UIAction(
    title: "제목",
    image: UIImage(systemName: "pencil"),
    handler: { action in
        
    }), for: .touchUpInside)


// ===============================
// UIButton Configuration 세팅 (iOS 15+)
// ===============================

// 기본 제공 스타일
UIButton.Configuration.plain()
UIButton.Configuration.tinted()
UIButton.Configuration.gray()
UIButton.Configuration.filled()
UIButton.Configuration.borderless()
UIButton.Configuration.bordered()
UIButton.Configuration.borderedTinted()
UIButton.Configuration.borderedProminent()

// 속성을 직접 수정한 것이 더 우선순위가 높다.
do {
    let button = UIButton()
    button.setTitle("title1", for: .normal)
    
    var configuration = UIButton.Configuration.plain()
    configuration.title = "title2"
    button.configuration = configuration
}

// Configuration 과 UIAction 을 동시에 받는 생성자에서는 UIAction 내용이 Configuration 에 복사된다.
do {
    let button = UIButton(
        configuration: UIButton.Configuration.plain(),
        primaryAction: UIAction(title: "제목") { action in
        
        }
    )
    button.configuration?.title
}


var configuration = UIButton.Configuration.plain()
// 백그라운드 설정을 세밀하게 변경하기 위해 테이블셀 및 콜렉션셀 백그라운드 설정을 위해 iOS 14 에서 도입된 다음의 타입을 활용 가능
configuration.background


configuration.title


configuration.title
configuration.attributedTitle
configuration.subtitle
configuration.attributedSubtitle
configuration.image


// 캡슐 형태 버튼
configuration.cornerStyle = .capsule
// 다이나믹 타입 버튼
configuration.cornerStyle = .dynamic
// 세팅한 cornerRadius 적용
configuration.cornerStyle = .fixed
// 미리 세팅된 시스템 small 스타일
configuration.cornerStyle = .small
// 미리 세팅된 시스템 medium 스타일
configuration.cornerStyle = .medium
// 미리 세팅된 시스템 large 스타일
configuration.cornerStyle = .large


configuration.imagePadding
configuration.titlePadding
configuration.contentInsets


configuration.imagePlacement


configuration.buttonSize


// 각 상태(선택, 비활성 등)에 따라 적용되기 전에 바탕이 되는 색상
configuration.baseForegroundColor
configuration.baseBackgroundColor


// 이미지 대신에 ActivityIndicator 출력
configuration.showsActivityIndicator


configuration.preferredSymbolConfigurationForImage

UIButton().currentPreferredSymbolConfiguration

// 버튼의 상태에 따라 외관을 업데이트 하는 코드 관리
UIButton().configurationUpdateHandler = { button in
    
}



UIButton().updateConfiguration()
configuration.automaticallyUpdatesConfiguration
configuration.updated(for: <#T##UIButton#>)



// 토클 버튼으로 만들기
UIButton().changesSelectionAsPrimaryAction


UIButton().showsMenuAsPrimaryAction = true
UIButton().menu = UIMenu(
    title: <#T##String#>,
    subtitle: <#T##String?#>,
    image: <#T##UIImage?#>,
    identifier: <#T##UIMenu.Identifier?#>,
    options: <#T##UIMenu.Options#>,
    preferredElementSize: <#T##UIMenu.ElementSize#>,
    children: [
        UIAction(title: "삭제하기", attributes: .destructive) { action in
        }
    ]
)
