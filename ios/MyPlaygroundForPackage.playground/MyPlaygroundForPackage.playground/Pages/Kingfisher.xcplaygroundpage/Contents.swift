import UIKit
import CoreMedia
import PlaygroundSupport
import Kingfisher

class MyViewController : UIViewController {
    override func viewDidLoad() {
        
        // ===============================
        // Kingfisher 제공 기능
        // ===============================
        // 이미지 로딩 (캐시되기 전 다수의 동일 URL 요청이 들어올 경우 하나의 네트워크 요청으로 처리)
        // -> ImageDownloader.default
        // 메모리/디스크 캐싱 (디폴트로 메모리 및 디스크 동시 캐싱)
        // -> ImageCache.default
        // 이미지 프로세싱 (다운샘플링, Blur, 블렌딩 등)
        // -> DownsamplingImageProcessor 등
        // 이미지 Prefetch
        // -> ImagePrefetcher
        // 이미지 전환 애니메이션
        // -> ImageTransition
        // 이미지 로딩 인디케이터
        // -> ActivityIndicator 등
        // 등등
        
        
        // 다음의 다수 옵션에 대해 숙지할 필요가 있음
        // KingfisherOptionsInfoItem
        
        
        let bigImageURL = "https://www.popco.net/zboard/data/dica_forum_sony/2017/01/20/20096982855881600edd5c7.jpg"
        let mediumImageURL = "https://img1.daumcdn.net/thumb/R1280x0.fjpg/?fname=http://t1.daumcdn.net/brunch/service/user/1k75/image/CuvOMYoqkh3140hupEVGHzA-Pyw.jpeg"
        let smallImageURL = "http://www.gasengi.com/data/cheditor4/2310/aeb920aeca9a784a44a257c103f074b6_74WLaTTeGbT4pqhvLTOqT.jpg"
        
        
        let image1 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 0, y: 0, width: 100, height: 100)
        }
        
        let image11 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 0, y: 100, width: 100, height: 100)
        }
        
        let image2 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 100, y: 0, width: 100, height: 100)
        }
        
        let image3 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 200, y: 0, width: 100, height: 100)
        }
        
        let image33 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 200, y: 100, width: 100, height: 100)
        }
        
        let image4 = UIImageView().then {
            self.view.addSubview($0)
            $0.frame = .init(x: 300, y: 0, width: 100, height: 100)
        }
        
        // 캐시 비우기
        KingfisherManager.shared.cache.clearCache()
        
//        UIImageView().kf.setImage(with: URL(string: bigImageURL)) { a in
//            print("xxx1")
//            print(Date.now.timeIntervalSince1970)
//        }
//
//        UIImageView().kf.setImage(with: URL(string: bigImageURL)) { a in
//            print("xxx3")
//            print(Date.now.timeIntervalSince1970)
//        }
//
//        UIImageView().kf.setImage(with: URL(string: bigImageURL)) { a in
//            print("xxx4")
//            print(Date.now.timeIntervalSince1970)
//        }
//
//        UIImageView().kf.setImage(with: URL(string: bigImageURL)) { a in
//            print("xxx5")
//            print(Date.now.timeIntervalSince1970)
//        }
//
//        UIImageView().kf.setImage(with: URL(string: bigImageURL)) { a in
//            print("xxx2")
//            print(Date.now.timeIntervalSince1970)
//        }
        
        
//        if true { return }
        
        print("===")
        print(Date.now.timeIntervalSince1970)

        if !KingfisherManager.shared.cache.isCached(forKey: bigImageURL) {
            print("aaa not hashed")
        }

        image1.kf.indicatorType = .activity
        var downloadTask = image1.kf.setImage(
            with: URL(string: bigImageURL),
            options: [.transition(.fade(1.5))]
        ) { received, total in
            let percentage = (Double(received) / Double(total)) * 100.0
            print("percentage : \(percentage)")
        } completionHandler: { a in
            print("aaa")
            print(Date.now.timeIntervalSince1970)

            if KingfisherManager.shared.cache.isCached(forKey: bigImageURL) {
                print("aaa hashed")
            }

            switch a {
            case .success(_):
                print("aaa success")
            case .failure(_):
                print("aaa failure")
            }
//            Log.info("---aaa")
        }
        
        

        let blur = BlurImageProcessor(blurRadius: 3.5)
        var downloadTask2 = image2.kf.setImage(
            with: URL(string: mediumImageURL),
            options: [.processor(blur)]
        ) { a in
            print("bbb")
            print(Date.now.timeIntervalSince1970)
//            Log.info("---bbb")
        }

        var downloadTask3 = image3.kf.setImage(with: URL(string: smallImageURL)) { a in
            print("ccc")
            print(Date.now.timeIntervalSince1970)
//            Log.info("---ccc")
        }

        var downloadTask4 = image33.kf.setImage(with: URL(string: smallImageURL)) { a in
            print("ccc2")
            print(Date.now.timeIntervalSince1970)
//            Log.info("---ccc")
        }

        if !KingfisherManager.shared.cache.isCached(forKey: bigImageURL) {
            print("aaa2 not hashed")
        }
        
        let processor = BlurImageProcessor(blurRadius: 0.2)
        image11.kf.indicatorType = .activity
        var downloadTask5 = image11.kf.setImage(
            with: URL(string: bigImageURL),
            options: [.processor(processor)]
        ) { a in
            print("aaa2")
            print(Date.now.timeIntervalSince1970)
//            Log.info("---ccc")

            if KingfisherManager.shared.cache.isCached(forKey: bigImageURL) {
                print("aaa2 hashed")
            }

            switch a {
            case .success(_):
                print("aaa2 success")
            case .failure(_):
                print("aaa2 failure")
            }
        }
        
        
