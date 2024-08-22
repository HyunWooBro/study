

// ===============================
// 카메라
// ===============================
// Request
AVCaptureDevice.requestAccess(for: AVMediaType, completionHandler: <#T##(Bool) -> Void#>)
// Auth
switch AVCaptureDevice.authorizationStatus(for: .video) {
case notDetermined:
    <#code#>
case restricted:
    <#code#>
case denied:
    <#code#>
case authorized:
    <#code#>
}


// ===============================
// 알림
// ===============================
// Request
UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
    
    if let error = error {
        print("Notification Request Failure : " + error.localizedDescription)
    }
    
    if granted {
        DispatchQueue.main.async {
            // 원격 푸시 등록
            application.registerForRemoteNotifications()
        }
    }
}


// ===============================
// GPS
// ===============================
// Request
let locationManager = CLLocationManager()
locationManager.requestWhenInUseAuthorization()
locationManager.requestAlwaysAuthorization()
// Auth
switch locationManager.authorizationStatus {
case .notDetermined:
    <#code#>
case .restricted:
    <#code#>
case .denied:
    <#code#>
case .authorizedAlways:
    <#code#>
case .authorizedAlways:
    <#code#>
case .authorizedWhenInUse:
    <#code#>
case .authorized:
    <#code#>
}


// ===============================
// PhotoKit
// ===============================
// PhotoKit 을 사용할 때 항상 권한이 요구되는건 아님
// Request
PHPhotoLibrary.requestAuthorization(<#(PHAuthorizationStatus) -> Void#>)
// Auth
switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
case .notDetermined:
    <#code#>
case .restricted:
    <#code#>
case .denied:
    <#code#>
case .authorized:
    <#code#>
case .limited:
    <#code#>
}
