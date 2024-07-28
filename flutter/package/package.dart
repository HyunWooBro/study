



//////////////////////////////////////////////////////////
// dart: (Dart 기본 구성요소)
//////////////////////////////////////////////////////////

// 자동 import (import 하지 않아도 자동 import)
import 'dart:core';
// 선택 import (필요하다면 import 명시)
import 'dart:collection';

// 참고로 dart:common 을 통해 dart:async 에 속한 Future, Stream 등이 자동 import 되기 때문에 바로 사용 가능함
// @Since("2.1")
// export "dart:async" show Future, Stream;
// @Since("2.12")
// export "dart:async" show FutureExtensions;
// @Since("3.0")
// export "dart:async"
//     show
//     FutureIterable,
//     FutureRecord2,
//     FutureRecord3,
//     FutureRecord4,
//     FutureRecord5,
//     FutureRecord6,
//     FutureRecord7,
//     FutureRecord8,
//     FutureRecord9,
//     ParallelWaitError;
//
// export "dart:collection" show NullableIterableExtensions, IterableExtensions;



//////////////////////////////////////////////////////////
// package: (현재 또는 외부 패키지)
//////////////////////////////////////////////////////////

// [외부 패키지]

// 기본 포함 (SDK 에 기본적으로 포함되어 있어 다운로드 불필요)
import 'package:collection/collection.dart';
// 선택 포함 (pub 을 통해 다운로드)
import 'package:http/http.dart';


// [현재 패키지]

// 절대 참조
import 'package:spark_today_quiz/common/util/error.dart';
// 상대 참조
import '../flutter/cache.dart';



//////////////////////////////////////////////////////////
// 유용한 외부 패키지
//////////////////////////////////////////////////////////









// 상태 관리 패키지는 기본적으로 presentation 영역에서 다뤄야 한다. Reactive UI 가 주 목적이기 때문이다.