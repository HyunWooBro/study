

struct AAA {
    var array = [0]
    
    func methodA() -> AAA {
        return self
    }
    
    func methodB() -> [Int] {
        return array
    }
    
    mutating func methodC() {
        array.append(1)
    }
}


var aaa = AAA()

// 에러 발생
// struct 가 반환하는 self 은 불변임
//aaa.methodA().methodC()

// 에러 발생
// struct 가 반환하는 내부 변수도 불변임
//aaa.methodB().append(2)

// 그렇다고 변수로 받아서 methodC() 호출하면 복사된 변수의 값만 변경됨
var temp = aaa.methodA()
temp.methodC()

print(aaa)
print(temp)

// 이럴 경우 AAA 를 class 타입으로 변경해야 한다.



var bbb: Any = AAA()

// 에러 발생
// 타입 캐스팅을 하면 불변 변수가 반환됨
//(bbb as! AAA).methodC()
