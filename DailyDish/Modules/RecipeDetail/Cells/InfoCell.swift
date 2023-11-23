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
        image.image = UIImage(named: "")
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var foodName: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 20)
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    lazy var foodTags: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 16)
        label.text = ""
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
        
        addSubviews(container, foodName, foodTags, infoLabel)
        container.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(227)
        }
        setupContainerSubviews()
        setupConstraints()
    }
    
    private func setupContainerSubviews() {
        container.addSubviews(mainImage)
        mainImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(145)
            make.width.equalTo(186)
        }
    }
    
    private func setupConstraints() {
        foodName.snp.makeConstraints { make in
            make.top.equalTo(container.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(16)
        }
        foodTags.snp.makeConstraints { make in
            make.top.equalTo(foodName.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(16)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(foodTags.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    //MARK: - Public Methods
    func configure(model: RecipeModel?) {
        guard let model = model else { return }
        
        mainImage.kf.setImage(with: model.image.url)
        foodName.text = model.name
        let tagsText = model.tags.map { "#\($0)" }.joined(separator: ", ")
        foodTags.text = tagsText
        infoLabel.text = model.description
    }
}
