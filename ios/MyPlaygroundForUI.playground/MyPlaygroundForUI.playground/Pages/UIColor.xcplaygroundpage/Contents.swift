import UIKit


// w 0.667 a 1.0
dump(UIColor.lightGray)

// w 0.5 a 1.0
dump(UIColor.gray)

// w 0.333 a 1.0
dump(UIColor.darkGray)

// r 0.235 g 0.235 b 0.263 a 0.298
dump(UIColor.placeholderText)

// r 0.235 g 0.235 b 0.263 a 0.29
dump(UIColor.separator)

// r 0.776 g 0.776 b 0.784 a 1.0
dump(UIColor.opaqueSeparator)


// 아래와 같이 시스템 색상 추출이 가능
let color = UIColor.value(forKey: "_systemChromeShadowColor") as? UIColor
