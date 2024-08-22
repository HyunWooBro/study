


// NSDiffableDataSourceSnapshot vs. NSDiffableDataSourceSectionSnapshot
// 전자는 전체 레이아웃을 관리한다면, 후자는 섹션 단위로 관리한다.
// 전자를 일반적으로 사용하지만, 더 정교한 제어가 필요한 경우 후자를 사용한다.



// apply vs. applySnapshotUsingReloadData
// 전자는 비교해서 업데이트, 후자는 리셋하고 업데이트
// 따라서 전자는 차이만큼 애니메이션을 넣는 파라미터가 있지만, 후자는 애니메이션이 없다.
// apply 메서드는 메인큐 이외에서 호출해도 되지만 일관성 있게 하나의 큐에서만 계속 호출해야 한다.


// apply 적용할 때 (1) 레이아웃 -> (2) 데이터소스 프로세스를 따르게 된다.

// 레이아웃 결과는 기본적으로 캐시를 하는 것으로 보이며, 갱신이 필요한 경우에만 재호출되는 것으로 보인다.
// TODO: 이 부분은 print() 도움을 받아 개별 테스트가 필요
// 예를 들어, 섹션이 3개가 있을 때 마지막 섹션의 아이템만 수정한다면 첫번째와 두번째 섹션의 레이아웃은 처음에만 호출되겠지만, 마지막 섹션을 삭제하는 등의 액션을 취하면 전체 섹션의 레이아웃이 다시 호출된다.



// 해시값이 같은 아이템을 동시에 여러 섹션에 동시에 삽입할 수 없다.
// => 우회방법은 래핑 (클래스 또는 enum 연관값)



//



// reconfigureItems vs. reloadItems
// [공통점]
// Snapshot 에 이미 포함되어 있는 아이템을 갱신하기 때문에 없는 아이템일 경우 오류가 발생한다.
// 모두 Self-Sizing 을 지원한다.
// [차이점]
// 전자는 기존 셀의 내용을 갱신한다면, 후자는 셀을 다시 큐에서 꺼낸다. 따라서 전자의 경우 prepareForReuse() 가 호출이 안되지만, 후자의 경우는 호출된다.

// 일반적으로 전자를 사용하는 것이 기본이며, 사용해야할 분명한 이유가 있을 경우에만 후자를 사용하라고 권고하고 있다.

// 애니메이션이 세팅되어 있을 때, reloadItems() 는 다음과 유사하다.
snapshot.deleteItems()
dataSource.apply(snapshot, animatingDifferences: true)
snapshot.appendItems()
dataSource.apply(snapshot, animatingDifferences: true)

// 애니메이션이 세팅되어 있을 때, reconfigureItems() 는 다음과 유사하다.
snapshot.deleteItems()
snapshot.appendItems()
dataSource.apply(snapshot, animatingDifferences: true)



// 스넵샷의 구조를 보면 섹션과 아이템은 각자 순서대로 보관된다. 아이템은 섹션별로 논리적으로 구분되기 때문에 예를 들어 첫번째 섹션 마지막에 아이템을 추가하면 해당 섹션에 속한 마지막 아이템 뒤에 삽입된다.
snapshot.sectionIdentifiers
snapshot.itemIdentifiers

// reloadItems() 를 통해 reload 된 아이템들은 reloadedItemIdentifiers 프로퍼티에서 확인 가능하다.
snapshot.reloadItems()
snapshot.reloadedItemIdentifiers

// reloadSections() 를 통해 reload 된 섹션들은 reloadedSectionIdentifiers 프로퍼티에서 확인 가능하다.
snapshot.reloadSections()
snapshot.reloadedSectionIdentifiers

// reconfigureItems() 를 통해 reconfigure 된 아이템들은 reconfiguredItemIdentifiers 프로퍼티에서 확인 가능하다.
snapshot.reconfigureItems()
snapshot.reconfiguredItemIdentifiers



let snapshot = dataSource.snapshot()
// 현재의 스넵샷에 대한 여러 테스트

// 1. 그대로 다시 적용하면 효과가 없다.
dataSource.apply(snapshot, animatingDifferences: true)

