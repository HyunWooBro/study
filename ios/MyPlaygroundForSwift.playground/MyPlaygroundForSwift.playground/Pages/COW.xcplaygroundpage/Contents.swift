

// 값 타입 변수를 다른 변수에 대입할 경우 COW 방식으로 복사하기 때문에 바로 메모리 복사가 발생하는 것이 아니라 초기에는 참조로 복사가 되고 값의 변화가 있을 경우에만 메모리 복사가 발생한다. 하지만 이 기능은 모든 값 타입에 대해 제공되는 것이 아니라 구현이 된 일부의 타입에서만 제공하는 것을 주의해야 한다.

func address(of object: UnsafeRawPointer) -> String {
    let address = Int(bitPattern: object)
    return String(format: "%p", address)
}

var first = [1,2,3]
var second = first

// 기본 배열은 참조로 복사되고
print(address(of: &first))
print(address(of: &second))

// 값이 바뀌면 그제서야 값으로 복사됨
second.append(4)
print(address(of: &second))


struct Coordinate {
    var x: Int
    var y: Int
}

var p1 = Coordinate(x: 0, y: 0)
var p2 = p1

// 커스텀 값 타입은 기본적으로 값으로 복사됨을 확인
print(address(of: &p1))
print(address(of: &p2))


