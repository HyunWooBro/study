


// 이미지 캐시는 앱이 백그라운드에 갔다 다시 돌아오면 모두 지워지는 것으로 보인다.
// 검색에 따르면 메모리 사용이 많더거나 등의 조건이 필요한 것으로 보이지만,
// 내가 경험한 바에 따르면 항상 발생하는 것으로 보인다.

// 메모리가 부족하면 캐시를 지운다고 하는데 나갔다 바로 돌아와도 발생하고 있다.
// https://github.com/flutter/flutter/issues/64558

// precacheImage 개발자 주석을 보면 곧바로 리스너를 추가해야 유지된다고 한다.