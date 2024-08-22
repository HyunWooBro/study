import Foundation
import UIKit


// ===============================
// 시스템 정의 Notification 예시
// ===============================

UIApplication.userDidTakeScreenshotNotification

UIApplication.willEnterForegroundNotification
UIApplication.didEnterBackgroundNotification

UIApplication.didFinishLaunchingNotification

UIApplication.didBecomeActiveNotification

UIApplication.willResignActiveNotification

UIApplication.didReceiveMemoryWarningNotification

UIApplication.willTerminateNotification

UIApplication.significantTimeChangeNotification

UIApplication.backgroundRefreshStatusDidChangeNotification

UIApplication.protectedDataWillBecomeUnavailableNotification
UIApplication.protectedDataDidBecomeAvailableNotification


UIResponder.keyboardWillShowNotification
UIResponder.keyboardWillHideNotification

UIResponder.keyboardDidShowNotification
UIResponder.keyboardDidHideNotification

UIResponder.keyboardWillChangeFrameNotification
UIResponder.keyboardDidChangeFrameNotification



// ===============================
// addObserver(_,selector:,name:,object:)
// ===============================

// Selecotr 를 사용하는 옵저버 등록 방식
NotificationCenter.default.addObserver(<#T##observer: Any##Any#>, selector: <#T##Selector#>, name: <#T##NSNotification.Name?#>, object: <#T##Any?#>)

// 더이상 옵저버가 필요 없다면 제거한다.
NotificationCenter.default.removeObserver(<#T##observer: Any##Any#>)

// !!!: iOS 9 부터 직접 removeObserver() 을 호출하지 않아도 시스템에서 대신 처리



// ===============================
// addObserver(forName:object:queue:using:) (iOS 4+)
// ===============================

// 클로저를 사용하는 옵저버 등록 방식
NotificationCenter.default.addObserver(forName: <#T##NSNotification.Name?#>, object: <#T##Any?#>, queue: <#T##OperationQueue?#>, using: <#T##(Notification) -> Void#>)

extension Notification.Name {
    static let test = Notification.Name("test")
    static let test2 = Notification.Name("test2")
}

let current = OperationQueue.current

print("AAA")

// queue 가 nil 이면 현재 스레드에서 동기적으로 호출됨
NotificationCenter.default.addObserver(forName: .test, object: nil, queue: nil) { _ in
    if current == OperationQueue.current {
        print("same")
    }
    print("DDD")
}

print("BBB")

NotificationCenter.default.post(name: .test, object: nil)

print("CCC")



print("AAA2")

let queue = OperationQueue()

// queue 가 nil 이 아니면 해당큐의 스레드에서 동기적으로 호출됨
NotificationCenter.default.addObserver(forName: .test2, object: nil, queue: queue) { _ in
    if current == OperationQueue.current {
        print("same2")
    }
    if queue == OperationQueue.current {
        print("same22")
    }
    print("DDD2")
}

print("BBB2")

NotificationCenter.default.post(name: .test2, object: nil)

print("CCC2")


// 더이상 옵저버가 필요 없다면 제거한다.
// !!!: 문서에 따르면 addObserver(_,selector:,name:,object:) 과 달리 직접 제거하도록 요구하고 있지만 시스템에서 자동으로 제거를 지원하는 것으로 보인다. 아마도 순환 참조 이슈의 가능성 때문에 언급된 것으로 보인다.
let token = NotificationCenter.default.addObserver() { notification in
}
NotificationCenter.default.removeObserver(token)

// 클로저 방식은 클로저 자체를 알림과 연동하는 것이기 때문에 반환된 token 을 제거해야 한다. Selector 방식처럼 뷰에 알림을 연동하는 경우에만 self 와 같은 뷰를 제거한다.



// ===============================
// NotificationQueue
// ===============================

extension Notification.Name {
    static let queue = Notification.Name("queue")
}

print("AAA3")

NotificationCenter.default.addObserver(forName: .queue, object: nil, queue: nil) { _ in
    if current == OperationQueue.current {
        print("same3")
    }
    print("DDD3")
}

print("BBB3")

NotificationQueue.default.enqueue(Notification(name: .queue), postingStyle: .whenIdle)

print("CCC3")

NotificationQueue.default.enqueue(Notification(name: .queue), postingStyle: .now, coalesceMask: .none, forModes: nil)

print("CCC33")



// ===============================
// object 테스트
// ===============================

// addObserver 의 object 를 세팅하면, 등록된 객체로 post 할 때만 반응한다.

extension Notification.Name {
    static let object = Notification.Name("object")
}

class Publisher {
    var value: Int?
    func update() {
        NotificationCenter.default.post(
            name: .object,
            object: self,
            userInfo: ["value": value!]
        )
    }
}

class Subscriber {
    var p: Publisher?
    
    func listen() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getUpdate),
            name: .object,
            object: p
        )
    }
    
    @objc func getUpdate(_ notification: Notification) {
        guard let info = notification.userInfo?["value"] as? Int else { return }
        print("got : \(info)")
    }
}

var p1 = Publisher()
p1.value = 1
var p2 = Publisher()
p2.value = 2

var s = Subscriber()
s.p = p1
s.listen()
s.p?.update()
s.p?.update()

p2.update()
p2.update()
