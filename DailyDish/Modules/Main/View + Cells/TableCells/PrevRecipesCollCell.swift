import UIKit

class PrevRecipesCollCell: UITableViewCell {
    
    //MARK: - Properties    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = CGSize(width: 200, height: 200)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.register(PrevRecipesCell.self, forCellWithReuseIdentifier: PrevRecipesCell.cellId)
        return collection
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup Views
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    //MARK: - Configure
//    func configure(model: [EventModel]) {
//        self.events = model
//        collectionView.snp.updateConstraints { make in
//            make.height.equalTo(model.count>0 ? 200 : 0)
//        }
//        self.collectionView.reloadData()
//    }
}

extension PrevRecipesCollCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrevRecipesCell.cellId, for: indexPath) as! PrevRecipesCell
        return cell
    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = EventDetailController(id: events[indexPath.row].id ?? 0)
//        Router.shared.push(vc)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == events.count - 1 {
//            increaseAction?()
//        }
//    }
}

extension PrevRecipesCollCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}
