import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // ===============================
        // SymbolConfiguration 테스트
        // ===============================
        
        let name = "camera.fill"
        
//        public enum SymbolScale : Int, @unchecked Sendable {
//            case `default` = -1
//            case unspecified = 0
//            case small = 1
//            case medium = 2
//            case large = 3
//        }
        
        for i in -1...3 {
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            imageView.frame.origin = .init(x: i * 50 + 50, y: 0)
            imageView.image = UIImage(systemName: name)?
                .applyingSymbolConfiguration(UIImage.SymbolConfiguration(scale: UIImage.SymbolScale(rawValue: i)!))
            imageView.sizeToFit()
        }
        
//        public enum SymbolWeight : Int, @unchecked Sendable {
//            case unspecified = 0
//            case ultraLight = 1
//            case thin = 2
//            case light = 3
//            case regular = 4
//            case medium = 5
//            case semibold = 6
//            case bold = 7
//            case heavy = 8
//            case black = 9
//        }
        
        for i in 0...9 {
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            imageView.frame.origin = .init(x: i * 50, y: 50)
            imageView.image = UIImage(systemName: name)?
                .applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight(rawValue: i)!))
            imageView.sizeToFit()
        }
        
        // apple.logo 와 같이 weight 가 적용되지 않는 심볼도 있다.
        for i in 0...9 {
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            imageView.frame.origin = .init(x: i * 50, y: 100)
            imageView.image = UIImage(systemName: "apple.logo")?
                .applyingSymbolConfiguration(UIImage.SymbolConfiguration(weight: UIImage.SymbolWeight(rawValue: i)!))
            imageView.sizeToFit()
        }
        
        
        // ===============================
        // renderingMode 테스트
        // ===============================
        
        do {
            // alwaysOriginal (UIImageView 틴트 색상에 영향을 받지 않음)
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            imageView.frame.origin = .init(x: 150, y: 150)
            imageView.image = UIImage(systemName: "apple.logo")?
                .withTintColor(.red, renderingMode: .alwaysOriginal)
            imageView.sizeToFit()
            imageView.tintColor = .green
        }
        
        
        do {
            // alwaysTemplate (UIImageView 틴트 색상에 영향을 받음)
            let imageView = UIImageView()
            self.view.addSubview(imageView)
            imageView.frame.origin = .init(x: 150, y: 200)
            imageView.image = UIImage(systemName: "apple.logo")?
                .withTintColor(.red, renderingMode: .alwaysTemplate)
            imageView.sizeToFit()
            imageView.tintColor = .green
        }
        
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

