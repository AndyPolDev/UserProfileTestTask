import UIKit

final class MainViewController: UIViewController {
    
    private let mainTableView = MainTableView()
    
    private var userInfo = UserInfoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        getUserModel()
        setValueArray()
        
    }
    
    private func setupViews() {
        title = "Просмотр"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Редактировать",
                                         style: .plain,
                                         target: self,
                                         action: #selector(editingPressed))
        view.addView(mainTableView)
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
    
    private func getValueArray() -> [String] {
        var valueArray = [String]()
        for key in Resources.UserInfoFields.allCases {
            let value = UserDefaultsManager.getUserInfoValue(key.rawValue)
            valueArray.append(value)
        }
        return valueArray
    }
    
    private func setValueArray() {
        let valueArray = getValueArray()
        mainTableView.setValueArray(valueArray)
        mainTableView.reloadData()
    }
    
    internal func changeUserInfo(model: UserInfoModel) {
        saveEditedUserInfo(save: model)
        userInfo = model
        mainTableView.reloadData()
    }
    
    @objc private func editingPressed() {
        let editingTableViewController = EditingViewController(userInfo)
        navigationController?.pushViewController(editingTableViewController, animated: true)
    }
}

//MARK: - setConstraints

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


