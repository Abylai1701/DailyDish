import UIKit

final class SearchRecipesVC: BaseController {
    
    //MARK: - Properties
    private let viewModel: SearchRecipesVIewModelLogic = SearchRecipesVIewModel()
    private var recipes: [RandomRecipe] = []
    var searchTimer: Timer?
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.layer.masksToBounds = false
        button.addTarget(self,
                         action: #selector(tapBack),
                         for: .touchUpInside)
        return button
    }()
    lazy var backTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 18)
        label.text = "Search Recipes"
        label.textColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
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
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.register(RecipeCell.self,
                       forCellReuseIdentifier: RecipeCell.cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func bind() {
        viewModel.recipes.observe(on: self) { recipes in
            self.recipes = recipes
            
            self.tableView.reloadData()
        }
    }
    //MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(backButton,
                         backTitle,
                         nameField,
                         tableView)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }
        backTitle.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right)
            make.top.equalToSuperview().offset(66)
        }
        nameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.top.equalTo(backButton.snp.bottom).offset(25)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(16)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


//MARK: - TableView Delegate

extension SearchRecipesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {1}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.cellId, for: indexPath) as! RecipeCell
        cell.selectionStyle = .none
        cell.configure(model: recipes[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = recipes[indexPath.section].id
        let vc = RecipeDetailVC(id: id, backToMain: false)
        Router.shared.push(vc)
    }
}
extension SearchRecipesVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.fetchRecipes(recipe: searchText)
            self.bind()
        }
        return true
    }
}

