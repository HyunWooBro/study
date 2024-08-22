import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // preferredFont 테스트
        // preferredFont 는 유저 세팅에 따라 상대적으로 변경될 수 있다.
        
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .largeTitle)
            $0.text = "ef"
            $0.frame = .init(x: 0, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .title1)
            $0.text = "ef"
            $0.frame = .init(x: 50, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .title2)
            $0.text = "ef"
            $0.frame = .init(x: 100, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .title3)
            $0.text = "ef"
            $0.frame = .init(x: 150, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .headline)
            $0.text = "ef"
            $0.frame = .init(x: 200, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .subheadline)
            $0.text = "ef"
            $0.frame = .init(x: 250, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .body)
            $0.text = "ef"
            $0.frame = .init(x: 300, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .callout)
            $0.text = "ef"
            $0.frame = .init(x: 350, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .footnote)
            $0.text = "ef"
            $0.frame = .init(x: 400, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .caption1)
            $0.text = "ef"
            $0.frame = .init(x: 450, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        UILabel().do {
            $0.font = .preferredFont(forTextStyle: .caption2)
            $0.text = "ef"
            $0.frame = .init(x: 500, y: 0, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        
        
        // systemFont 테스트
        
        UILabel().do {
            $0.font = .systemFont(ofSize: 17)
            $0.text = "efef"
            $0.frame = .init(x: 0, y: 50, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        UILabel().do {
            $0.font = .boldSystemFont(ofSize: 17)
            $0.text = "efef"
            $0.frame = .init(x: 50, y: 50, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        UILabel().do {
            $0.font = .italicSystemFont(ofSize: 17)
            $0.text = "efef"
            $0.frame = .init(x: 100, y: 50, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        UILabel().do {
            $0.font = .monospacedSystemFont(ofSize: 17, weight: .medium)
            $0.text = "efef"
            $0.frame = .init(x: 150, y: 50, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        UILabel().do {
            $0.font = .monospacedDigitSystemFont(ofSize: 17, weight: .medium)
            $0.text = "efef"
            $0.frame = .init(x: 200, y: 50, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        
        
        // 커스텀 폰트 테스트
        UILabel().do {
            $0.font = UIFont(name: "Snell Roundhand", size: 25)
            $0.text = "efef"
            $0.frame = .init(x: 0, y: 100, width: 50, height: 50)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview($0)
        }
        
        
        
        // 디폴트 시스템 폰트 사이즈
        print(UIFont.systemFontSize)
        print(UIFont.labelFontSize)
        print(UIFont.buttonFontSize)
        print(UIFont.smallSystemFontSize)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


