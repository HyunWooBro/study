


//////////////////////////////////////////////////////////
// 개요
//////////////////////////////////////////////////////////

// function-based       class-based                 class-based (Legacy)
// 상태 변경 없음         상태 변경 있음                 상태 변경 있음
// Provider             NotifierProvider            StateProvider
// FutureProvider       AsyncNotiferProvider        StateNotifierProvider
// StreamProvider       StreamNotifierProvider


// 최종 상태 값에 접근 가능
// ref.read(provider)

// 클래스 기반의 Notifier 확장시 Notifier 클래스 접근 가능
// provider.notifier
// ref.read(provider.notifier)

// Future 기반의 Provider 사용시 Future 반환값에 접근 가능
// provider.future


// Thought process boils down to answering the following questions:
//
// Are some side effects required?
// y: Use riverpod's class-based API
// n: Use riverpod's function-based API
//
// Does state need to be loaded asynchronously?
// y: Let build return a Future<T>
// n: Let build simply return T
//
// Are some parameters required?
// y: Let build (or your function) accept them
// n: Let build (or your function) accept no extra parameters



//////////////////////////////////////////////////////////
// ProviderContainer
//////////////////////////////////////////////////////////

// ProviderContainer 은 runApp 시작 전에 사용해야 유효한 것으로 보인다.
// 예를 들어, onResume 시에 ProviderContainer 을 사용해서 UI 변경시 적용되지 않음

// 커스텀 ProviderContainer 은 ProviderScope 시작 후에 공유하는가?



//////////////////////////////////////////////////////////
// ref.watch
// ref.read
// ref.listen
// ref.listenManual
// ref.invalidate
// ref.refresh
//////////////////////////////////////////////////////////

// ref.watch 는 내부적으로 listen 을 활용하여 markNeedsBuild() 를 호출한다.

// ref.read 는 일회성인 경우에 활용한다. 현재 상태 확인 또는 notifier 객체의 메서드 호출 등.


// [주의]
// ref.watch 및 ref.read 이 반환하는 AsyncValue 는 콜백이 아니다. 상태 변경시 재빌드를 유도하여
// build 시에 provider 의 상태에 따라 분기를 나누기 위한 용도이다.
// 따라서, 기본적으로 markNeedsBuild() 를 활용하지 않는 ref.read 를 사용하여 네트워크 요청시
// AsyncValue 의 3가지 분기 중 최초 상태인 loading 만 처리되고, 네트워크 결과가 도착하더라도
// build 되지 않아 다른 분기를 타지 않을 수 있다.



//////////////////////////////////////////////////////////
// AutoDispose
//////////////////////////////////////////////////////////

// 기본적으로 @riverpod 를 활용하면 AutoDispose provider 가 생성되어 리스너가 없으면 자동 제거된다.

// @Riverpod(keepalive = true) 또는 ref.keepAlive() 를 활용하여 자동 제거를 방지할 수 있다.
// 전자의 방법과는 달리 후자의 방법은 위치에 따라 다양한 활용이 가능하다.
// 일반적으로 await http 리퀘스트 다음에 배치하여 성공적으로 반환값을 받으면 자동 제거를 방지하는 방식을 활용한다.

// [주의]
// ref.read 를 통해 네트워크 요청을 하는 경우 await http 를 실행하여 반환되는 순간 바로 dispose 되기 때문에,
// await http 요청을 하기 전에 ref.keepAlive() 를 호출해야 자동 제거되지 않는다. 다만, 이렇게 하는 경우
// 반환 상태에 따른 ref.keepAlive() 활용이 무의미 해지기 때문에 이런 식으로 사용할 필요가 없다.



//////////////////////////////////////////////////////////
// 코드 생성
//////////////////////////////////////////////////////////

// riverpod 는 기본적으로 코드 생성을 권장한다.

// [Provider]
// @riverpod
// String example(ExampleRef ref) {
//   return 'foo';
// }

// [FutureProvider]
// @riverpod
// Future<String> example(ExampleRef ref) async {
//   return Future.value('foo');
// }

// [StreamProvider]
// @riverpod
// Stream<String> example(ExampleRef ref) async* {
//   yield 'foo';
// }

// [NotifierProvider]
// @riverpod
// class Example extends _$Example {
//   @override
//   String build() {
//     return 'foo';
//   }
//
// // Add methods to mutate the state
// }

// [AsyncNotifierProvider]
// @riverpod
// class Example extends _$Example {
//   @override
//   Future<String> build() async {
//     return Future.value('foo');
//   }
//
//   // Add methods to mutate the state
// }

// [StreamNotifierProvider]
// @riverpod
// class Example extends _$Example {
//   @override
//   Stream<String> build() async* {
//     yield 'foo';
//   }
//
//   // Add methods to mutate the state
// }