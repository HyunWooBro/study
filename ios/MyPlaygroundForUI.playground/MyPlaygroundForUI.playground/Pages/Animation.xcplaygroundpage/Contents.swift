import UIKit

let view = UIView()


// ===============================
// 개요
// ===============================

// Swift 에서 애니메이션의 내부 원리는 다음 참조
// 참조: https://stackoverflow.com/questions/22556122/internal-implementation-of-uiviews-block-based-animation-methods



// ===============================
// 기존 애니메이션 시스템
// ===============================

UIView.animate(withDuration: 2.0, animations: {
    view.alpha = 1
}, completion: { result in
    
})

// options 을 통해 반복 등의 여러 효과를 줄 수 있음
UIView.animate(
    withDuration: 2.0,
    delay: 3.0,
    options: [
        .curveEaseInOut,
        .repeat,
        .autoreverse,
        .allowUserInteraction
    ],
    animations: {
        view.alpha = 1
    })

// 여러 애니메이션을 결합해야 한다면 animateKeyframes() 활용
UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [.allowUserInteraction]) {
    // withRelativeStartTime 과 relativeDuration 은 0 ~ 1 사이의 값을 withDuration 에 대한 상대적인 수치
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.1 ) {
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1.0
    }
    
    UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.1 ) {
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0.0
    }
}



// ===============================
// 최신 애니메이션 시스템 (iOS 10+)
// ===============================

var animator: UIViewPropertyAnimator? = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut) {
    view.alpha = 1
}


// 애니메이션 상태
// startAnimation(), pauseAnimation() 호출시
UIViewAnimatingState.active
// 생성시, 애니메이션 플레이 종료시
// stopAnimation(true), finishAnimation() 호출시
UIViewAnimatingState.inactive
// stopAnimation(false) 호출시
UIViewAnimatingState.stopped

// 다음의 프로퍼티로 확인 가능
animator?.state


// 애니메이션 결합
// 주의: 기존 애니메이션과 결합해서 동작하는 것이지, 연결하는 개념은 아니다.
// delayFactor 도 0 ~ 1 사이의 값을 설정할 수 있고, 원본 애니메이션의 남은 시간에 대한 비율만큼 기다린 후 원본과 함께 동작한다.
// UIViewAnimatingState.stopped 상태에서 호출시 에러
animator?.addAnimations({
    view.backgroundColor = .red
}, delayFactor: 0.5) // 남은 시간이 2초라면 1초 동안 기다린 후 남은 시간동안 재생


// 애니메이션 종료이벤트 핸들러
// finishAnimation 을 호출해야만 핸들러가 실행된다.
// stopAnimation(true) 로 애니메이션을 강제 종료하면 핸들러가 실행되지 않는다.
animator?.addCompletion { position in
    if position == .start {
        // 애니메이션 시작지점에서 종료이벤트 호출됨
    }
    
    if position == .end {
        // 애니메이션 종료지점에서 종료이벤트 호출됨
    }
    
    if position == .current {
        // 애니메이션 시작과 종료지점 사이에서 종료이벤트 호출됨
    }
}


// 애니메이션 시작 (딜레이 포함 가능)
// UIViewAnimatingState.stopped 상태에서 호출시 에러
animator?.startAnimation(afterDelay: 1.0)


// 애니메이션 멈춤
// UIViewAnimatingState.stopped 상태에서 호출시 에러
animator?.pauseAnimation()


// 애니메이션 진행도
// 기본적으로 0 ~ 1 사이의 값을 가지지만 시작, 종료 지점을 넘어서는 경우까지 표현을 위해 범위를 벗어날 수도 있다.
animator?.fractionComplete

// 애니메이션 실행중 여부
// startAnimation() 호출 후 멈추거나 정지하기 전까지 true
animator?.isRunning

// stopAnimation(), pauseAnimation() 가능 여부
// UIViewAnimatingState.inactive 상태에서만 호출 가능
animator?.isInterruptible

// 애니메이션 플레이가 종료되면 inactive 가 아니라 active 상태로 유지 여부
animator?.pausesOnCompletion

// 애니메이션 revserse 실행 여부
animator?.isReversed


// 정상 종료
// finishAnimation() 를 호출해야 종료이벤트 호출 등의 마무리 작업이 가능
animator?.stopAnimation(false)
animator?.finishAnimation(at: .current)

// 강제 종료
animator?.stopAnimation(true)



// ===============================
// 기타
// ===============================

// 애니메이션 활성화 여부 지정 (이미 실행되는 애니메이션은 영향 받지 않음)
UIView.setAnimationsEnabled(<#T##enabled: Bool##Bool#>)

// 애니메이션 적용을 방지하기 위해서는 performWithoutAnimation() 사용 가능
UIView.performWithoutAnimation {
    // reloadSections() 내부에서는 디폴트 애니메이션이 구현되어 있지만 performWithoutAnimation() 에 포함시키면 애니메이션이 작동하지 않는다.
    UICollectionView().reloadSections(<#T##sections: IndexSet##IndexSet#>)
}
