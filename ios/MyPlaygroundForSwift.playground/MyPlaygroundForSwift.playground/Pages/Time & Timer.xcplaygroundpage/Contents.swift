import Foundation


// ===============================
// 시간 관련 타입 정리
// ===============================

// Date : 특정 시점을 나타내는 구조체
// DateInterval : 날짜 차이 (시작 Date, 종료 Date)
// TimeInterval : 시간 차이 (Double 별칭)

// DateComponents : 년, 월, 일, 시간, 분, 초 등의 시간의 단위를 다룸
// Calendar : 그레고리력 기반의 달력 시스템
// TimeZone : UTC 시간대

// Locale : 로컬라이징 시간 표현
// DateFormatter : 시간 <-> 텍스트


// current : 변수 값이 세팅될 시점의 기기의 설정값 (처음만 반영)
// autoupdatingCurrent : 실시간 기기의 설정값 (변경되면 반영)

Locale.current
Locale.autoupdatingCurrent

Calendar.current
Calendar.autoupdatingCurrent

TimeZone.current
TimeZone.autoupdatingCurrent

print(Locale.current.identifier)
print(TimeZone.current.identifier)
print(Calendar.current.identifier)


// ===============================
// 시간 관련 테스트
// ===============================

// Date 테스트

// 현재 날짜
let date = Date()
// 현재 날짜 (iOS 15+)
let now = Date.now

// date-time-timezone 포맷으로 출력
print(date.description)
print(now.description)

// 로케일 적용
print(date.description(with: Locale(identifier: "en_US")))
print(date.description(with: Locale(identifier: "ja_JP")))
print(date.description(with: Locale(identifier: "ko_KR")))

// 현재를 기준으로 date 평가 (기준보다 과거라면 마이너스)
print(date.timeIntervalSinceNow)
// 2001-01-01 기준으로 date 평가 (기준보다 과거라면 마이너스)
print(date.timeIntervalSinceReferenceDate)
// 1970-01-01 기준으로 date 평가 (기준보다 과거라면 마이너스)
print(date.timeIntervalSince1970)

// iOS 15 에서 추가된 포맷 메서드 (formatted)
print(date.formatted())
print(date.formatted(date: .numeric, time: .shortened))
print(date.formatted(date: .complete, time: .complete))
print(date.formatted(date: .complete, time: .shortened))
print(date.formatted(date: .abbreviated, time: .complete))
print(date.formatted(date: .long, time: .standard))
print(date.formatted(
    .dateTime
        .year(.twoDigits)
        .month(.abbreviated)
        .day(.twoDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .minute(.twoDigits)
        .timeZone(.identifier(.long))
        .era(.wide)
))

// iOS 15 에서 추가된 포맷 메서드 (ISO8601Format)
print(date.ISO8601Format())
print(date.ISO8601Format(
    .iso8601
        .weekOfYear()
        .year()
        .month()
        .day()
        .dateSeparator(.omitted)
        .timeSeparator(.colon)
))



// DateFormatter 테스트
do {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d, y 'at' h:mm a, zzzz"
    var date = formatter.date(from: "December 9, 1968 at 3:45 PM, Pacific Standard Time")
    print(date?.description(with: Locale(identifier: "ko_KR")))
}

do {
    let formatter = DateFormatter()
    formatter.dateStyle = .full
    formatter.timeStyle = .full
    print(formatter.string(from: Date()))
}



// ISO8601DateFormatter 테스트
do {
    let isoFormatter = ISO8601DateFormatter()
    var date = isoFormatter.date(from: "1968-12-09T15:45:00-08:00")
    print(date?.description(with: Locale(identifier: "ko_KR")))
}



// Calendar, DateComponents 테스트
do {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")
    
    let components = DateComponents(
        calendar: calendar,
        timeZone: TimeZone(identifier: "Asia/Seoul"),
        year: 2007
    )
    
    var date = calendar.date(from: components)
    print(date?.description(with: Locale(identifier: "ko_KR")))
}

do {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let min = calendar.component(.minute, from: date)
    let sec = calendar.component(.second, from: date)
    print("time : \(hour):\(min):\(sec)")
}

do {
    let date = Date()
    print("time : \(date.formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated)))):\(date.formatted(.dateTime.minute(.twoDigits))):\(date.formatted(.dateTime.second(.twoDigits)))")
}



// 시간 차이

do {
    var formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .abbreviated
    print(formatter.localizedString(for: date, relativeTo: Date()))
    formatter.unitsStyle = .full
    print(formatter.localizedString(for: date, relativeTo: Date()))
    formatter.unitsStyle = .short
    print(formatter.localizedString(for: date, relativeTo: Date()))
    formatter.unitsStyle = .spellOut
    print(formatter.localizedString(for: date, relativeTo: Date()))
}

do {
    var time1 = Date.now
    var time2 = Date.now.advanced(by: 120)
    print(time1.distance(to: time2))
}


// ===============================
// 타이머
// ===============================

do {
    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
        
    }
    
    // 취소 가능
    timer.invalidate()
    
    // Timer 는 기본적으로 손가락을 떼지 않고 터치 이벤트를 계속해서 발생시키면 타이머가 실행되지 않는다. 터치 이벤트와는 별개로 정확히 실행하기 위해서는 런루프의 모드를 변경해야 한다.
    // 참조: https://stackoverflow.com/questions/11712546/nstimer-not-working-while-dragging-a-uitableview
    RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
}

do {
    // GCD 를 통해서도 타이머를 흉내낼 수 있지만 기본적으로 취소할 수가 없다.
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        
    }
}
