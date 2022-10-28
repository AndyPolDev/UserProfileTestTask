import UIKit

final class EditingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: TextViewTableViewCell.idTextViewTableViewCell)
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.idDatePickerTableViewCell)
        tableView.register(PickerViewTableViewCell.self, forCellReuseIdentifier: PickerViewTableViewCell.idPickerViewTableViewCell)
        
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
        
        let fieldName = Resources.UserInfoFields.allCases[indexPath.row].rawValue
        
        switch indexPath.row {
        case 0...2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextViewTableViewCell.idTextViewTableViewCell, for: indexPath) as? TextViewTableViewCell else {
                return UITableViewCell()
            }
            cell.nameTextViewDelegate = self
            
            if indexPath.row == 1 {
                cell.cellConfigure(name: fieldName, scrollEnable: false)
            } else {
                cell.cellConfigure(name: fieldName, scrollEnable: true)
            }
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.idDatePickerTableViewCell, for: indexPath) as? DatePickerTableViewCell else {
                return UITableViewCell()
            }
            cell.cellConfigure(name: fieldName)
            
            return cell
            
        case 4:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PickerViewTableViewCell.idPickerViewTableViewCell, for: indexPath) as? PickerViewTableViewCell else {
                return UITableViewCell()
            }
            cell.cellConfigure(name: fieldName)
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate

extension EditingTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

//MARK: - NameTextViewProtocol

extension EditingTableViewController: NameTextViewProtocol {
    func changeSize() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

//MARK: - setConstraints

extension EditingTableViewController {
    private func setConstraints() {
        
    }
}
