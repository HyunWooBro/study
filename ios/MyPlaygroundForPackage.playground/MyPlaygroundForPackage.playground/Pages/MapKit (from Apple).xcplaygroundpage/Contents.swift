import MapKit



// ===============================
// MKMapView
// ===============================

// 한국은 지도 반출 금지 이슈로 정확도가 떨어진다. 이점은 구글도 마찬가지다.

// 하지만 카카오, 네이버, 구글, 애플 중에서 유일하게 무료라는 특징이 있다.

// 커스텀뷰 델리게이트를 반환하면 기본 핀이 생성되지 않음


let mapView = MKMapView()

mapView.mapType = .standard
mapView.mapType = .satellite
mapView.mapType = .satelliteFlyover
mapView.mapType = .mutedStandard
mapView.mapType = .hybrid
mapView.mapType = .hybridFlyover

mapView.annotations
mapView.annotations(in: <#T##MKMapRect#>)

mapView.addAnnotation(<#T##MKAnnotation#>)
mapView.addAnnotations(<#T##[MKAnnotation]#>)
mapView.removeAnnotation(<#T##MKAnnotation#>)
mapView.removeAnnotations(<#T##[MKAnnotation]#>)

mapView.selectAnnotation(<#T##MKAnnotation#>, animated: <#T##Bool#>)
mapView.deselectAnnotation(<#T##MKAnnotation?#>, animated: <#T##Bool#>)
mapView.selectedAnnotations

mapView.showAnnotations(<#T##[MKAnnotation]#>, animated: <#T##Bool#>)

mapView.register(<#T##AnyClass?#>, forAnnotationViewWithReuseIdentifier: <#T##String#>)
mapView.dequeueReusableAnnotationView(withIdentifier: <#T##String#>)
mapView.dequeueReusableAnnotationView(withIdentifier: <#T##String#>, for: <#T##MKAnnotation#>)
mapView.view(for: <#T##MKAnnotation#>)

mapView.userLocation
mapView.showsUserLocation
mapView.isUserLocationVisible

mapView.showsCompass
mapView.showsScale

mapView.userTrackingMode
mapView.showsUserTrackingButton
mapView.setUserTrackingMode(<#T##MKUserTrackingMode#>, animated: <#T##Bool#>)

mapView.showsPitchControl
mapView.showsZoomControls

// isZoomEnabled 이 활성화 되면 Annotation 과 상호작용하는 didSelect 또는 didDeselect 의 반응이 매우 느려진다.
mapView.isZoomEnabled
mapView.isRotateEnabled
mapView.isPitchEnabled

mapView.centerCoordinate
mapView.setCenter(<#T##CLLocationCoordinate2D#>, animated: <#T##Bool#>)

mapView.region
mapView.setRegion(<#T##MKCoordinateRegion#>, animated: <#T##Bool#>)

mapView.visibleMapRect
mapView.setVisibleMapRect(<#T##MKMapRect#>, animated: <#T##Bool#>)
mapView.setVisibleMapRect(<#T##MKMapRect#>, edgePadding: <#T##UIEdgeInsets#>, animated: <#T##Bool#>)

mapView.cameraBoundary
mapView.setCameraBoundary(<#T##MKMapView.CameraBoundary?#>, animated: <#T##Bool#>)

mapView.cameraZoomRange
mapView.setCameraZoomRange(<#T##MKMapView.CameraZoomRange?#>, animated: <#T##Bool#>)

mapView.setCamera(<#T##MKMapCamera#>, animated: <#T##Bool#>)



// ===============================
// MKMapViewDelegate
// ===============================

// 맵 초기화시 프로세스
// 1. viewDidLoad
// 2. viewWillAppear
// 3. mapViewDidChangeVisibleRegion
// 4. regionDidChangeAnimated
// 5. viewDidAppear
// 6. mapViewDidFinishLoadingMap
// 7. mapViewDidFinishRenderingMap

// 맵 이동시 프로세스 (항상 그렇지는 않음)
// 1. regionWillChangeAnimated
// 2. mapViewWillStartRenderingMap
// 3. mapViewWillStartLoadingMap
// 4. mapViewDidFinishLoadingMap
// 5. mapViewDidFinishRenderingMap
// 6. regionDidChangeAnimated

class MyMapViewDelegate: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        <#code#>
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        <#code#>
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        <#code#>
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        <#code#>
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        <#code#>
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        <#code#>
    }
    
    // 지도 위에 어노테이션을 렌더링 하기 전에 커스터마이징할 것인지 결정할 수 있다. nil 을 리턴하면 시스템 디폴트 디자인을, 커스텀 뷰를 리턴하면 된다. 커스텀 뷰를 사용시 매번 새로 생성하지 않고 dequeueReusableAnnotationView() 메서드를 사용해야 한다. 어노테이션뷰에는 유저의 위치를 표현하는 MKUserLocationView 도 포함되는 것을 주의하라.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        <#code#>
    }
    
    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        <#code#>
    }
}



// ===============================
// MKAnnotation
// ===============================

let annotation = MKAnnotation()



// ===============================
// MKClusterAnnotation
// ===============================

let cluster = MKClusterAnnotation()
cluster.memberAnnotations

// !!!: 클러스터링 식별자를 계속 세팅하지 않으면 클러스터링이 작동하지 않을 때가 있다.
// 출처: https://developer.apple.com/forums/thread/93399



// ===============================
// MKAnnotationView
// ===============================

let view = MKAnnotationView()
// 기본적으로 MKAnnotationView 의 frame 중심에 위치에 출력되기 때문에 centerOffset 를 활용하여 적절히 표현
view.centerOffset
view.clusteringIdentifier
view.cluster


// MyAnnotationView 라이프 사이클
class MyAnnotationView: MKAnnotationView {
    
    // dequeueReusableAnnotationView() 를 통해 큐에 있는 내용이 반환되든 새로 생성되든 호출된다.
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // mapView(_:viewFor) 메서드가 반환된 후 렌더링하기 전에 호출된다.
    override func prepareForDisplay() {
        super.prepareForDisplay()
    }
}

// !!!: 커스텀 어노테이션뷰에서는 AutoLayout 을 사용해서는 안된다. 사용하는 경우 간혹 맵의 좌측 상단에 잠시 나타났다 사라지는 현상이 발생하기 때문이다.
// 출처: https://stackoverflow.com/questions/39273459/ios-mkmapview-custom-images-display-on-top-left-corner



// ===============================
// 기타
// ===============================

// Deprecated
MKPinAnnotationView

MKMarkerAnnotationView

MKPointAnnotation

MKUserLocationView(annotation: <#T##MKAnnotation?#>, reuseIdentifier: <#T##String?#>)


MKScaleView
MKCompassButton(mapView: <#T##MKMapView?#>)
MKUserTrackingBarButtonItem(mapView: <#T##MKMapView?#>)


MKLocalSearch


MKPlacemark


MKShape

MKOverlay

MKCircle(mapRect: <#T##MKMapRect#>)
