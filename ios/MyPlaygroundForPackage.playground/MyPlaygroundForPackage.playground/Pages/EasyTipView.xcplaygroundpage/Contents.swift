import EasyTipView


// UIView 뿐만 아니라 UIBarItem 에도 적용 가능
EasyTipView.show(forView: <#T##UIView#>, text: <#T##String#>)
EasyTipView.show(forItem: <#T##UIBarItem#>, text: <#T##String#>)


// withinSuperview 가 세팅되면 툴팁을 출력할 때 등록된 superview 의 공간으로 제한된다. 만약 superview 가 스크롤뷰라면 스크롤에 따라 함께 이동한다.
// withinSuperview 가 nil 이라면 상위 윈도우에 추가되며, 툴팁을 출력할 때 윈도우의 모든 공간이 활용된다.
EasyTipView.show(forView: <#T##UIView#>, withinSuperview: <#T##UIView?#>, text: <#T##String#>)
