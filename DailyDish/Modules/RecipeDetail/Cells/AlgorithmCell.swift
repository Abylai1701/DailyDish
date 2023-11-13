import UIKit

class AlgorithmCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .mintColor
        container.clipsToBounds = true
        return container
    }()
    lazy var totalTime: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.text = "Total Time"
        label.textColor = .orangeColor
        return label
    }()
    lazy var totalTimeValue: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.text = "31 min"
        label.textColor = .black
        return label
    }()
    lazy var ingredients: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.text = "Ingredients"
        label.textColor = .orangeColor
        return label
    }()
    lazy var ingredientsValue: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.text = "meat"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    lazy var steps: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.text = "Steps"
        label.textColor = .orangeColor
        return label
    }()
    lazy var stepsValue: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.text = "In a medium bowl, combine the shredded cabbage with 3 tablespoons of the taco"
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
        
        addSubviews(container)
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        container.addSubviews(totalTime,
                              totalTimeValue,
                              ingredients,
                              ingredientsValue,
                              steps,
                              stepsValue)
        
        totalTime.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        totalTimeValue.snp.makeConstraints { make in
            make.top.equalTo(totalTime.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
        }
        ingredients.snp.makeConstraints { make in
            make.top.equalTo(totalTimeValue.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(8)
        }
        ingredientsValue.snp.makeConstraints { make in
            make.top.equalTo(ingredients.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
        }
        steps.snp.makeConstraints { make in
            make.top.equalTo(ingredientsValue.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(8)
        }
        stepsValue.snp.makeConstraints { make in
            make.top.equalTo(steps.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(model: RecipeModel?) {
        totalTimeValue.text = "\(model?.minutes ?? 0) minutes"

        let formattedIngredients = model?.ingredients.map { "· \($0)" }
        let ingredientsText = formattedIngredients?.joined(separator: "\n")
        ingredientsValue.text = ingredientsText
    }
}
