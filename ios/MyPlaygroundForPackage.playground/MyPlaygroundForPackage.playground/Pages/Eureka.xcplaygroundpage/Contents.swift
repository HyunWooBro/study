import Eureka
import UIKit


let controller = FormViewController()
let form = controller.form


// ===============================
// 개요
// ===============================

// Eureka 는 전형적인 테이블 형식의 설정 화면을 구현하는 패키지이다. 커스텀 연산자 및 메서드 체인을 활용하여 직관적인 선언적 방식으로 개발할 수 있다.

// 함정이 많기 때문에 내부 동작을 이해해야 제대로 활용할 수 있을 것으로 보인다.



// ===============================
// 기본 개념
// ===============================

// Form
// Section
// Row
// Cell
// Operator
// Validation



// ===============================
// 라이프 사이클
// ===============================

// Initializer -> Cell -> Update


// ===============================
// Section
// ===============================

// 섹션은 헤더와 푸터로 구성된다.
Section("Title")
Section(header: "title", footer: "footer title")

// 커스텀뷰도 가능하다.
Section { section in
    section.header = HeaderFooterView(title: "title")
}



// ===============================
// Row
// ===============================

// Row 는 기본적으로 왼쪽에 title, 으론쪽에 value 구성된다.


// 각 Row 는 태그를 가질 수 있다. UIView 의 태그처럼 간편하게 접근하기 위한 용도이다.
form.rowBy(tag: <#T##String#>)
form.sectionBy(tag: <#T##String#>)


// 다양한 형태의 Row 존재

// LabelRow
// ButtonRow
// CheckRow
// ListCheckRow
// SwitchRow
// SliderRow
// StepperRow
// PickerRow
// DateTimePickerRow
// DatePickerRow
// TimePickerRow

// OptionsRow
    // AlertOptionsRow
        // AlertRow
        // ActionSheetRow
    // SegmentedRow
    // SelectorRow
        // PopoverSelectorRow
        // PushRow

// FormatteableRow
    // FieldRow
        // IntRow
        // DecimalRow
        // URLRow
        // PhoneRow
        // NameRow
        // EmailRow
        // PasswordRow
        // TextRow
    // AreaRow
        // TextAreaRow


// reload() : TableView 를 reload
// updateCell() : Cell 업데이트, defaultCellUpdate, cellUpdate 처리



// ===============================
// Cell
// ===============================

// Cell 은 TableViewCell 의 하위 클래스이다.
// Row 가 Cell 을 포함하는 관계에 가깝다.

// setup() : 생성자의 클로저 처리시 호출됨
// update() : Cell 업데이트



// ===============================
// Operator
// ===============================

// +++
// <<<



// ===============================
// Validation
// ===============================

//



// ===============================
// disabled & hidden
// ===============================

// disabled 및 hidden 은 다음 4가지 방법으로 정의할 수 있다.

CheckRow() {
    // 1. function
    $0.disabled = .function(<#T##[String]#>, <#T##(Form) -> Bool#>)
    // 2. predicate
    $0.disabled = .predicate(<#T##NSPredicate#>)
    // 3. String 형식
    $0.hidden = "$ETC == false"
    // 4. Bool 형식
    $0.disabled = true
}

// 초기화 클로저에서 정의하지 않고 이후에 정의한다면 다음 메서드를 호출해야 한다.
evaluateHidden()
evaluateDisabled()

// 예시
<<< CheckRow("ETC") { $0.title = "기타" }
    .cellSetup { cell, row in
        row.value = false
    }
<<< CheckRow { $0.title = "기타" }
    .cellSetup { cell, row in
        row.value = false
        // ETC 태그를 가진 Row 의 값이 false 이면 현재 Row 가 disabled 된다.
        row.disabled = "$ETC == false"
        row.evaluateDisabled()
    }



// ===============================
// 디폴트 정의
// ===============================

// 모든 LabelRow 디폴트 초기화 작업 정의 (개별 초기화 작업보다 선행)
LabelRow.defaultRowInitializer = { row in
    
}

// 모든 LabelRow 디폴트 셀생성시 작업 정의 (개별 셀생성시 작업보다 선행)
LabelRow.defaultCellSetup = { cell, row in

}

// 모든 LabelRow 디폴트 업데이트 작업 정의 (개별 업데이트 작업보다 선행)
LabelRow.defaultCellUpdate = { cell, row in
    
}

// 모든 LabelRow 디폴트 하이라이트 변경 작업 정의 (개별 하이라이트 변경 작업보다 선행)
LabelRow.defaultOnCellHighlightChanged = { cell, row in
    
}



// ===============================
// 예시
// ===============================

form

+++ Section("섹션입니다")

<<< TextAreaRow("태그") { $0.title = $0.tag }
    .cellSetup { cell, row in
        row.value = "알림이 활성화되면 앱이 백그라운드에 있더라도 알림을 받을 수 있습니다."
        row.textAreaMode = .readOnly
        row.textAreaHeight = .fixed(cellHeight: 60)
        // !!!: TextAreaRow 에서 textAreaHeight 속성은 setup() 과정에서만 세팅하기 때문에 TextAreaRow 초기화 클로저에서 설정하거나 아니면 설정한 후 명시적으로 setup() 을 호출해야 한다.
        cell.setup()
        row.updateCell()
    }
    .cellUpdate { cell, row in
        // !!!: textColor 같은 속성은 cellSetup 에서 작동하지 않는데 이는 highlighted 상태를 표현하기 위해 리셋되기 때문이라고 한다.
        // 출처: https://github/xmartlabs/Eureka/issues/2227
        cell.textView.textColor = .lightGray
    }
    .onCellSelection { cell, row in
        // 셀 터치시
        // !!!: isDisabled == true 경우에도 onCellSelection 는 호출된다. 필요시 guard 문을 추가해야 한다.
        // !!!: TextAreaRow 같은 일부 Row 에서는 호출되지 않는다.
    }
    .onCellHighlightChanged { cell, row in
        // 셀 하이라이트 변경시
    }
    .onChange { row in
        // Row 값 변경시
    }

