import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        // ===============================
        // 개요
        // ===============================
        
        // [출력 텍스트]
        // UILabel
        
        // [입력 텍스트]
        // UITextField : 한줄
        // UITextView : 여러 라인
        
        
        
        // ===============================
        // UITextView 에 placeholder 추가
        // ===============================
        
        // UITextField 에서 제공하는 placeholder 을 기본적으로 가지고 있지 않다.
        // 구현하는 방법은 크게 다음과 같다.
        
        // 1. 기본 text 프로퍼티를 공유해서 사용하기
        // => 유저가 미리 지정한 placeholder 와 같은 텍스트를 입력할 경우 구분 필요
        // => 서버에 보내는 등의 실제 사용할 때 placeholder 인지 유저가 입력한 값인지 구분 필요
        // => placeholder 출력된 상황에서 입력시 placeholder 뒤로 입력되지 않도록 조치 필요
        // => 고려해야할 부분이 많아 구현이 지저분함
        
        // 2. UILabel 을 추가해서 placeholder 용도로 사용하기
        // => UITextView 의 exclusionPaths 등을 고려할 수 없음
        
        // 3. UITextView 를 추가해서 placeholder 용도로 사용하기
        // => 직관적으로 exclusionPaths, textContainerInset 등의 프로퍼티를 동일하게 세팅하여 처리 가능
        
        
        
        // ===============================
        // UITextView 의 NSTextContainer
        // ===============================
        
        let view = UITextView()
        view.textContainer.exclusionPaths
        
        
        
        // ===============================
        // 3가지 텍스트 관련 UI뷰 테스트
        // ===============================
        
        // UILabel
        let label = UILabel()
        label.text = "abc\nefe43634543643634534efewrweertrt4545346434t4yt4eryetr\n"
        // UILabel 은 기본적으로 한줄로 출력되지만 원한다면 여러 라인으로 표현 가능하다.
        label.numberOfLines = 0
        label.frame = .init(x: 0, y: 0, width: 200, height: 200)
        label.sizeToFit()
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.blue.cgColor
        self.view.addSubview(label)
        print(label.countLines())
        
        let label2 = UILabel()
        label2.text = "xfere"
        label2.numberOfLines = 3
        label2.frame = .init(x: 200, y: 0, width: 100, height: 100)
        label2.sizeToFit()
        label2.layer.borderWidth = 0.5
        label2.layer.borderColor = UIColor.blue.cgColor
        self.view.addSubview(label2)
        print(label2.countLines())
        // numberOfLines 는 최대 라인수를 의미하는 것이지 실제 영역을 차지하지는 않는다.
        print(label2.numberOfLines)
        
        
        // UITextView
        let textView = UITextView()
        textView.text = "Efefewre\n23111\n"
        textView.frame = .init(x: 0, y: 100, width: 100, height: 100)
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.green.cgColor
        print(textView.contentSize)
        self.view.addSubview(textView)
        // 기본적으로 UITextView 의 font 는 nil
        print(textView.font)
        // 텍스트 컨테이너 Inset (외곽 프레임과 내부 텍스트 컨테이너 사이의 여백)
        print(textView.textContainerInset)
        
        
        let textView2 = UITextView()
        textView2.text = "Efefewre\n23111\n"
        textView2.frame = .init(x: 100, y: 100, width: 100, height: 100)
//        textView2.sizeToFit()
        textView2.layer.borderWidth = 0.5
        textView2.layer.borderColor = UIColor.green.cgColor
        // nil 폰트일 때와 가장 가까운 포트 크기이지만 일치하지는 않는다
        textView2.font = .systemFont(ofSize: 12)
        print(textView2.contentSize)
        textView2.tintColor = .black
        self.view.addSubview(textView2)
        // 부정확
        print(textView2.numberOfLines1())
        // 정확
        print(textView2.numberOfLines2())
        // 부정확
        print(textView2.numberOfLines3())
        // \n 로 끝나면 제외됨
        print(textView2.numberOfLines4())
        // 정확
        print(textView2.countLines())
        print(textView2.font)
        
        print(textView2.textContainer.size)
        
        
        // UITextField
        let field = UITextField()
        field.text = "Efefewre\n23111\n"
        field.frame = .init(x: 200, y: 100, width: 100, height: 100)
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(field)
        print(field.font)
        
        
        // 텍스트 UI 에서 tintColor 는 사용되지 않는 것으로 보인다.
        let label01 = UILabel()
        self.view.addSubview(label01)
        label01.frame = .init(x: 0, y: 200, width: 100, height: 100)
        label01.layer.borderWidth = 0.5
        label01.layer.borderColor = UIColor.black.cgColor
        label01.textColor = .red
        label01.tintColor = .green
        label01.text = "label01"
        
        let textView01 = UITextView()
        self.view.addSubview(textView01)
        textView01.frame = .init(x: 100, y: 200, width: 100, height: 100)
        textView01.layer.borderWidth = 0.5
        textView01.layer.borderColor = UIColor.black.cgColor
        textView01.textColor = .red
        textView01.tintColor = .green
        textView01.text = "textView01"
        
        let textField01 = UITextField()
        self.view.addSubview(textField01)
        textField01.frame = .init(x: 200, y: 200, width: 100, height: 100)
        textField01.layer.borderWidth = 0.5
        textField01.layer.borderColor = UIColor.black.cgColor
        textField01.textColor = .red
        textField01.tintColor = .green
        textField01.text = "textField01"
        
    }
    
    
}

extension UILabel {
    // 출처: https://iostutorialjunction.com/2022/08/find-number-of-lines-for-uilabel-swift-tutorial.html
    func countLines() -> Int {
        guard let myText = self.text as NSString? else {
            return 0
        }
        // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [.font: self.font as Any], context: nil)
        return Int(round(labelSize.height / self.font.lineHeight))
    }
}

extension UITextView {
    
    func numberOfLines1() -> Int {
        return Int(contentSize.height / font!.lineHeight);
    }
    
    // 출처: https://stackoverflow.com/questions/5837348/counting-the-number-of-lines-in-a-uitextview-lines-wrapped-by-frame-size
    func numberOfLines2() -> Int {
        let rawLineNumber = (contentSize.height - textContainerInset.top - textContainerInset.bottom) / font!.lineHeight;
        let finalLineNumber = Int(round(rawLineNumber))
        return finalLineNumber
    }
    
    // 출처: https://woongsios.tistory.com/95
    func numberOfLines3() -> Int {

        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)

        return Int(estimatedSize.height / (self.font!.lineHeight))
    }

    // 출처: https://stackoverflow.com/questions/31663159/get-number-of-lines-in-uitextview-without-contentsize-height
    func numberOfLines4() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange: NSRange = NSMakeRange(0, 1)
        var index = 0
        var numberOfLines = 0

        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt:
                index, effectiveRange: &lineRange
            )
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        return numberOfLines
    }

    // 출처: https://iostutorialjunction.com/2022/08/find-number-of-lines-for-uilabel-swift-tutorial.html
    func countLines() -> Int {
        guard let myText = self.text as NSString? else {
            return 0
        }

        // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [.font: self.font as! Any], context: nil)
        return Int(round(labelSize.height / self.font!.lineHeight))
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
