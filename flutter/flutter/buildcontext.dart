


// 다음과 같은 이유로 BuildContext 를 변수에 저장해서 사용하지 않는 것이 원칙이다.

/// The [BuildContext] for a particular widget can change location over time as
/// the widget is moved around the tree. Because of this, values returned from
/// the methods on this class should not be cached beyond the execution of a
/// single synchronous function.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=rIaaH87z1-g}
///
/// Avoid storing instances of [BuildContext]s because they may become invalid
/// if the widget they are associated with is unmounted from the widget tree.
/// {@template flutter.widgets.BuildContext.asynchronous_gap}
/// If a [BuildContext] is used across an asynchronous gap (i.e. after performing
/// an asynchronous operation), consider checking [mounted] to determine whether
/// the context is still valid before interacting with it: