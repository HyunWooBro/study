import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // Hello World!
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        self.view.addSubview(label)
        
        
        
        // UIDatePicker 테스트
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
//        datePicker.datePickerStyle = .inline
//        datePicker.timeZone.
        datePicker.frame = CGRect(x: 0, y: 220, width: 100, height: 100)
//        datePicker.
        datePicker.layer.borderWidth = 1
        datePicker.layer.borderColor = UIColor.red.cgColor
//        controller.view.addSubview(datePicker)
        
        self.view.addSubview(datePicker)
        
        
        
        // 배경색에 대한 cornerRadius 테스트
        // -> UILabel 만 둥근 테두리를 설정해도 배경색상이 잘리지 않는다.
        let label10 = UILabel()
        self.view.addSubview(label10)
        label10.frame = .init(x: 350, y: 0, width: 70, height: 50)
        label10.backgroundColor = .green
        label10.layer.cornerRadius = 15
        label10.layer.borderWidth = 1
        print(label10.clipsToBounds)
//        label.clipsToBounds = true
        
        let button10 = UIButton()
        self.view.addSubview(button10)
        button10.frame = .init(x: 350, y: 50, width: 70, height: 50)
        button10.titleLabel?.text = "efefe"
        button10.backgroundColor = .green
        button10.layer.cornerRadius = 15
        button10.layer.borderWidth = 1
        print(button10.clipsToBounds)
        
        let stack10 = UIStackView()
        self.view.addSubview(stack10)
        stack10.frame = .init(x: 350, y: 100, width: 70, height: 50)
        stack10.backgroundColor = .green
        stack10.layer.cornerRadius = 15
        stack10.layer.borderWidth = 1
        print(stack10.clipsToBounds)
        
        let field10 = UITextField()
        self.view.addSubview(field10)
        field10.frame = .init(x: 350, y: 150, width: 70, height: 50)
        field10.backgroundColor = .green
        field10.layer.cornerRadius = 15
        field10.layer.borderWidth = 1
        print(field10.clipsToBounds)
        
        let imageView10 = UITextView()
        self.view.addSubview(imageView10)
        imageView10.frame = .init(x: 450, y: 50, width: 70, height: 50)
        imageView10.backgroundColor = .green
        imageView10.layer.cornerRadius = 15
        imageView10.layer.borderWidth = 1
        print(imageView10.clipsToBounds)
        
        let textView10 = UIImageView()
        self.view.addSubview(textView10)
        textView10.frame = .init(x: 450, y: 0, width: 70, height: 50)
        textView10.backgroundColor = .green
        textView10.layer.cornerRadius = 15
        textView10.layer.borderWidth = 1
        print(textView10.clipsToBounds)

    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
