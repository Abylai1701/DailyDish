import UIKit

class GenRecipeCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.borderWidth = 1
        container.layer.shadowColor = UIColor.black.cgColor // Цвет тени
        container.layer.shadowOpacity = 1 // Прозрачность тени
        container.layer.shadowOffset = CGSize(width: -8, height: 8) // Смещение тени
        container.layer.shadowRadius = 5 // Радиус размытия тени
        container.layer.masksToBounds = false // Важно для отображения тени
        return container
    }()
    lazy var notes: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notes")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "gen_image")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var mainTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 24)
        label.text = "Generate recipes"
        label.textColor = .black
        return label
    }()
    lazy var infoTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 13)
        label.text = "Don’t know what to eat. No worries, our AI assisted model will help you find exactly what you want based on your food preferences."
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.titleLabel?.font = .montserratSemiBold(ofSize: 16)
        button.setTitle("Generate",
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        return button
    }()
    lazy var notes2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "notes")
        image.contentMode = .scaleAspectFit
        return image
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
        addSubviews(container)
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        container.addSubviews(notes,
                              mainImage,
                              mainTitle,
                              infoTitle,
                              generateButton,
                              notes2)
        
        notes.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
            make.width.equalTo(21)
        }
        mainImage.snp.makeConstraints { make in
            make.top.equalTo(notes.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(33)
            make.right.equalToSuperview().offset(-33)
        }
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        infoTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(42)
            make.right.equalToSuperview().offset(-42)
        }
        generateButton.snp.makeConstraints { make in
            make.top.equalTo(infoTitle.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(108)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-30)
        }
        notes2.snp.makeConstraints { make in
            make.top.equalTo(infoTitle.snp.bottom).offset(14)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(14)
            make.width.equalTo(21)
        }
    }
    
//    func configure(model: GoalModel) {
//        titleLabel.text = model.name
//        let progress = Int((model.currentSeries * 100)/model.iterationCount)
//        progressView.progress = Float(progress) * 0.01
//        countLabel.text = "\(model.iterationCount)/\(model.currentSeries)"
//    }
}
