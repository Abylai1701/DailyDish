import UIKit

enum ReceptInfo {
    case description
    case cook
}

class RecipeDetailVC: UIViewController {
    
    //MARK: - Properties
    private let viewModel: RecipeDetailViewModelLogic = RecipeDetailViewModel()
    var backButtonAction: (() -> Void)?
    
    private var recipeModel: RecipeModel? = nil
    private var sections: [[ReceptInfo]] = [[.description],
                                            [.cook]]
    private var id: Int
    
    lazy var backButton: UIButton = {
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
        label.font = .montserratSemiBold(ofSize: 14)
        label.text = "Back"
        label.textColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.register(InfoCell.self,
                       forCellReuseIdentifier: InfoCell.cellId)
        table.register(AlgorithmCell.self,
                       forCellReuseIdentifier: AlgorithmCell.cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    // MARK: - Init
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchRecipeDetail(id: self.id)
    }
    func bind() {
        viewModel.randomRecipe.observe(on: self) { recipe in
            self.recipeModel = recipe
            self.tableView.reloadData()
        }
    }
    //MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(tableView,
                         backButton,
                         backTitle)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.right.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }
        backTitle.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right)
            make.top.equalToSuperview().offset(68)
        }
    }
    @objc func tapBack() {
        backButtonAction?() ?? Router.shared.pop()
    }
}


//MARK: - TableView Delegate

extension RecipeDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {1}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section][indexPath.row] {
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.cellId, for: indexPath) as! InfoCell
            cell.selectionStyle = .none
            cell.configure(model: recipeModel)
            return cell
            
        case .cook:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlgorithmCell.cellId, for: indexPath) as! AlgorithmCell
            cell.selectionStyle = .none
            cell.configure(model: recipeModel)
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