// 2. reconfigure
snapshot.reconfigureItems(<#T##[ItemIdentifierType]#>)
dataSource.apply(snapshot, animatingDifferences: true)

// 3. reloadItems
snapshot.reloadItems(<#T##[ItemIdentifierType]#>)
dataSource.apply(snapshot, animatingDifferences: true)

// 4. insertItems
snapshot.insertItems(<#T##[ItemIdentifierType]#>, afterItem: <#T##ItemIdentifierType#>)
dataSource.apply(snapshot, animatingDifferences: true)

// 5. deleteItems
snapshot.deleteItems(<#T##[ItemIdentifierType]#>)
dataSource.apply(snapshot, animatingDifferences: true)

// 6. moveItem
snapshot.moveItem(<#T##ItemIdentifierType#>, afterItem: <#T##ItemIdentifierType#>)
dataSource.apply(snapshot, animatingDifferences: true)

// 7. 같은 deleteItems + appendItems
snapshot.deleteItems(<#T##[ItemIdentifierType]#>)
snapshot.appendItems(<#T##[ItemIdentifierType]#>)
dataSource.apply(snapshot, animatingDifferences: true)


// 존재하지 않는 아이템을 갱신 테스트

// !!!: 존재하지 않는 아이템을 reconfigureItems() 을 통해 갱신하는 경우에는 크래쉬가 발생한다. 한편, 콘솔에는 다음과 같은 로그가 출련된다.
// Attempted to reconfigure item identifier that does not exist in the snapshot: Collectors.HomeScrollSectionItem.feed(196)

// !!!: 존재하지 않는 아이템을 reloadItems() 을 통해 갱신하는 경우에는 크래쉬가 발생한다. 한편, 콘솔에는 다음과 같은 로그가 출련된다.
// Attempted to reload item identifier that does not exist in the snapshot: Collectors.HomeScrollSectionItem.feed(199)



// 이미 존재하는 섹션 또는 아이템을 재삽입시 테스트

// !!!: 섹션이 이미 존재하는 경우에 appendSections() 또는 insertSections() 를 통해 재삽입하는 경우에는 크래쉬가 발생한다. 한편, 콘솔에는 다음과 같은 로그가 출력된다.
// Diffable data source detected an attempt to insert or append 1 section identifier that already exists in the snapshot. Identifiers in a snapshot must be unique. Section identifier that already exists: Collectors.BottomSheetScrollSection.contents

// 아이템이 이미 존재하는 경우에 appendItems() 또는 insertItems() 를 통해 재삽입하는 경우 기존 아이템의 위치에서 삽입된 위치로 변경되며 새로운 아이템이 추가되듯이 prefareForReuse() 가 재호출되며 셀을 세팅한다. 한편, 콘솔에는 다음과 같은 로그가 출력된다.
// Diffable data source detected an attempt to insert or append 2 item identifiers that already exist in the snapshot. The existing item identifiers will be moved into place instead, but this operation will be more expensive. For best performance, inserted item identifiers should always be unique. Set a symbolic breakpoint on BUG_IN_CLIENT_OF_DIFFABLE_DATA_SOURCE__IDENTIFIER_ALREADY_EXISTS to catch this in the debugger. Item identifiers that already exist: (
//    "Collectors.Comment(commentIdx: 40, commentParentIdx: nil, memberDetails: Collectors.MemberDetails(memberIdx: 16, memberNickname: \"collectors_kit\", memberSubTitle: Optional(\"\Ubc14\Ubcf4\Ud0c0\Uc774\Ud2c0\"), memberPortraitPath: Optional(\"02962f39-79ba-48ee-bd19-0c621cd0c293\"), memberRenderingType: Collectors.RenderingType.image, memberNicknameFlag: Collectors.Flag.y), toMemberDetails: nil, commentDescription: \"\U3134\U314e\", subCommentCount: Optional(0), commentRegDate: \"2024-02-07T21:37:46.000Z\")",
//    "Collectors.Comment(commentIdx: 39, commentParentIdx: nil, memberDetails: Collectors.MemberDetails(memberIdx: 16, memberNickname: \"collectors_kit\", memberSubTitle: Optional(\"\Ubc14\Ubcf4\Ud0c0\Uc774\Ud2c0\"), memberPortraitPath: Optional(\"02962f39-79ba-48ee-bd19-0c621cd0c293\"), memberRenderingType: Collectors.RenderingType.image, memberNicknameFlag: Collectors.Flag.y), toMemberDetails: nil, commentDescription: \"\Uc288\", subCommentCount: Optional(0), commentRegDate: \"2024-02-07T21:37:02.000Z\")"
// )



// !!!: SSOT(Single Source Of Truth) 관련?
// 섹션과 아이템 identifier 는 Hashable 해야 하는데 기본적으로 Identifiable 을 적용하여 해당 ID 로만 identifier 역할을 하도록 권장하고 있고, struct 등을 직접 사용하는 것을 권장하고 있지 않다.
// 참조:
// 그 이유는 struct 자체를 identifier 로 넣으면 struct 를 구성하는 단 하나의 값만 바뀌어도 DiffableDataSource 입장에서는 다른 아이템으로 판단하기 때문에 이전 아이템은 지우고 새로운 아이템을 생성하기 때문이다.
// 애플은 아이템이 바뀌지 않는 경우만 제외하고 ID를 identifier 역할을 하도록 권장하고 있는데, 이 경우에 실제 데이터가 바뀌더라도 DiffableDataSource 는 감지할 수 없다. 단순히 ID 만 바라보기 때문이다. 따라서 DiffableDataSource에게 해당 데이터를 재갱신하라고 알려주어야 한다.

// 개인적으로는 애플이 권장하는 방식 말고 전체 struct 를 identifier 로 세팅하되 id 역할을 하는 요소만으로 hash(into:) 와 == 를 직접 정의해서 사용하는 것이 좋은 것 같다. 이런 식으로 하면 따로 데이터를 관리하지 않아도 DiffableDataSource 가 필요한 모든 데이터를 관리하여 따로 데이터를 관리할 필요가 없고, 변경되지 않는 id 역할을 하는 요소만으로 Hashable 을 구현하기 때문에 일부 데이터가 수정되었다고 해서 다른 아이템으로 인식하지 않기 때문이다.

// 하지만 위의 방식에는 치명적인 단점이 있다는 것을 발견했다. 성능 측면에서 뿐만 아니라 활용 측면에서도 문제가 있기 때문이다.
// 우선 위의 방식으로 데이터를 재갱신하기 위해서는 기존 데이터를 지우고 그 자리에 새로운 데이터를 넣어야 한다. snapshot 만 변경해서는 안되고 지운 데이터를 DiffableDataSource 에 apply() 후, Snapshot을 재구성해서 또 한번 apply() 해야 한다. 왜냐하면 DiffableDataSource 은 말그대로 diffable 한 부분을 찾아서 교체해 주는 원리인데 struct 의 다른 요소가 수정되더라도 결국 id 요소가 변화가 없기 때문에 DiffableDataSource 는 변화를 감지하지 못하기 때문이다. 더구나 완전히 지우고 다시 구성하면 스크롤 이슈도 발생할 수 있다.
// reconfigure() 이나 reloadItems() 같은 메서드도 사용할 수 없다. 이들 메서드는 값을 바로 갱신하는 것이 아니라 해당 ID 에 재갱신이 필요하다는 세팅만 하며 apply() 할 때 실제 적용된다. 즉, 애플이 의도된 방식으로 개발해야 이러한 메서드의 이점을 살릴 수 있는 것이다.
// 결론적으로 개발의 주체인 애플이 권장하는 방식을 사용해야 한다는 것인데, DiffableDataSource 는 Identifier 만 보관하는 것이고 실제 데이터는 외부에서 관리해야 한다는 것이 포인트이다. 마침 RxSwift 과 함께 상태를 관리하는 ReactorKit 방식을 도입했기 때문에 적절한 타이밍으로 보인다.

// !!!: 삽입되는 섹션이 다르다고 하더라도 아이템은 다른 해시값을 가져야 한다. 같은 아이템을 여러 섹션에서 동시에 활용해야 한다면, 아이템을 enum 의 Associated Value 등으로 래핑하여 사용해야 한다.

// IndexPath 와는 달리 NSDiffableDataSourceSnapshot 에서 제공하는 indexOfItem() 을 통해 얻는 index 는 0 부터 시작하여 섹션과 관계없이 모든 아이템에게 차례대로 부여된다. 단, 앞선 섹션에 소속된 아이템부터 index 가 부여된다.


// UICollectionViewDiffableDataSource 의 생성자 init(collectionView:cellProvider:) 에서 cellProvider 의 타입은 다음과 같다.
// public typealias CellProvider = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ itemIdentifier: ItemIdentifierType) -> UICollectionViewCell?
// !!!: 리턴타입이 Optional 타입을 허용함에도 불구하고 nil 을 반환하면 크래쉬가 발생하기 때문에 주의해야 한다.




import UIKit
import PlaygroundSupport
import SnapKit

struct Contact: Hashable, Identifiable {
    var id: UUID = UUID()
    
    var name: String
    var image: String
}

fileprivate typealias ContactDataSource = UICollectionViewDiffableDataSource<MyViewController.Section, Contact.ID>
fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<MyViewController.Section, Contact.ID>

class MyViewController : UIViewController {
    
    // Here we add a cell identifier.
    let cellId = "cellId"
    // We then create our Contact array which will hold our contacts data.
    private var contacts = [Contact]()
    // We create an instance of our contact data source
    private var dataSource: ContactDataSource!
    // Finally our collectionView which we will setup later.
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createData()
        configureHierarchy()
        configureDataSource()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.reconfigure()
            var snapshot = DataSourceSnapshot()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(self.contacts.map { $0.id })
//            snapshot.reconfigureItems(snapshot.itemIdentifiers(inSection: .main))
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
}

extension MyViewController {
    private func createData() {
        for i in 0..<10 {
            contacts.append(Contact(name: "Contact \(i)", image: ""))
        }
    }
    
    private func reconfigure() {
        contacts[0].name += " changed"
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 8, trailing: 16)
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //3
        let section = NSCollectionLayoutSection(group: group)
        //4
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureHierarchy() {
        //1
        collectionView = UICollectionView(frame: view.bounds,      collectionViewLayout: createLayout())
        //2
        collectionView.delegate = self
        //3
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        //4
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = ContactDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, ID) -> ContactCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ContactCell
            cell.contact = self.contacts.first { $0.id == ID }
            return cell
        })
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(self.contacts.map { $0.id })
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension MyViewController: UICollectionViewDelegate  {
    fileprivate enum Section {
        case main
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let contact = dataSource.itemIdentifier(for: indexPath) else {   return}
        print(contact)
    }
}

class ContactCell: UICollectionViewCell  {
    
    var contact: Contact? {
        didSet {
            nameLbl.text = contact?.name
            //            contactImage.loadImageUsingCacheWithUrlString(urlString: contact?.image ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCardCellShadow()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var nameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Contact Name", size: 22)
        lbl.textColor = UIColor.init(white: 0.3, alpha: 0.4)
        return lbl
    }()
    
    lazy var contactImage: UIImageView = {
        let profileImg = UIImage(systemName: "person.crop.circle")
        let renderedImg = profileImg!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imv = UIImageView(image: renderedImg )
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.layer.cornerRadius = 25
        imv.layer.masksToBounds = true
        return imv
    }()
    
    private func setupCell() {
        
        self.backgroundView?.addSubview(contactImage)
        self.backgroundView?.addSubview(nameLbl)
        
        NSLayoutConstraint.activate([
            contactImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contactImage.widthAnchor.constraint(equalToConstant: 50),
            contactImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 16),
            nameLbl.widthAnchor.constraint(equalToConstant: 200),
            nameLbl.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    override var isHighlighted: Bool {
        
        didSet{
            
            var transform = CGAffineTransform.identity
            if isHighlighted {
                transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
            
            UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    
    func setupCardCellShadow() {
        backgroundView = UIView()
        addSubview(backgroundView!)
        backgroundView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backgroundView?.backgroundColor     = .white
        backgroundView?.layer.cornerRadius  = 26
        backgroundView?.layer.shadowOpacity = 0.1
        backgroundView?.layer.shadowOffset  = .init(width: 4, height: 10)
        backgroundView?.layer.shadowRadius  = 10
        
        layer.borderColor  = UIColor.gray.cgColor
        layer.borderWidth  = 0.2
        layer.cornerRadius = 26
        self.layoutIfNeeded()
    }
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()


