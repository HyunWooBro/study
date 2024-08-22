import Foundation


struct Test: Codable {
    var number: Int
    var option: Int?
}

struct Test2: Codable {
    var number: Int
    var option: Int?
    var str: String
}

struct Test3: Codable, Identifiable {
    var id: Int {
        return number
    }
    
    var computed: String? {
        return "hello"
    }
    
    var number: Int
    var option: Int?
}


// JSON 은 Javascript Object 가 아니기 때문에 다른 규약을 가지고 있음
// 키는 반드시 따옴표로 묶여 있어야 하며, 값은 문자열에만 따옴표를 사용
// 만약 number 의 값에 따옴표를 사용하면 에러 발생 
let data = """
{
    "number": 200,
    "image_tag": "향수",
    "idx": 3
}
""".data(using: .utf8)!


func decode<T: Codable>(data: Data, type: T.Type) {
    guard let output = try? JSONDecoder().decode(type, from: data) else {
        print("Error: JSON Data Parsing failed")
        return
    }
    
    print(output)
}

// decode 시 type 에 옵셔널을 제외한 필수 데이터를 포함하고 있으면 파싱 가능
decode(data: data, type: Test.self)
// 옵셔널이 아님에도 값을 채울 수 없으면 파싱 에러
decode(data: data, type: Test2.self)
// 계산 프로퍼티의 경우에는 파싱의 대상이 아님
decode(data: data, type: Test3.self)



JSONSerialization

Encodable
func encode(to encoder: Encoder)
JSONEncoder

Decodable
init(from decoder: Decoder)
JSONDecoder