//        downloadTask5?.cancel()
        
        
        if true { return }
        
        
        // ImageDownloader 테스트 (캐싱과 연관성이 없는 순수 이미지 다운로드)
        // 캐싱과 관계된 이미지 다운로드는 KingfisherManager.shared.retrieveImage(...) 참조
        
        ImageDownloader.default.downloadImage(with: URL(string: bigImageURL)!) { result in
            switch result {
            case let .success(data):
                print("AAA")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        ImageDownloader.default.downloadImage(with: URL(string: mediumImageURL)!) { result in
            switch result {
            case let .success(data):
                print("BBB")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        ImageDownloader.default.downloadImage(with: URL(string: mediumImageURL)!) { result in
            switch result {
            case let .success(data):
                print("BBB2")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        ImageDownloader.default.downloadImage(with: URL(string: bigImageURL)!) { result in
            switch result {
            case let .success(data):
                print("AAA2")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        ImageDownloader.default.downloadImage(with: URL(string: bigImageURL)!) { result in
            switch result {
            case let .success(data):
                print("AAA3")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        
        ImageDownloader.default.downloadImage(with: URL(string: smallImageURL)!) { result in
            switch result {
            case let .success(data):
                print("CCC")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        ImageDownloader.default.downloadImage(with: URL(string: smallImageURL)!) { result in
            switch result {
            case let .success(data):
                print("CCC2")
                print(Date.now.timeIntervalSince1970)
            case .failure(_):
                break
            }
        }
        
        
        
        // ImageCache 테스트
        
        ImageCache.default.store(<#T##image: KFCrossPlatformImage##KFCrossPlatformImage#>, forKey: <#T##String#>)
        ImageCache.default.retrieveImage(forKey: <#T##String#>, options: <#T##KingfisherParsedOptionsInfo#>, completionHandler: <#T##((Result<ImageCacheResult, KingfisherError>) -> Void)?##((Result<ImageCacheResult, KingfisherError>) -> Void)?##(Result<ImageCacheResult, KingfisherError>) -> Void#>)
        ImageCache.default.isCached(forKey: <#T##String#>)
        
        
        
        // AVAssetImageDataProvider 테스트

        let time = CMTime(value: 600, timescale: 600)
        
        let provider = AVAssetImageDataProvider(
            assetURL: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
            seconds: 30.0
        )
        
//        let images = provider.assetImageGenerator.images(for: [time])
        
//        provider.assetImageGenerator.copyCGImage(at: <#T##CMTime#>, actualTime: <#T##UnsafeMutablePointer<CMTime>?#>)
        
        
//        let imageReceived = try! provider.assetImageGenerator.copyCGImage(at: time, actualTime: nil)
//
//        image4.image = UIImage(cgImage: imageReceived)
        
        
//        provider.assetImageGenerator.generateCGImageAsynchronously(for: time) { image, time ,error in
//            print("abc")
//            print(error?.localizedDescription)
//            guard let image else { return }
//            print("abc")
//            image4.image = UIImage(cgImage: image)
//            image4.frame = .init(x: 300, y: 0, width: 100, height: 100)
//        }
        
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
