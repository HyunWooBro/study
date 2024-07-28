


// parameter list
// positional
// named


// this-parameters vs. super-parameters


// Initializer List
// 파라미터 리스트에서는 상수 값만 가능하기 때문에 상수가 아닌 경우라면 Initializer List 사용
// Initializer List 에서 this 사용 불가


// body
// 상위 클래스의 필드를 여기서는 초기화 불가 (super 을 활용한 파라미터 또는 super 을 이용한 생성자 호출만 가능)



// 초기화 순서
// 파라미터 리스트 + Initializer List -> body




// const constructor
// 모든 필드가 final
// body 를 가질 수 없음


// named constructor vs. unnamed constructor


// factory constructor


// constructor inheritance




class A {
  const A({this.name});

  final String? name;
}

class B extends A {
  B({super.name}) : age = 2 {
    this.age += 2;
  }

  int age;
}

class C extends A {
  C() : age = 2,
        super(name: 'efe');

  int age;
}