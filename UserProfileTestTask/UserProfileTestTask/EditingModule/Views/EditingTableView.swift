import UIKit

final class EditingTableView: UITableView {
    
    private var userInfo = UserInfoModel()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
                
        register(TextViewTableViewCell.self)
        register(DatePickerTableViewCell.self)
        register(PickerViewTableViewCell.self)
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setUserModel(_ model: UserInfoModel) {
        userInfo = model
    }
    
    internal func editUserInfoModel() {
        guard let firstNameCell = self.cellForRow(at: [0, 0]) as? TextViewTableViewCell,
              let secondNameCell = self.cellForRow(at: [0, 1]) as? TextViewTableViewCell,
              let thirdNameCell = self.cellForRow(at: [0, 2]) as? TextViewTableViewCell,
              let birthdayCell = self.cellForRow(at: [0, 3]) as? DatePickerTableViewCell,
              let genderCell = self.cellForRow(at: [0, 4]) as? PickerViewTableViewCell else {
            return
        }
        
        userInfo.firstName = firstNameCell.getCellValue()
        userInfo.secondName = secondNameCell.getCellValue()
        userInfo.thirdName = thirdNameCell.getCellValue() == "Введите данные" ? "" : thirdNameCell.getCellValue()
        userInfo.birthday = birthdayCell.getCellValue()
        userInfo.gender = genderCell.getCellValue()
    }
    
    internal func getUserInfo() -> UserInfoModel {
        editUserInfoModel()
        return userInfo
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
            guard let cell = self.dequeueReusableCell(TextViewTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.nameTextViewDelegate = self
            
            switch indexPath.row {
            case 0: cell.cellConfigure(name: fieldName, scrollEnable: false, value: userInfo.firstName)
            case 1: cell.cellConfigure(name: fieldName, scrollEnable: false, value: userInfo.secondName)
            default: cell.cellConfigure(name: fieldName, scrollEnable: false, value: userInfo.thirdName)
            }
            
            return cell
            
        case 3:
            guard let cell = self.dequeueReusableCell(DatePickerTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.cellConfigure(name: fieldName, date: userInfo.birthday.getDateFromString())
            
            return cell
            
        case 4:
            guard let cell = self.dequeueReusableCell(PickerViewTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.cellConfigure(name: fieldName, value: userInfo.gender)
            
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
