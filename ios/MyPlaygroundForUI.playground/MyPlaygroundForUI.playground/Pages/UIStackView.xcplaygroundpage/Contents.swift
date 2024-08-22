import UIKit
import PlaygroundSupport
import SnapKit

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // distribution 값이 fill, equalSpacing, 또는 equalCentering 인 경우에, 늘어나거나 줄어드는 대상은 인덱스를 기준으로 가장 마지막 뷰이다.
        
        // axis 는 스택이 쌓이는 방향이며 기본적으로 그 방향으로 스택의 크기만큼 컨텐츠를 채운다는 것이 중요하다.
        
        // alignment 는 axis 의 대각선 방향으로의 정렬이며 fill 은 스택의 크기만큼 채운다는 것이고 나머지는 일반적인 정렬 방식이다.
        // -> fill 인 경우 대각선 방향의 컨텐츠의 레이아웃 제약을 파괴한다. 하지만 여러 스택이 중첩되어 있고 바깥의 스택이 fill 이라고 하더라도 대각선 방향의 컨텐츠의 제약을 파괴하지 않는다. 그러면서 axis 방향의 제약도 파괴하지 않는 것으로 보인다.
        
        // 레이아웃마진을 적용하기 위해서는 isLayoutMarginsRelativeArrangement 를 true 로 세팅해야 한다는 것을 주의해야 한다. (스토리보드에서는 레이아웃마진을 세팅하면 자동으로 세팅됨)
        
        // 자식뷰를 추가하거나 제거할 때 기존의 addSubview() 또는 removeFromSuperview() 를 사용하는 것이 아니라 addArrangedSubview() 또는 removeArrangedSubview() 를 사용해야 레이아웃 프로세스에서 취급된다. 단순히 addSubview() 로 추가한다면 레이아웃 프로세스에서 교려되지 않는 일반 자식뷰가 된다.
        // -> 자식뷰가 아닌 뷰를 addArrangedSubview() 를 사용하여 추가하면 addSubview() 까지 적용되지만, removeArrangedSubview() 를 했다고 자식뷰에서도 제외되지는 않는다. 완전히 제거하기를 원한다면 직접 removeFromSuperview() 를 호출해야 하며, removeArrangedSubview() 를 먼저 호출할 필요는 없다.
        
        // 스택뷰가 스크롤뷰 내부에 포함되어 있고 insetsLayoutMarginsFromSafeArea 가 true 인 경우, 스크롤뷰의 스크롤 초기 또는 마지막 지점에서 스택뷰가 SafeArea 를 침범하는 지점에 있다면 자동으로 SafeArea 를 침범하지 않으려 한다. 이 과정에서 스크롤이 부드럽게 이루어지지 않고 이상하게 보일 수 있다.
        
        
        // ===============================
        // 중첩 UIStackView 테스트
        // ===============================
        
        let stack1 = UIStackView()
        self.view.addSubview(stack1)
        stack1.axis = .vertical
        stack1.backgroundColor = .lightGray
        stack1.frame = .init(x: 0, y: 0, width: 200, height: 200)
        stack1.alignment = .fill
//        stack1.distribution = .fillProportionally
        
        let stack2 = UIStackView()
        stack2.axis = .vertical
        stack2.backgroundColor = .green
        stack2.distribution = .equalCentering
        stack2.isLayoutMarginsRelativeArrangement = true
        stack2.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        stack1.addArrangedSubview(stack2)
        stack2.alignment = .fill
        
        let stack3 = UIStackView()
        stack3.axis = .vertical
        stack3.backgroundColor = .link
        stack3.isLayoutMarginsRelativeArrangement = true
        stack3.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        stack2.addArrangedSubview(stack3)
        stack3.alignment = .fill
        
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.snp.makeConstraints {
            $0.size.equalTo(150)
        }
//        imageView.image = UIImage(systemName: "apple.logo")
        stack3.addArrangedSubview(imageView)
        
        
        // ===============================
        // spacing vs. customSpacing 테스트
        // ===============================
        
        do {
            let stack = UIStackView()
            self.view.addSubview(stack)
            stack.axis = .vertical
            stack.backgroundColor = .lightGray
            stack.alignment = .fill
            stack.spacing = 10
            stack.snp.makeConstraints {
                $0.size.equalTo(100)
                $0.leading.equalTo(300)
            }
            
            let view1 = UILabel()
            stack.addArrangedSubview(view1)
            view1.backgroundColor = .red
            view1.text = "100"
            
            let view2 = UILabel()
            stack.addArrangedSubview(view2)
            view2.backgroundColor = .green
            view2.text = "200"
            
            // spacing 이 전체 자식뷰에 대해 적용되는 수치라면
            stack.spacing
            // setCustomSpacing 은 특정 뷰에 적용되는 수치이다.
            stack.setCustomSpacing(10, after: view2)
            
            UIStackView.spacingUseDefault
            UIStackView.spacingUseSystem
        }
        
        // ===============================
        // Baseline Alignment 테스트
        // ===============================
        
        do {
            let stack = UIStackView()
            self.view.addSubview(stack)
            stack.axis = .horizontal
            stack.backgroundColor = .lightGray
            stack.alignment = .firstBaseline
//            stack.alignment = .lastBaseline
            stack.spacing = 10
            stack.snp.makeConstraints {
                $0.size.equalTo(100)
                $0.leading.equalTo(400)
            }
            
            let view1 = UILabel()
            stack.addArrangedSubview(view1)
            view1.backgroundColor = .red
            view1.text = "100"
            
            let view2 = UILabel()
            stack.addArrangedSubview(view2)
            view2.backgroundColor = .green
            view2.text = "200"
            view2.font = .systemFont(ofSize: 30)
            
        }
        
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
