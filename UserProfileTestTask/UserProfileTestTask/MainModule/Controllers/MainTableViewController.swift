import UIKit

final class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.idMainTableViewCell)
    }
    
    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать",
                                         style: .plain,
                                         target: self,
                                         action: #selector(editingPressed))
    }
    
    @objc private func editingPressed() {
        let editingTableViewController = EditingViewController()
        navigationItem.backButtonTitle = "Назад"
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension MainTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.UserInfoFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.idMainTableViewCell, for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        let fieldName = Resources.UserInfoFields.allCases[indexPath.row].rawValue

        cell.cellConfigure(name: fieldName)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

//MARK: - setConstraints

extension MainTableViewController {
    private func setConstraints() {
        
    }
}
