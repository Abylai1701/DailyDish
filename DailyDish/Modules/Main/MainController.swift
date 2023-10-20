import UIKit

final class MainController: BaseController {
    
    //MARK: - Properties
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(SearchCell.self,
                       forCellReuseIdentifier: SearchCell.cellId)
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
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchCell.cellId,
            for: indexPath) as! SearchCell

        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = GoalDetailVC(id: goals[indexPath.section].id)
//        vc.doneAction = {[weak self] in
//            guard let self = self else {return}
//            self.viewModel.doneGoal(id: self.goals[indexPath.section].id)
//        }
//        vc.deleteAction = {[weak self] in
//            guard let self = self else {return}
//            self.viewModel.removeGoal(id: self.goals[indexPath.section].id)
//        }
//        Router.shared.push(vc)
//    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0 }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
