import UIKit

final class MainTableViewController: UITableViewController {
    
    private var userInfo = UserInfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        getUserModel()
        
        tableView.register(MainTableViewCell.self)
        
    }
    
    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать",
                                         style: .plain,
                                         target: self,
                                         action: #selector(editingPressed))
    }
    
    private func getUserModel() {
        userInfo = UserDefaultsManager.getUserInfoModel()
    }
    
    private func saveEditedUserInfo(save model: UserInfoModel) {
        UserDefaultsManager.saveUserValue(Resources.UserInfoFields.firstName.rawValue, model.firstName)
        UserDefaultsManager.saveUserValue(Resources.UserInfoFields.secondName.rawValue, model.secondName)
        UserDefaultsManager.saveUserValue(Resources.UserInfoFields.thirdName.rawValue, model.thirdName)
        UserDefaultsManager.saveUserValue(Resources.UserInfoFields.birthday.rawValue, model.birthday)
        UserDefaultsManager.saveUserValue(Resources.UserInfoFields.gender.rawValue, model.gender)
    }
    
    internal func changeUserInfo(model: UserInfoModel) {
        saveEditedUserInfo(save: model)
        userInfo = model
        tableView.reloadData()
    }
    
    @objc private func editingPressed() {
        let editingTableViewController = EditingViewController(userInfo)
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension MainTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Resources.UserInfoFields.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(MainTableViewCell.self) else {
            return UITableViewCell()
        }
        
        let fieldName = Resources.UserInfoFields.allCases[indexPath.row].rawValue
        let value = UserDefaultsManager.getUserInfoValue(fieldName)

        cell.cellConfigure(name: fieldName, value: value)
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

