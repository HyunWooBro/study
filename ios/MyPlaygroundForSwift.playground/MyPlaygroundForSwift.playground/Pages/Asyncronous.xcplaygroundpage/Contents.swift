import Foundation



// 비동기

Operation
OperationQueue
BlockOperation


DispatchQueue


DispatchTime

//DispatchQueue.main.asyncAfter(wallDeadline: .now(), execute: <#T##DispatchWorkItem#>)


// 앱이 실행되면 2가지 Queue 가 자동으로 생성

// Main Queue => Serial Queue
DispatchQueue.main.async {

}


// Global Queue => Concurrent Queue
DispatchQueue.global().async {
    print("Thread 1 is in critical section")
}

DispatchQueue.global().async {
    print("Thread 2 is in critical section")
}



DispatchQueue.getSpecific(key: <#T##DispatchSpecificKey<T>#>)
DispatchQueue.main.getSpecific(key: <#T##DispatchSpecificKey<T>#>)
DispatchQueue.global().getSpecific(key: <#T##DispatchSpecificKey<T>#>)

DispatchQueue.main.setSpecific(key: <#T##DispatchSpecificKey<T>#>, value: <#T##T?#>)



//DispatchGroup().enter()
//
//
//
//async
//
//
//await
//
//
//
//Combine()
//
//
//
//RxSwift 등
