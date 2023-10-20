import UIKit

class SearchCell: UITableViewCell {
    
    //MARK: - Properties
    private lazy var nameField: BaseTextField = {
        let field = BaseTextField()
//        let space = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
//        field.leftView = space
//        field.leftViewMode = .always
        field.rightImage.isHidden = true
        field.actionButton.isHidden = true
        field.attributedPlaceholder = NSAttributedString(
            string: "Search recipes",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayColor]
        )
        field.layer.masksToBounds = true
        field.delegate = self
        field.layer.borderColor = UIColor.grayColor.cgColor
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
        if textField.tag != 3 { return true }
        let text = textField.text!
        let spaceIndex = [2, 7, 12, 15]
        
        if text == "+7" && string == "" { return false }
        if text.count == 18 && string != "" { return false }
        if spaceIndex.contains(textField.text!.count) && string != "" {
            if textField.text!.count == 2 {
                textField.text!.append(" (")
            }
            else if textField.text!.count == 7{
                textField.text!.append(") ")
            }
            else if textField.text!.count == 12 {
                textField.text!.append("-")
            }
            else if textField.text!.count == 15 {
                textField.text!.append("-")
            }
            else {
                textField.text!.append(" ")
            }
        }
        return true
    }
}
