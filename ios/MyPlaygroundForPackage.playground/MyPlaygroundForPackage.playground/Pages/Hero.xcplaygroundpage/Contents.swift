




// 타겟 뷰컨트롤의 HeroID 는 늦어도 wiewWillAppear 에서 설정해야 한다.
// 다음은 HeroTransition 의 확장으로 iOS 에 의해 트랜지션 애니메이션이 시작하는 지점이다.
// context 가 전달하는 to 뷰컨트롤러는 wiewWillAppear 까지 호출된 상태로 전달된다.
extension HeroTransition: UIViewControllerAnimatedTransitioning {
    public func animateTransition(using context: UIViewControllerContextTransitioning) {
        transitionContext = context
        fromViewController = fromViewController ?? context.viewController(forKey: .from)
        toViewController = toViewController ?? context.viewController(forKey: .to)
        transitionContainer = context.containerView
        start()
    }
}



// 셀에서 설정할 때는 셀이 재활용되어 변경될 수 있음으로 셀을 세팅할 때부터 고유값으로 설정하는 것이 좋다.


// 대상뷰 뿐만 아니라 자식뷰까지도 애니메이션 할 수 있나?


// Navigation 으로 전환 시 개별 뷰컨트롤러도 isHeroEnabled 를 세팅할 필요가 있나?
// -> 개별 뷰컨트롤러의 세팅은 필요없고 UINavigationController 에만 세팅하면 된다.
// -> 탭바 애니메이션도 동일하다.
// -> 모달로 띄울 경우에만 타겟 뷰컨트롤러의 isHeroEnabled 세팅만 필요하다.


// 도중에 네비게이션 델리게이트를 수정하면 왜 Hero 가 작동하지 않는가?
// Hero 는 기본적으로 네이게이션 델리게이트를 점유하는 방식으로 작동하는데
// 나중에 다시 isHeroEnabled 를 true 로 세팅하더라도 작동하지 않는 것으로 보인다.
// -> 내부를 들여다 보니 isHeroEnabled 을 세팅할 때 기존의 델리게이트를 따로 저장해 놓고 이벤트가 발생할 때 일부 이벤트에 한해서 저장된 기존 델리게이트에게 전달하고 있다.
// -> 네비게이션 델리게이트는 navigationController(_:willShow:animated:) 와 navigationController(_:didShow:animated:) 이벤트에 대해서 전달하고 있고, 탭바 델리게이트는 따로 전달하는 이벤트가 없었다.
// -> 나중에 다시 isHeroEnabled 를 true 로 세팅해도 작동하지 않았던 이유는 세팅한 직후 바로 네비게이션 델리게이트를 따로 설정해서 Hero 가 처리할 수 없게 만들었기 때문이었다.


// Hero 를 사용하면 네비게이션 컨트롤러가 자동으로 넣어주는 뒤로가기 스와이프 제스처가 비활성화 된다.
// 참조: https://github.com/HeroTransitions/Hero/issues/243



// Hero 는 기본적으로 Interactive 모드로 진행된다. (HeroTransition 내의 주석)
// By default, Hero will always appear to be interactive to UIKit.



// isEnabled 값을 변경하면 기존 네비게이션 및 탭바의 delegate 를 따로 보관했다가 호출해 주는 것을 확인할 수 있다.
var isEnabled: Bool {
  get {
    return base.transitioningDelegate is HeroTransition
  }
  set {
    guard newValue != isEnabled else { return }
    if newValue {
      base.transitioningDelegate = Hero.shared
      if let navi = base as? UINavigationController {
        base.previousNavigationDelegate = navi.delegate
        navi.delegate = Hero.shared
      }
      if let tab = base as? UITabBarController {
        base.previousTabBarDelegate = tab.delegate
        tab.delegate = Hero.shared
      }
    } else {
      base.transitioningDelegate = nil
      if let navi = base as? UINavigationController, navi.delegate is HeroTransition {
        navi.delegate = base.previousNavigationDelegate
      }
      if let tab = base as? UITabBarController, tab.delegate is HeroTransition {
        tab.delegate = base.previousTabBarDelegate
      }
    }
  }
}
