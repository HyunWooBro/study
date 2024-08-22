import UIKit


let cell = UICollectionViewCell()


// ===============================
// contentView
// ===============================

// 콜렉션뷰 셀을 사용할 때는 반드시 contentView 의 하위뷰로 추가해야 한다.
// 그렇지 않으면 여러 UI 이슈가 발생할 수 있다.
cell.contentView



// ===============================
// UIBackgroundConfiguration
// ===============================

// 기본 제공 백그라운드 스타일
UIBackgroundConfiguration.listPlainCell()
UIBackgroundConfiguration.listPlainHeaderFooter()
UIBackgroundConfiguration.listAccompaniedSidebarCell()
UIBackgroundConfiguration.listGroupedCell()
UIBackgroundConfiguration.listGroupedHeaderFooter()
UIBackgroundConfiguration.listSidebarCell()
UIBackgroundConfiguration.listSidebarHeader()

var configuration = UIBackgroundConfiguration.listPlainCell()
configuration.backgroundColor = .red
cell.backgroundConfiguration = configuration
setNeedsUpdateConfiguration()



// ===============================
// UIContentConfiguration
// ===============================

//
//UIContentConfiguration.
UICollectionViewCell().contentConfiguration.



// ===============================
// configurationUpdateHandler
// ===============================

// 셀의 상태에 따라 외관을 업데이트 하는 코드 관리
UICollectionViewCell().configurationUpdateHandler = { cell, state in
    state.isDisabled
}


