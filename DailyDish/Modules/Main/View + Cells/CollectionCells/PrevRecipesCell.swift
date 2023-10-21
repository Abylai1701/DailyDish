import UIKit

class PrevRecipesCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .whiteBlue
        container.clipsToBounds = true
        container.layer.cornerRadius = 16
        return container
    }()
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "burito")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.text = "Burito"
        label.textColor = .black
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Setup Views
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        layer.masksToBounds = true
        
        addSubviews(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        container.addSubviews(mainImage,
                              mainTitle)
        
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(85)
            make.width.equalTo(109)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
//    func configure(model: GoalModel) {
//        titleLabel.text = model.name
//        let progress = Int((model.currentSeries * 100)/model.iterationCount)
//        progressView.progress = Float(progress) * 0.01
//        countLabel.text = "\(model.iterationCount)/\(model.currentSeries)"
//    }
}
