

// 시뮬레이터는 GPS, 카메라 등의 제약만 있을 뿐 실제 기기와 거의 유사한 환경이라고 볼 수 있기 때문에 실기기 대용 테스트 용도로 충분해 보인다.

// !!!: 주의해야 할 점은 단순히 주변기기의 유무만이 아니라 이런 부분이 코드에도 간접적으로 영향을 끼칠 수 있다는 점이다. 예를 들어 MapKit 에서 mapView(_:viewFor) 메서드는 어노테이션뷰를 지도 위에 렌더링하기 전에 호출되는데 GPS 가 없는 시뮬레이터에서는 MKUserLocationView 에 대한 처리를 하지 않지만 실기기에서는 적절한 처리가 필요하다. 결국 시뮬레이터에서 상당한 부분을 커버할 수는 있지만 최종적으로 실기기에서의 테스트가 필수이다.


// [유용한 단축키]
// 소프트웨어 키보드 토글 : ⌘K
