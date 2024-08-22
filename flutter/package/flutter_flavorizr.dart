

// 개요


// 디폴트 설정으로 코드 생성
// dart run flutter_flavorizr
// 명시한 설정으로 코드 생성
// dart run flutter_flavorizr -p assets:download,assets:extract,flutter:flavors,flutter:app,flutter:main,assets:clean


// Processor 개념
// InstructionSet 개념
// assets 명령어는 초기화 및 클린을 담당한다.
// github 에서 assets 다운받아 .tmp 디렉터리에 저장 후및 활용하고 나서 지운다.
// 'assets:download',
// 'assets:extract',
// 'assets:clean',


// 기본 InstructionSet
// static const List<String> defaultInstructionSet = [
//     // Prepare
//     'assets:download',
//     'assets:extract',

//     // Android
//     'android:androidManifest',
//     'android:buildGradle',
//     'android:dummyAssets',
//     'android:icons',
//     'android:adaptiveIcons',

//     // Flutter
//     'flutter:flavors',
//     'flutter:app',
//     'flutter:pages',
//     'flutter:main',
//     'flutter:targets',

//     // iOS
//     'ios:podfile',
//     'ios:xcconfig',
//     'ios:buildTargets',
//     'ios:schema',
//     'ios:dummyAssets',
//     'ios:icons',
//     'ios:plist',
//     'ios:launchScreen',

//     // macOS
//     'macos:podfile',
//     'macos:xcconfig',
//     'macos:configs',
//     'macos:buildTargets',
//     'macos:schema',
//     'macos:dummyAssets',
//     'macos:icons',
//     'macos:plist',

//     // Google
//     'google:firebase',

//     // Huawei
//     'huawei:agconnect',

//     // Cleanup
//     'assets:clean',

//     // IDE
//     'ide:config'
//   ];