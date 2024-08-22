

// ===============================
// 와일드카드 패턴
// ===============================

let str = "ABC"

switch str {
case _: print(str)
}

let str2: String? = "ABC"

switch str2 {
case "ABC"?: print(str2)
case _?: print("hey")
case _: print("anything")
}

let tuple = ("kim", 18)

switch tuple {
case ("kim", _): print("hello kim")
default: print("get off")
}

for _ in 0...2 {
    print("loop")
}

func methodA() -> Bool {
    return true
}

_ = methodA()



// ===============================
// if case 패턴
// ===============================

// switch 문의 case 구문은 if case 구문으로 전환이 가능하다.

let value1 = "ABC"
let value2 = 30

// switch case
switch value1 {
case "ABC": print("1")
case is String: print("2")
}

switch value2 {
case 0...100: print("3")
case let value as Int: print("4")
}

// if case
if case "ABC" = value1 {
    print("true")
}
if case is String = value1 {
    print("true")
}

if case 0...100 = value2 {
    print("true")
}
if case let value as Int = value2 {
    print("true")
}



// ===============================
// 튜플 패턴
// ===============================

let (a) = 2
a

let (x, y) = (1, 2)
x
y

func methodB() -> (Int, String) {
    return (2, "test")
}

let (b, c) = methodB()
b
c
