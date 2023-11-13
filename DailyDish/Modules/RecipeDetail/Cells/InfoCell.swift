import UIKit
import Kingfisher

class InfoCell: UITableViewCell {
    
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
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var foodName: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.text = "Burito"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 16)
        label.text = "Fish tacos are a favorite quick and easy weeknight meal. Choose cod, tilapia, or halibut, quickly pan-sear in a skillet, and serve with a simply cabbage slaw. 20 minutes start to finish!"
        label.textColor = .black
        label.numberOfLines = 0
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
        
        addSubviews(container,
                    foodName,
                    infoLabel)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(227)
        }
        container.addSubviews(mainImage)
        
        mainImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(145)
            make.width.equalTo(186)
        }
        foodName.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(18)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(foodName.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func configure(model: RecipeModel?) {
        mainImage.kf.setImage(with: model?.image.url)
        foodName.text = model?.name
        infoLabel.text = model?.description
    }
}
