import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        UILabel().do {
            view.addSubview($0)
            $0.backgroundColor = .brown
            $0.text = "xyz"
            $0.sizeToFit()
        }
        
        UIView().do {
            view.addSubview($0)
            $0.frame = .init(x: 100, y: 100, width: 200, height: 200)
            $0.backgroundColor = .lightGray
            $0.layer.borderWidth = 10
            $0.layer.borderColor = UIColor.black.cgColor
            
            let totalPath = UIBezierPath()
            let rectangleRect = CGRect(origin: .zero, size: $0.frame.size)
            let rectanglePath = UIBezierPath(rect: rectangleRect)
            totalPath.append(rectanglePath)
            
            let shape = CAShapeLayer()
            shape.frame = CGRect(origin: .zero, size: $0.frame.size)
            shape.strokeStart = 0
            shape.strokeEnd = 0.5
            shape.strokeColor = UIColor.green.cgColor
            shape.lineWidth = 10
            shape.path = totalPath.cgPath
            shape.fillColor = UIColor.clear.cgColor
            shape.fillRule = .nonZero
            shape.lineCap = .round
            
            $0.layer.addSublayer(shape)
//            $0.clipsToBounds = true
        }
        
        UIView().do {
            view.addSubview($0)
            $0.frame = .init(x: 100, y: 100, width: 200, height: 200)
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.red.cgColor
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


// ===============================
// CALayer
// ===============================

// 기본 클래스는 CALayer
UIView.layerClass


let layer = CALayer()
layer.frame
layer.backgroundColor
// CSS 박스 모델처럼 내부 영역만 차지
layer.borderWidth
layer.borderColor
layer.cornerRadius
layer.maskedCorners
layer.transform
layer.shadowPath
layer.shadowColor
layer.shadowOpacity
layer.shadowOffset
layer.shadowRadius
layer.masksToBounds


let tiled = CATiledLayer()
tiled.tileSize


let shape = CAShapeLayer()
// CAShapeLayer 를 사용할 때에는 path 설정 필수
shape.path
shape.fillRule = .nonZero
shape.fillRule = .evenOdd
shape.fillColor
shape.strokeStart
shape.strokeEnd
shape.strokeColor
// borderWidth 와는 달리 경계선을 중심으로 내부와 외부 영역을 반씩 차지
// 뷰의 clipsToBounds 가 true 로 세팅된 경우 외부 영역은 짤릴 수 있음
shape.lineWidth
shape.lineDashPattern


let gradient = CAGradientLayer()
gradient.type = .axial
gradient.type = .radial
gradient.type = .conic
gradient.colors
gradient.locations
gradient.startPoint
gradient.endPoint


let text = CATextLayer()
text.string
text.font
text.fontSize



// ===============================
// CADisplayLink
// ===============================

let displayLisk = CADisplayLink(target: <#T##Any#>, selector: <#T##Selector#>)
// 런루프 추가 (활성화)
displayLisk.add(to: .current, for: .default)

// 비활성화
displayLisk.invalidate()



// ===============================
// CATransaction
// ===============================

// 예시 (Hero)
CATransaction.begin()
CATransaction.setAnimationTimingFunction(timingFunction)
UIView.animate(withDuration: duration, delay: delay, options: [], animations: animations, completion: nil)
let addedAnimations = CALayer.heroAddedAnimations!
CALayer.heroAddedAnimations = nil
for (layer, key, anim) in addedAnimations {
  layer.removeAnimation(forKey: key)
  self.addAnimation(anim, for: key, to: layer)
}
CATransaction.commit()


// 예시 (FloatingPanel)
private func updateShadow() {
    // Disable shadow animation when the surface's frame jumps to a new value.
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    for (i, shadow) in appearance.shadows.enumerated() {
        let shadowLayer = shadowLayers[i]

        shadowLayer.backgroundColor = UIColor.clear.cgColor
        shadowLayer.frame = layer.bounds

        let spread = shadow.spread
        let shadowRect = containerView.frame.insetBy(dx: -spread, dy: -spread)
        let shadowPath = UIBezierPath.path(roundedRect: shadowRect,
                                           appearance: appearance)
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = shadow.color.cgColor
        shadowLayer.shadowOffset = shadow.offset
        // A shadow.radius value isn't manipulated by a scale(i.e. the display scale). It should be applied to the value by itself.
        shadowLayer.shadowRadius = shadow.radius
        shadowLayer.shadowOpacity = shadow.opacity

        let mask = CAShapeLayer()
        let path = UIBezierPath.path(roundedRect: containerView.frame,
                                     appearance: appearance)
        let size = window?.bounds.size ?? CGSize(width: 1000.0, height: 1000.0)
        path.append(UIBezierPath(rect: layer.bounds.insetBy(dx: -size.width,
                                                            dy: -size.height)))
        mask.fillRule = .evenOdd
        mask.path = path.cgPath
        if #available(iOS 13.0, *) {
            containerView.layer.cornerCurve = appearance.cornerCurve
            mask.cornerCurve = appearance.cornerCurve
        }
        shadowLayer.mask = mask
    }
    CATransaction.commit()
}


// 예시 (FSCalendar)
[CATransaction begin];
[CATransaction setDisableActions:NO];
[self.collectionView reloadData];
[self.calendar.calendarHeaderView reloadData];
[self.calendar layoutIfNeeded];
[CATransaction commit];
