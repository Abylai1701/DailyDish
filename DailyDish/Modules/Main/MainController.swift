import UIKit

enum ProfileMenuType {
    case search
    case generate
    case collection
}

final class MainController: BaseController {
    
    //MARK: - Properties
    var sections: [[ProfileMenuType]] = [[.search] ,
                                         [.generate],
                                         [.collection]]
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero,
                                style: .grouped)
        table.register(SearchCell.self,
                       forCellReuseIdentifier: SearchCell.cellId)
        table.register(GenRecipeCell.self,
                       forCellReuseIdentifier: GenRecipeCell.cellId)
        table.register(PrevRecipesCollCell.self,
                       forCellReuseIdentifier: PrevRecipesCollCell.cellId)
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        return table
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true,
                                                     animated: true)
    }
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubviews(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    //MARK: - Functions
}
//MARK: - TableView Delegate
extension MainController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section][indexPath.row]
        switch model{
        case .search:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.cellId,
                                                     for: indexPath) as! SearchCell
            cell.searchPage = {
                let vc = SearchRecipesVC()
                Router.shared.push(vc)
            }
            return cell
        case .generate:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenRecipeCell.cellId,
                                                     for: indexPath) as! GenRecipeCell
            cell.generateAction = {
                let vc = GenerationAnimationVC()
                Router.shared.push(vc)
            }
            return cell
        case .collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: PrevRecipesCollCell.cellId,
                                                     for: indexPath) as! PrevRecipesCollCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]
        for item in section {
            switch item {
            case .search:
                return nil
            case .generate:
                return nil
            case .collection:
                let view = SectionHeaderView(title: "Previouslt generated items")
                return view
            }
        }
        return nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
