import Sheeeeeeeeet


// ===============================
// 개요
// ===============================

//



// ===============================
// 기본 개념
// ===============================

// Sheet

// Menu
    // MenuItem
    // MenuButton
    // MenuTitle

// Presenter



// ===============================
// 커스텀 Appearance
// ===============================


headerViewContainerHeight


let linkItem = ActionSheetLinkItemCell.appearance()
linkItem.linkIcon = UIImage(named: "ic_arrow_right")

let button = ActionSheetButtonCell.appearance()
button.titleFont = .systemFont(ofSize: 15)

let okButton = ActionSheetOkButtonCell.appearance()
okButton.titleColor = .black

let cancelButton = ActionSheetCancelButtonCell.appearance()
cancelButton.titleFont = .systemFont(ofSize: 13)
cancelButton.titleColor = .lightGray





// from 은 무슨 역할?
sheet.present(in: controller, from: nil)
