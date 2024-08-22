import Foundation


// return 다음의 한 명령문까지 실행되는 것을 확인할 수 있음 (return 다음의 명령어는 return 의 파라미터로 해석되기 때문)
func forin() {
    let num = [1,2,3]
    for i in num {
        print(i)
        if true {
            return
            print("forin after return3")
            print("forin after return4")
        }
        print("forin after return")
        print("forin after return2")
    }
    print("함수 종료")
}
forin()

func forEach() {
    let num = [1,2,3]
    num.forEach {
        print($0)
        return
        print("forEach after return")
        print("forEach after return2")
    }
    print("함수 종료")
}
forEach()

func function() {
    return
    forEach()
    print("function after return2")
}
function()



// CircularQueue 테스트
// 출처: https://sangheon0724.medium.com/%EC%9E%90%EB%A3%8C%EA%B5%AC%EC%A1%B0-circular-queue-ring-buffer-%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-%EC%95%8C%EC%95%84%EB%B3%B4%EC%9E%90-feat-swift-f14081aad573
public struct CircularQueue<T> {
    
    fileprivate var array: [T?]
    fileprivate var frontIndex = 0
    fileprivate var rearIndex = 0
    
    public init(count:Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    public mutating func enqueue(_ element:T) {
        if !isFull {
            array[rearIndex % array.count] = element
            rearIndex += 1
        } else {
            array[rearIndex % array.count] = element
            rearIndex += 1
            frontIndex += 1
        }
    }
    
    public mutating func dequeue() -> T? {
        if !isEmpty {
            let element = array[frontIndex % array.count]
            frontIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    public var isEmpty:Bool {
        return availableSpaceForDequeue == 0
    }
    
    fileprivate var availableSpaceForDequeue: Int {
        return rearIndex - frontIndex
    }
    
    public var isFull:Bool {
        return availableSpaceForEnqueue == 0
    }
    
    fileprivate var availableSpaceForEnqueue: Int {
        return array.count - availableSpaceForDequeue
    }
    
    
}

var queue = CircularQueue<Int>(count: 3)

queue.enqueue(2)
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
queue.enqueue(3)
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
queue.enqueue(4)
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
queue.enqueue(5)
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)

let value = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
let value2 = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
let value3 = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
let value4 = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)

queue.enqueue(6)
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
let value5 = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)
let value6 = queue.dequeue()
print(queue.array.description)
print(queue.frontIndex % queue.array.count)
print(queue.rearIndex % queue.array.count)



// Stack 테스트
// 출처: https://babbab2.tistory.com/85
struct Stack<T> {
    fileprivate var array: [T] = []
    
    fileprivate let maxCount: Int
    
    public init(maxCount: Int = 10) {
        self.maxCount = maxCount
    }
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
        if maxCount != 0 && array.count > maxCount {
            array.remove(at: 0)
        }
    }
    
    public mutating func pop() -> T? {
        return isEmpty ? nil : array.popLast()
    }
    
    public func peek() -> T? {
        return isEmpty ? nil : array.last
    }
}

var stack = Stack<Int>(maxCount: 5)

stack.push(0)
print(stack)
stack.push(3)
print(stack)
stack.push(4)
print(stack.array.description)
stack.push(5)
print(stack.array.description)
stack.pop()
print(stack.array.description)
stack.peek()
print(stack.array.description)
stack.push(6)
print(stack.array.description)
stack.push(7)
print(stack.array.description)
stack.push(8)
print(stack.array.description)
stack.pop()
print(stack.array.description)
stack.peek()
print(stack.array.description)


// KMBFormatter 테스트
// 출처: https://github.com/a-sarris/KMBFormatter
KMBFormatter().string(fromNumber: 1996)
KMBFormatter().string(fromNumber: 1996600)
KMBFormatter().string(fromNumber: 1996600000)


