


// Arrow Function 다음에는 Expression 이 와야한다.

class Test {
  int prop = 1;
  // Dart 에서 대입문도 Expression 이다.
  void method() => prop = 2;
}

// 예시
int a = 2;
int b = a = 4;