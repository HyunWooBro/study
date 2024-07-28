



// builder 에서
// builder 와 child 구분하는 이유

// AnimatedBuilder 에서 참조한 내용
/// ## Performance optimizations
///
/// {@template flutter.widgets.transitions.AnimatedBuilder.optimizations}
/// If the [builder] function contains a subtree that does not depend on the
/// animation passed to the constructor, it's more efficient to build that
/// subtree once instead of rebuilding it on every animation tick.
///
/// If a pre-built subtree is passed as the [child] parameter, the
/// [AnimatedBuilder] will pass it back to the [builder] function so that it can
/// be incorporated into the build.
///
/// Using this pre-built child is entirely optional, but can improve
/// performance significantly in some cases and is therefore a good practice.