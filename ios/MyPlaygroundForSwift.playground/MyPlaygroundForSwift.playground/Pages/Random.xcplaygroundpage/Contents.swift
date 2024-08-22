

// 연속된 값에서 랜덤으로 선택
Int.random(in: 0...2)
Double.random(in: 0.0...1.0)

// 배열의 임의의 요소 중에서 랜덤으로 선택
[0, 10, 15].randomElement()

// 임의의 순서로 배열을 섞음
var array = [0, 1, 2]
array.shuffle()
// 임의의 순서로 배열의 복사본 반환
[0, 1, 2].shuffled()


SystemRandomNumberGenerator().next()
