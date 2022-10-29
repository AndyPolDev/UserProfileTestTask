import UIKit

final class EditingTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(TextViewTableViewCell.self, forCellReuseIdentifier: TextViewTableViewCell.idTextViewTableViewCell)
        register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.idDatePickerTableViewCell)
        register(PickerViewTableViewCell.self, forCellReuseIdentifier: PickerViewTableViewCell.idPickerViewTableViewCell)
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableViewDataSource

extension EditingTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.UserInfoFields.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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

//MARK: - EditingTableView

extension EditingTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

//MARK: - NameTextViewProtocol

extension EditingTableView: NameTextViewProtocol {
    func changeSize() {
        beginUpdates()
        endUpdates()
    }
}

//MARK: - setConstraints

extension EditingTableView {
    private func setConstraints() {
        
    }
}
