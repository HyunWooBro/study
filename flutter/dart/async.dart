import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// async / await 는 연쇄적으로 반드시 호출해야 하는 것이 아니다.
// 필요한 경우에만 사용할 수 있다.

func() {
  // func() 에서 func2() 의 결과를 기다리고 싶으면 await 를 하는 것이고,
  // 기다릴 생각이 없다면 await 를 사용하지 않으면 된다.
  var a = 1 + 2;
  func2();
  var b = 1 + 2;
}

// func() 의 await 과는 상관없이 func2() 의 첫 await 에서 일단 리턴한 후,
// 코드의 나머지 영역은 이벤트루프에서 주도하여 처리
func2() async {
  debugPrint('before');
  await Future.delayed(Duration(seconds: 1)); // 일단 리턴 후 이벤트루프에서 처리
  debugPrint('between');
  await func3(); // func3() 에서 실제로 await 를 활용하지 않기 때문에 현재 await 에서도 대기할 Future 가 없어서 계속 진행
  debugPrint('after');
}

Future<void> func3() async {
  Future.delayed(Duration(seconds: 1));
}



// 1. main 함수에 대한 async
// 시스템 내부적으로 async 이면 await 해주는 것으로 보임
// -> 아닌 것 같음 (일반 함수와 다를 바 없음)
main() async {

}

// main() {
//
// }


// 2. onTap, onPressed 등의 터치콜백에 대한 async
// 시스템 내부적으로 async 이면 await 해주는 것으로 보임
// -> 아닌 것 같음 (일반 함수와 다를 바 없음)
test() {
  ElevatedButton(
    // void Function()? onPressed;
    // async 를 추가하면 await 활용 가능
    onPressed: () async {
      debugPrint('before');
      await Future.delayed(
        Duration(seconds: 3),
        () {
          debugPrint('delayed');
        },
      );
      debugPrint('after');
    },
    child: Text('efe'),
  );

  GestureDetector(
    // void Function()? onTap;
    onTap: () async {
      debugPrint('before');
      await Future.delayed(
        Duration(seconds: 3),
            () {
          debugPrint('delayed');
        },
      );
      debugPrint('after');
    },
    child: Text('efe'),
  );
}


// 3. 위의 추측을 테스트 해보기
// -> 위의 추측은 아닌 것으로(즉, 시스템은 언제나 동기적으로 호출) 보이나 테스트 결과처럼 처리도 가능함
test2() {
  // Future 을 리턴하는 함수타입을 void 을 리턴하는 함수타입에 대입 가능
  // https://stackoverflow.com/questions/44614804/how-does-ontap-voidcallback-handler-work-when-its-an-async-returning-a-future
  // 공식 문서에 따르면 int 는 int? 의 하위타입, String Function() 은 void Function() 의 하위타입
  // https://dart.dev/resources/glossary
  final VoidCallback main = () async {
    await Future.delayed(Duration(seconds: 1), () {
      debugPrint('hooray~');
    },);
  };

  caller() async {
    // main 가 AsyncCallback 이면 await 호출, 아니면 일반 호출
    if (main is AsyncCallback) {
      await main();
    } else {
      main();
    }
  }
}


// 4.
Future<int> future() async {
  return 3;
}

Future<int> future2() async {
  return Future<int>.value(3);
}