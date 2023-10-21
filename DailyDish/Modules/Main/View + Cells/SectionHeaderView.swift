import UIKit

class SectionHeaderView: UIView {
    
    //MARK: - Properties
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = .montserratRegular(ofSize: 18)
        return label
    }()
    lazy var seeAllButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "See all", attributes: [
            .font: UIFont.montserratRegular(ofSize: 16),
            .foregroundColor: UIColor.black
        ])
        attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedTitle.length))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()

    
    //MARK: - Init
    init(title: String?) {
        super.init(frame: .zero)
        
        backgroundColor = .clear
        
        addSubviews(titleLabel, seeAllButton)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
        }
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(titleLabel)
        }
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
