import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        UIBezierPath(rect: <#T##CGRect#>)
        
        
        UIBezierPath(cgPath: <#T##CGPath#>)
        
        
        UIBezierPath(ovalIn: <#T##CGRect#>)
        
        
        UIBezierPath(roundedRect: <#T##CGRect#>, cornerRadius: <#T##CGFloat#>)
        
        
        UIBezierPath(roundedRect: <#T##CGRect#>, byRoundingCorners: <#T##UIRectCorner#>, cornerRadii: <#T##CGSize#>)
        
        
        UIBezierPath(
            arcCenter: <#T##CGPoint#>,
            radius: <#T##CGFloat#>,
            startAngle: <#T##CGFloat#>,
            endAngle: <#T##CGFloat#>,
            clockwise: <#T##Bool#>
        )
        
        
        
        let path = UIBezierPath()
        path.lineWidth
        path.flatness
        path.lineCapStyle = .round
        path.lineCapStyle = .butt
        path.lineCapStyle = .square
        path.lineJoinStyle = .round
        path.lineJoinStyle = .miter
        path.lineJoinStyle = .bevel
        path.usesEvenOddFillRule
        path.setLineDash(<#T##pattern: UnsafePointer<CGFloat>?##UnsafePointer<CGFloat>?#>, count: <#T##Int#>, phase: <#T##CGFloat#>)
        
        path.move(to: <#T##CGPoint#>)
        path.addLine(to: <#T##CGPoint#>)
        // close() 는 선택
        path.close()
        
        UIColor.systemBlue.set()
        
        path.stroke()
        path.fill()

        
        
        let totalPath = UIBezierPath()

        let height = 50
        let heightTip = height + 30
        let width = 300
        
        let view2 = UIView(frame: .init(x: 0, y: 50, width: 300, height: 80))
//        view2.backgroundColor = .green
        
        let rectangleRect = CGRect(x: 0, y: heightTip - height, width: width, height: height)
        let rectanglePath = UIBezierPath(rect: rectangleRect)
//        UIBezierPath(roundedRect: rectangleRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15))

        let ovalRect = CGRect(x: (width/2) - 40, y: 0, width: 80, height: 80)
        let ovalPath = UIBezierPath(ovalIn: ovalRect)

        totalPath.append(ovalPath)
        totalPath.append(rectanglePath)
//        totalPath.

        let maskLayer = CAShapeLayer()
//        maskLayer.borderWidth = 0.5
//        maskLayer.borderColor = UIColor.lightGray.cgColor
        maskLayer.lineWidth = 5
//        shapeLayer.cornerRadius = Constants.cornerRadius
        maskLayer.strokeColor = UIColor.black.cgColor
        //        maskLayer.masksToBounds = true
        maskLayer.path = totalPath.cgPath
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: heightTip)
        maskLayer.fillColor = UIColor.red.cgColor
        maskLayer.fillRule = .nonZero
//        maskLayer.j
        maskLayer.lineCap = .round
//        maskLayer.
//        view2.layer.mask = maskLayer
        view2.layer.addSublayer(maskLayer)
        
        self.view.addSubview(view2)
        
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
