import UIKit

final class EditingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: TextViewTableViewCell.idTextViewTableViewCell)
    }
    
    private func setupViews() {
        title = "Редактирование"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                         style: .plain,
                                         target: self,
                                         action: #selector(savingPressed))
    }
    
    @objc private func savingPressed() {
        print("savingPressed")
    }
}

//MARK: - UITableViewDataSource

extension EditingTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.UserInfoFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.idTextViewTableViewCell, for: indexPath) as? TextViewTableViewCell else {
            return UITableViewCell()
        }
        
        let fieldName = Resources.UserInfoFields.allCases[indexPath.row].rawValue

        cell.cellConfigure(name: fieldName)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension EditingTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

//MARK: - setConstraints

extension EditingTableViewController {
    private func setConstraints() {
        
    }
}
