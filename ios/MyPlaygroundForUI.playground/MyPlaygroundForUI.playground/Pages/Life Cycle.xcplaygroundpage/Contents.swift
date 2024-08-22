import UIKit
import PlaygroundSupport


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // ===============================
    // 기본적으로 포함되어 있는 메서드
    // ===============================
    
    // 앱이 시작하기 위한 준비가 거의 마무리 될 때 호출됨
    // launchOptions 을 통해 리모트 푸시 등의 앱이 실행된 이유를 알 수 있음 (유저가 직접 실행한 경우에는 nil)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // Scene 세션 생성시 호출됨
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // 메모리에서 Scene 세션 제거시 호출됨
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    // ===============================
    // 선택적으로 포함할 수 있는 메서드
    // ===============================
    
    // 앱의 초기화를 마무리하기 시작할 때 호출됨
    // not-running 상태 -> inactive 상태
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    // 앱이 종료되기 전에 호출됨
    func applicationWillTerminate(_ application: UIApplication) {
    
    }

    // 원격알림 등록하는 registerForRemoteNotifications() 성공하면 호출됨
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    // 원격알림 등록하는 registerForRemoteNotifications() 실퍃면 호출됨
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    // UNUserNotificationCenterDelegate 의 willPresent 및 didReceive 도입된 이후로 willPresent 및 didReceive 를 대신 사용하도록 권장하고 있음. didReceive 가 정의되어 있지 않으면 아래 메서드가 호출됨. 단, 사일런트 푸시의 경우에는 여전히 아래 메서드가 호출된다고 함
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    // 딥링크
    // scene(_:openURLContexts:) 이 등장하기 전에 사용됨
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
}


// 멀티 Scene 이 가능한 iPad 에서 의미가 있음
// UIApplication.shared.supportsMultipleScenes 에서 확인할 수 있듯이 iPhone 에서는 2개 이상의 Scene 을 가질 수 없음
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // ===============================
    // 기본적으로 포함되어 있는 메서드
    // ===============================

    // Scene 초기화 (윈도우 연결)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // Scene 마무리 (윈도우 분리)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    // inactive 상태 -> active 상태 전환 후
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    // active 상태 -> inactive 상태 전환 전
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    // background 상태 -> foreground 상태 전환 전
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // foreground 상태 -> background 상태 전환 후
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
    // ===============================
    // 선택적으로 포함할 수 있는 메서드
    // ===============================
    
    // 딥링크
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
    }

}

// UNUserNotificationCenterDelegate

//func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//}
//
//func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//}




// 네비게이션 및 탭바의 델리게이트와 연계해서 순서를 알아보자

//func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//
//}
//
//func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//
//}



// 콜렉션뷰의 델리게이트

//@available(iOS 8.0, *)
//optional func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//
//@available(iOS 8.0, *)
//optional func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath)
//
//@available(iOS 6.0, *)
//optional func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
//
//@available(iOS 6.0, *)
//optional func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath)


class MainView: UIView {
    // 뷰컨트롤러와는 달리 IBOutlet 에 접근이 가능하다.
    // 코드가 아닌 NIB 을 통해 생성할 경우에만 호출된다.
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function + " Main")
    }
    
    // 뷰컨트롤러가 직접적으로 관리하는 뷰의 layoutSubviews() 만 viewWillLayoutSubviews() 와 viewDidLayoutSubviews() 사이에서 호출되며, 다른 자식뷰들은 viewDidLayoutSubviews() 이후에 호출되는 것으로 보인다.
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function + " Main")
    }
    
    override func updateConstraints() {
        // 코드는 super 호출 전에 작성해야 한다.
        super.updateConstraints()
        print(#function + " Main")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(#function + " Main")
    }
    
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        print(#function + " Main")
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        print(#function + " Main")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        print(#function + " Main")
    }
}

class SuperView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function + " SuperView")
    }
}

class SubView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        print(#function + " SubView")
    }
}

class MyCollectionViewCell: UICollectionViewCell {
    // 셀에서 prepareForReuse() 와의 차이는 셀을 인스턴스화 하면서 초기에 awakeFromNib() 가 한번만 호출되는 반면에 셀을 재활용할 때마다 prepareForReuse() 가 호출되어 초기화 한다는 것이다.
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }
    
    // 셀 재활용시 초기화 (큐에서 반출하기 전)
    // 신규 셀이 생성되면서 awakeFromNib() 호출된 후에는 큐에 삽입되고 나오는 것이 아니라 곧바로 사용되며 prepareForReuse() 호출되지 않는다. 셀이 사용된 후 큐에 반환되고 다시 사용되는 경우에만 prepareForReuse() 호출된다.
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
    }
}


class MyViewController : UIViewController {
    // 스토리보드 또는 NIB 를 통해 생성하는 경우 호출되지 않는다.
    // 커스텀 뷰를 뷰컨트롤러의 메인 뷰로 설정할 수 있다.
    override func loadView() {
//        super.loadView()
        view = MainView()
        print(#function)
    }
    
    // IBOutlet 이 초기화되지 않았기 때문에 사용하면 안된다.
    // viewDidLoad() 부터 IBOutlet 에 접근이 가능하다.
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }
    
    // viewDidLoad 에서 핵심이 되는 것은 뷰컨트롤러의 기본 뷰 및 하위 뷰들도 메모리에 올라왔으며 IBOutlet 등도 사용이 가능하지만, 레이아웃 관련 프레임 사이즈는 아직 결정되지 않았다는 것이다. frame 은 물론, SafeArea 와 관련된 레이아웃 가이드 등도 모두 유효하지 않다.
    // 출처: https://stackoverflow.com/questions/46290356/safeareainsets-return-wrong-values-in-viewdidload-wheres-the-best-place-to-get
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        let view = SuperView()
        view.frame = .init(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = .black
        self.view.addSubview(view)
        
        let subview = SubView()
        view.addSubview(subview)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print(".now() + 3")
            view.frame = .init(x: 0, y: 0, width: 200, height: 200)
            self.view.layoutIfNeeded()
            print("Just after layoutIfNeeded()")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print(".now() + 5")
//            view.setNeedsLayout()
//            print("after setNeedsLayout()")
            view.setNeedsLayout()
            subview.setNeedsLayout()
//            print("after setNeedsLayout()")
//            print("before layoutIfNeeded()")
//            view.layoutIfNeeded()
            print("Just after layoutIfNeeded()")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem
        
        view.frame
        
        print(#function)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }
    
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        print(#function)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        print(#function)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print(#function)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        print(#function)
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
