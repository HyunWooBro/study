import UIKit





loadObject




// ===============================
// PHPickerViewControllerDelegate
// ===============================

let progress = Progress()

func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    progress = Progress(totalUnitCount: Int64(results.count))
    results.forEach { result in
        let progress = result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            
        }
        progress.addChild(progress, withPendingUnitCount: 1)
    }
}

observations = [
    observe(\.progress.fractionCompleted) { (_,_) in
        if progress.fractionCompleted >= 1.0 {
            // loadObject 가 모두 완료되면 호출됨
        }
    }
]
