import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa
import SnapKit

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        
        // ===============================
        // 반응형 프로그래밍
        // ===============================
        
        // RxSwift 는 다른 패키지와는 달리 반응형 프로그래밍이라는 새로운 개발 패러다임을 추가하는 대규모 업데이트라고 볼 수 있다. 본격적으로 사용하기 앞서 여기서 하나하나 테스트가 필요하다.
        
        // Combine 은 SwiftUI 와 어울리기 때문에 이후에 마이그레이션 하기 전까지는 RxSwift 를 사용하자.
        
        // 반응형 프로그래밍은 파이프라인과 같다. 데이터가 생성되는 프로듀서와 데이터를 소비하는 컨슈머가 핵심 요소이고, 이 사이에 다양한 파이프라인을 미들웨어처럼 추가하여 원하는 처리를 할 수 있다. 파이프라인이 작동하기 위해서는 최소한 프로듀서와 컨슈머가 연결되어야 한다.
        
        // 프로듀서와 컨슈머 사이에 존재하는 파이프라인은 원칙적으로 pure 함수인 것이 원칙이다. pure 함수를 사용하면 디버깅 및 테스트가 쉬워진다.
        
        // 스트림 시퀀스에서 출발지는 Source, 목적지는 Sink 라고 한다.
        
        
        
        // ===============================
        // 기본 개념
        // ===============================
        
        // RxSwift : 순수 Reactive Extension
        // RxCocoa : UIKit 관련 확장
        // RxRelay : BehaviorRelay, PublishRelay, ReplayRelay
        // RxTest : 테스트 용도
        // RxBlocking : 테스트 용도
        
        // RxCocoa 에서 바인딩 방법으로는 일반적으로 Target-Action 을 사용하는 것으로 보이고, KVO 도 지원하고 있다. 자주 활용되는 객체의 기능은 Rx 버전으로 래핑되어 있으며, 직접 래핑되지 않더라도 
        
        // (예시도)
        
        
        
        // ===============================
        // Observable : 비동기적 스트림을 다루는 기본 객체
        // ===============================
        
        // next, completed, error 이벤트 시퀀스 생성
        
        // 이벤트는 차례대로 방출되며 동시에 방출되지는 않음 (즉, 하나의 이벤트가 완전히 소비되기 전까지는 다음 이벤트가 방출되지 않음)
        
        // Cold Observable : observer 가 subscribe 할 때 이벤트 방출 (일반 Observable, RxSwift Trait)
        // Hot Observable : observer 와 관계 없이 이벤트 방출 (Subject, RxCocoa Trait)
        
        
        
        // ===============================
        // Observer : Observable 의 시퀀스 이벤트를 받아 처리하는 역할
        // ===============================
        
        // 기본적으로 따로 관리되기 보다는 Observable 을 통해 간접적으로 사용됨 (예를 들어, subscribe 내부에서 암묵적 생성)
        
        // [Observable]
        // - subscribe : 기본 RxSwift 에서 제공
        // - bind : RxCocoa 또는 RxRelay 에서 제공
        
        // [Driver]
        // - drive
        
        // [Signal]
        // - emit
        
        // Binder
        
        
        
        // ===============================
        // Scheduler
        // ===============================
        
        // MainScheduler.instance
        
        // MainScheduler.asyncInstance
        
        // ConcurrentMainScheduler.instance
        
        // CurrentThreadScheduler.instance
        
        // SerialDispatchQueueScheduler(qos: .default)
        
        // ConcurrentDispatchQueueScheduler(qos: .default)
        
        // OperationQueueScheduler(operationQueue: .current)
        
        // subscribe(on:) : 일반적으로 RxSwift 의 파이프라인은 subscribe() 을 통해 Observable 처리를 시작되며, 시퀀스의 처리 시작 스케쥴러 지정 (위치는 중요하지 않음)
        
        // observe(on:) : 다음 메서드 체인이 실행될 스케쥴러 지정
        
        
        
        // ===============================
        // Subject : Observable 과 Observer 의 기능을 동시에 하는 멀티캐스트 객체 (Observable 은 유니캐스트)
        // ===============================
        
        // 다른 변화에 대해 Observer 역할을 하다가 캐치하면 이제부터는 다른 Observer 에 대해 Observable 역할을 할 수 있는 매개체가 될 수 있음
        
        // 다음과 같은 다양한 양상이 가능하다.
        // Subject(Observable & Observer) -> Observer1, Observer2, ...
        // Observable1, Observable2, ... -> Subject(Observable & Observer) -> Observer1, Observer2, ...
        
        // publishSubject : 비어 있는 상태로 시작하여 새로운 이벤트만 subscriber 에게 방출
        // publishRelay : publishSubject 래퍼로 accept() 로 전달하고 error 와 completed 없음 (dispose 전까지 작동하므로 UI 등에 적절)
        
        // BehaviorSubject : 초기 값을 가진 상태로 시작하여 최신 이벤트만 subscriber 에게 방출
        // BehaviorRelay : BehaviorSubject 래퍼로 accept() 로 전달하고 error 와 completed 없음 (dispose 전까지 작동하므로 UI 등에 적절)
        
        // ReplaySubject : 지정된 버퍼 사이즈 만큼의 이벤트를 새로운 subscriber 에게 방출
        // ReplayRelay : ReplaySubject 래퍼로 accept() 로 전달하고 error 와 completed 없음 (dispose 전까지 작동하므로 UI 등에 적절)
        
        // AsyncSubject : completed 이벤트가 발생시 마지막 이벤트만 subscriber 에게 방출
        
        
        
        // ===============================
        // Trait : Observable 의 특수 버전 (Observable 래퍼)
        // ===============================
        
        // [RxSwift Trait]
        // Single : error 또는 하나의 이벤트만 방출
        // Completable : completed 또는 error 이벤트만 방출
        // Maybe : completed, error 또는 하나의 이벤트만 방출
        
        // [RxCocoa Trait]
        // Driver : UI 상태 표현에 적합 (메인스레드, 오류방출X, 이벤트공유, 최신값전달)
        // Signal : UI 이벤트 표현에 적합 (메인스레드, 오류방출X, 이벤트공유)
        // ControlProperty : 컨트롤UI 상태 표현에 적합 (메인스레드, 오류방출X, 이벤트공유, 읽기쓰기, 최신값전달)
        // ControlEvent : 컨트롤UI 이벤트 표현에 적합 (메인스레드, 오류방출X, 이벤트공유, 읽기전용)
        
        
        
        // ===============================
        // Operator : Sequence 또는 Collection 에 대한 고차 함수의 역할
        // ===============================
        
        // 고차 함수와 같은 이름의 연산자라면 작동하는 방식도 유사
        
        // filter : 필터링
        // enumerated
        // reduce
        // map : 맵핑
        // compactMap : nil 제거
        // flatMap : 특히, await/async 과 유사한 방식으로 여러 비동기 API 요청을 처리하는데 유용
        // flatMapLatest
        // scan
        // concat : Observable 리스트를 처리하되 앞선 Observable 이 완료되어야 그 다음 Observable 처리
        // combineLatest : 각 스트림에서 가장 최근 것만 결합
        // merge
        // zip
        // distinctUntilChanged
        // withUnretained
        // delaySubscription
        // debounce
        // delay
        // timeout
        // take
        // skip
        
        // [공유 연산자]
        
        // 저수준
        // multicast -> subject -> connect
        
        // 중수준
        // publish -> connect
        // replay -> connect
        // refCount
        
        // 고수준
        // share
        
        
        
        // ===============================
        // Side Effect : 시퀀스 외부 환경에 영향을 끼치는 것
        // ===============================
        
        // 원칙적으로 do 와 subscribe 에서만 허용해야 함
        // do : 스트림 처리 중간 어디든 위치해서 다양한 처리를 할 수 있으며 전달받은 이벤트를 수정하지 않고 다음 연산자로 전달함 (반환값은 Observable)
        // subscribe : 스트림 파이프라인을 거쳐서 최종적으로 나온 결과를 받으며 Cold Observable 의 경우 subscribe 을 하기 전에는 이벤트 방출하지 않음 (반환값은 Disposable)
        
        
        
        // ===============================
        // Disposable : 리소스 해제 관련
        // ===============================
        
        // DisposeBag : 여러 리소스를 동시에 해제할 수 있음
        
        // RxSwift 공식문서에서는 DisposeBag 또는 take() 계열의 연산자를 사용해서 확실한 리소스 정리를 권장하고 있다.
        
        // 셀이 직접 리소스를 관리하는 경우, 기본적으로 셀은 큐를 통해 재활용되기 때문에 리소스가 해제되지 않는 경우가 발생할 수 있다. 셀이 반환되어 큐에 들어갈 때 리소스를 정리하는 방식이 유효할 수 있다.
        
        // 네트워크 응답을 기다리는 상황에서 dispose() 가 되면 응답이 오더라도 무시하고 처리를 하지 않는다. 일반적으로 DisposeBag 에 의해 정리되는 상황에서는 주위 환경도 함께 정리될 가능성이 높으므로 외부 변수에 접근하지 않는 것이 안전할 수 있다. 하지만 상황에 따라 응답받은 데이터를 이용하기 원할 수 있으므로 DisposeBag 을 상황에 따라 사용하는 것이 좋을 것 같다.
        
        // 설정된 DisposeBag 가 무효화되어 리소스가 정리되면 진행중인 시퀀스가 중간에 취소될 수 있다. 다음은 네트워크 상황에 따라 완료될 수도 아니면 중간에 DisposeBag 의 무효화로 인해 취소될 수도 있는 예제이다.
        var bag = DisposeBag()
        
        Observable.just(URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!)))
            .flatMap({ _ in
                URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!))
            })
            .flatMap({ _ in
                URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!))
            })
            .flatMap({ _ in
                URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!))
            })
            .flatMap({ _ in
                URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!))
            })
            .flatMap({ _ in
                URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://abc.com")!))
            })
            .subscribe(onNext: { _ in
                print("came here")
            })
            .disposed(by: bag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            bag = DisposeBag()
        }
        
        
        // 다음처럼 DisposeBag 을 대체하는 방법도 존재
        // DisposeBag 방식은 세밀한 컨트롤이 가능하지만 take(until: rx.deallocated) 방식은 메모리에서 해제될 때 호출되는 것으로 보인다.
        Observable.just(1)
            .take(until: rx.deallocated)
            .subscribe()
        
        
        
        // ===============================
        // 커스텀 extension
        // ===============================
        
        //
        
        
        
        // ===============================
        // 디버깅
        // ===============================
        
        // debug() 를 추가하면 다음과 같이 진행되는 프로세스에 대해 로그가 출력된다.
        Observable.just(1)
            .debug("[debug!]")
            .do(onNext: { print($0 * 100) })
            .subscribe()
            .dispose()
        // [debug!] -> subscribed
        // [debug!] -> Event next(1)
        // 100
        // [debug!] -> Event completed
        // [debug!] -> isDisposed
        
        
        // TRACE_RESOURCES 플래그를 추가하면 RxSwift 리소스 사용량을 추적할 수 있다.
        // SPM 을 통해서는 패키지의 define 설정을 적용하기 까다롭고 Cocoapods 통해 테스트가 가능한 것 같다.
        
        
        
        // ===============================
        // 예시 및 테스트
        // ===============================
        
        // create 테스트
        Observable.create { observer in
            observer.on(.next("first"))
            observer.on(.next("second"))
            observer.on(.completed)
            return Disposables.create()
        }
        .debug("[debug%]")
        .subscribe(onNext: {
            print($0)
        })
        .dispose()
        // [debug%] -> subscribed
        // [debug%] -> Event next(first)
        // [debug%] -> Event next(second)
        // [debug%] -> Event completed
        // [debug%] -> isDisposed
        
        
        // from 테스트
        Observable.from([2,3,4,5])
            .debug("[debug_]")
            .map { $0 * 3 }
            .subscribe(onNext: { value in
                print(value)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("onCompleted")
            }, onDisposed: {
                
            })
        // [debug_] -> subscribed
        // [debug_] -> Event next(2)
        // 6
        // [debug_] -> Event next(3)
        // 9
        // [debug_] -> Event next(4)
        // 12
        // [debug_] -> Event next(5)
        // 15
        // [debug_] -> Event completed
        // onCompleted
        // [debug_] -> isDisposed
        
        
        // empty 테스트
        Observable<Int>.empty()
            .debug("debug[%]")
            .subscribe({ event in
                print(event)
            })
        // debug[%] -> subscribed
        // debug[%] -> Event completed
        // completed
        // debug[%] -> isDisposed
        
        
        // do 테스트
        Observable.of(1, 2)
            .debug("[debug@]")
            .do(onNext: {
                print($0 * 10)
            }, afterNext: {
                print($0 * 100)
            }, onError: {
                print("error \($0)")
            }, afterError: {
                print("afterError \($0)")
            }, onCompleted: {
                print("onCompleted")
            }, afterCompleted: {
                print("afterCompleted")
            }, onSubscribe: {
                print("onSubscribe")
            }, onSubscribed: {
                print("onSubscribed")
            }, onDispose: {
                print("onDispose")
            })
            .subscribe()
            .dispose()
        // onSubscribe
        // [debug@] -> subscribed
        // onSubscribed
        // [debug@] -> Event next(1)
        // 10
        // 100
        // [debug@] -> Event next(2)
        // 20
        // 200
        // [debug@] -> Event completed
        // onCompleted
        // afterCompleted
        // [debug@] -> isDisposed
        // onDispose
        
        
        enum CustomError: Error {
            case error1
        }
        
        // 중첩 do 테스트
        Observable.create { observer in
            observer.on(.next(1))
            observer.on(.next(2))
            observer.on(.error(CustomError.error1))
            observer.on(.completed)
            return Disposables.create()
        }
        .debug("[debug@@]")
        .do(onError: {
            print("error #1 \($0)")
        })
        .map { $0 * 10 }
        .do(onNext: {
            print("next #1 \($0)")
        }, onError: {
            print("error #2 \($0)")
        })
        .subscribe(onNext: {
            print("next #2 \($0)")
        }, onError: {
            print("error #3 \($0)")
        })
        .dispose()
        // [debug@@] -> subscribed
        // [debug@@] -> Event next(1)
        // next #1 10
        // next #2 10
        // [debug@@] -> Event next(2)
        // next #1 20
        // next #2 20
        // [debug@@] -> Event error(error1)
        // error #1 error1
        // error #2 error1
        // error #3 error1
        // [debug@@] -> isDisposed
        
        
        // subscribe(widh:) 테스트
        Observable.of(nil, "abc")
            .subscribe(with: self, onNext: {(owner, value) in
                print(owner.viewIfLoaded)
            })
        
        
        // filter & map 테스트
        Observable.of(2, 3, 4)
            .debug("[debug#]")
            .filter { $0 % 2 != 0 }
            .map { $0 * 100 }
            .subscribe(onNext: {
                print($0)
            })
        // [debug#] -> subscribed
        // [debug#] -> Event next(2)
        // [debug#] -> Event next(3)
        // 300
        // [debug#] -> Event next(4)
        // [debug#] -> Event completed
        // [debug#] -> isDisposed
        
        
        // compactMap 테스트
        Observable.of(nil, "abc")
            .debug("[debug$]")
            .compactMap { $0 }
            .subscribe(onNext: {
                print($0)
            })
            .dispose()
        // [debug$] -> subscribed
        // [debug$] -> Event next(nil)
        // [debug$] -> Event next(Optional("abc"))
        // abc
        // [debug$] -> Event completed
        // [debug$] -> isDisposed
        
        
        // flatMap 테스트
        RestAPIService.callAPI1()
            .do(onNext: {
                // 처리
            })
            .map { 
                // 변환
            }
            .flatMap(RestAPIService.callAPI2)
            .do(onNext: {
                // 처리
            })
            .map {
                // 변환
            }
            .flatMap(RestAPIService.callAPI3)
            .do(onNext: {
                // 처리
            }
            .subscribe()
        
        
        // bind 테스트
        // bind 는 내부적으로 subscribe 를 활용
        // bind 를 따로 제공하는 이유는 바인딩이라는 의도를 들어내기 위함이다.
        
        // 1. UI 바인딩
        UIButton().then {
            self.view.addSubview($0)
            $0.configuration = UIButton.Configuration.gray()
            $0.configuration?.title = "efef"
            $0.updateConfiguration()
            $0.frame = .init(x: 0, y: 0, width: 100, height: 100)
        }
        .rx.tap
        .bind {
            print("abc")
        }
        
        // 2. 다른 파이프라인으로 바인딩
        // 중재자
        let publish = PublishSubject<Int>()
        
        // 소비자
        publish.subscribe(onNext: {
            print("consumer1 : \($0 * 2)")
        })
        publish.subscribe(onNext: {
            print("consumer2 : \($0 + 10)")
        })
        
        // 생산자
        Observable.of(1, 2, 3)
            .debug("[debug^]")
            .bind(to: publish)
            .dispose()
        // [debug^] -> subscribed
        // [debug^] -> Event next(1)
        // consumer1 : 2
        // consumer2 : 11
        // [debug^] -> Event next(2)
        // consumer1 : 4
        // consumer2 : 12
        // [debug^] -> Event next(3)
        // consumer1 : 6
        // consumer2 : 13
        // [debug^] -> Event completed
        // [debug^] -> isDisposed
        
        
        // concat 테스트
        // 에러가 발생하기 전까지 차례대로 처리
        let url = URL(string: "https://www.youtube.com/")!
        let request = URLRequest(url: url)
        
        let url2 = URL(string: "https://www.addressNotAvailable.com/")!
        let request2 = URLRequest(url: url2)
        
        let url3 = URL(string: "https://www.netflix.com/")!
        let request3 = URLRequest(url: url3)

        Observable<Int>.concat([
            URLSession.shared.rx.data(request: request)
                .map { $0.count },
            URLSession.shared.rx.data(request: request2)
                .map { $0.count },
            URLSession.shared.rx.data(request: request3)
                .map { $0.count },
        ])
        .debug("[debug+]")
        .subscribe(onNext: {
            print($0)
        })
        // [debug+] -> subscribed
        // [debug+] -> Event next(298469)
        // 298469
        // [debug+] -> Event error(Error Domain=NSURLErrorDomain Code=-1003 "특정 호스트 이름을 가진 서버를 찾을 수 없습니다." UserInfo={_kCFStreamErrorCodeKey=8, NSUnderlyingError=0x6000004ada40 {Error Domain=kCFErrorDomainCFNetwork Code=-1003 "(null)" UserInfo={_NSURLErrorNWPathKey=satisfied (Path is satisfied), interface: en0[802.11], _kCFStreamErrorCodeKey=8, _kCFStreamErrorDomainKey=12}}, _NSURLErrorFailingURLSessionTaskErrorKey=LocalDataTask <A9531F88-E7CD-4F07-B72D-38DDCB5C378B>.<18>, _NSURLErrorRelatedURLSessionTaskErrorKey=(
        // [debug+] -> isDisposed

        
        // combineLatest 테스트
        // 각 스트림에서 가장 최신의 결과를 resultSelector 를 통해 맵핑하여 전달
        Observable.combineLatest(
            URLSession.shared.rx.data(request: request).map { $0.count },
            URLSession.shared.rx.data(request: request3).map { $0.count },
            resultSelector: { $0 + $1 }
        )	
        .debug("[debug~]")
        .subscribe(onNext: {
            print($0)
        })
        // [debug~] -> subscribed
        // [debug~] -> Event next(735284)
        // [debug~] -> Event completed
        // [debug~] -> isDisposed
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
