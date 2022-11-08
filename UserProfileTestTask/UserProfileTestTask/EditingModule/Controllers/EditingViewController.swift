import UIKit

final class EditingViewController: UIViewController {
    
    private let editingTableView = EditingTableView()
    private var userInfo = UserInfoModel()
    
    init(_ userInfo: UserInfoModel) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        title = "Редактирование"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveButtonPressed))
        let backBarButtonItem = UIBarButtonItem.createCustomButton(viewController: self, selector: #selector(backBarButtonItemPressed))
        navigationItem.leftBarButtonItem = backBarButtonItem
        editingTableView.setUserModel(userInfo)
        view.addView(editingTableView)
    }
    
    private func authFields(model: UserInfoModel) -> Bool {
        if model.firstName == "Введите данные" ||
            model.secondName == "Введите данные" ||
            model.birthday == "" ||
            model.gender == "" ||
            model.gender == "Не указано" {
            return false
        }
        return true
    }

    @objc private func saveButtonPressed() {
        
        let editedUserInfo = editingTableView.getUserInfo()
        if authFields(model: editedUserInfo) {
            prestntSimpleAllert(title: "Готово", message: "Все обязательные поля заполнены")
        } else {
            prestntSimpleAllert(title: "Ошибка", message: "Заполните поля ФИ, дата рождения и пол")
        }
    }
    
    @objc private func backBarButtonItemPressed() {
        
        let editedUserInfo = editingTableView.getUserInfo()
        
        if editedUserInfo == userInfo {
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert {[weak self] changed in
                guard let self = self else { return }
                if changed {
                    guard let mainTableViewController = self.navigationController?.viewControllers.first as? MainViewController else {
                        return
                    }
                    mainTableViewController.changeUserInfo(model: editedUserInfo)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

//MARK: - setConstraints

extension EditingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
