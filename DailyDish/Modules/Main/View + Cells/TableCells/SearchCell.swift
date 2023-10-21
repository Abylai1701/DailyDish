import UIKit

class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var nameField: BaseTextField = {
        let field = BaseTextField()
        field.rightImage.isHidden = true
        field.actionButton.isHidden = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Search recipes",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayColor]
        )
        field.layer.masksToBounds = true
        field.delegate = self
        field.layer.borderColor = UIColor.grayColor.cgColor
        field.layer.cornerRadius = 4
        field.layer.borderWidth = 1
        return field
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
        addSubviews(nameField)
        nameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        
    }
    
//    func configure(model: GoalModel) {
//        titleLabel.text = model.name
//        let progress = Int((model.currentSeries * 100)/model.iterationCount)
//        progressView.progress = Float(progress) * 0.01
//        countLabel.text = "\(model.iterationCount)/\(model.currentSeries)"
//    }
}

extension SearchCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
