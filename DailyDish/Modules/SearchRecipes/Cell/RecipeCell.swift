import UIKit

class RecipeCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .phioletColor
        container.clipsToBounds = true
        container.layer.cornerRadius = 27.5
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
        label.font = .montserratSemiBold(ofSize: 34)
        label.text = "Burito"
        label.textColor = .black
        return label
    }()
    private lazy var circle: UIView = {
        let circleView = UIView()
        circleView.backgroundColor = .white
        circleView.layer.cornerRadius = 8
        return circleView
    }()
    lazy var nationType: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 21)
        label.text = "Mexican"
        label.textColor = .black
        return label
    }()
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 21)
        label.text = "Fish tacos are a favorite quick and easy weeknight meal...."
        label.numberOfLines = 0
        label.textColor = .black
        return label
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
        layer.masksToBounds = true
        
        addSubviews(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        container.addSubviews(mainImage,
                              mainTitle,
                              circle,
                              nationType,
                              infoLabel)
        
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.centerX.equalToSuperview()
            make.height.equalTo(145)
            make.width.equalTo(186)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(22)
            make.left.equalToSuperview().offset(28)
        }
        circle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(28)
            make.width.height.equalTo(14)
        }
        nationType.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(16)
            make.left.equalTo(circle.snp.right).offset(14)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(circle.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().offset(-28)
            make.bottom.equalToSuperview().offset(-28)
        }
    }
    
//    func configure(model: GoalModel) {
//        titleLabel.text = model.name
//        let progress = Int((model.currentSeries * 100)/model.iterationCount)
//        progressView.progress = Float(progress) * 0.01
//        countLabel.text = "\(model.iterationCount)/\(model.currentSeries)"
//    }
}
