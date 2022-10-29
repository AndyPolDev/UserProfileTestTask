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
        print(userInfo)
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
        view.addView(editingTableView)
    }
    
    private func authFields() -> Bool {
        if userInfo.firstName != "" ||
            userInfo.secondName != "" ||
            userInfo.birthday != "" ||
            userInfo.gender != "" ||
            userInfo.birthday != "Не указано" {
            return true
        }
        return false
    }
    
    @objc private func saveButtonPressed() {
        if authFields() {
            prestntSimpleAllert(title: "Готово", message: "Все обязательные поля заполнены")
        } else {
            prestntSimpleAllert(title: "Ошибка", message: "Заполните поля ФИ, дата рождения и пол")
        }
    }
    
    @objc private func backBarButtonItemPressed() {
        presentChangeAlert { changed in
            if changed {
                print(self.userInfo)
                self.navigationController?.popViewController(animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
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
