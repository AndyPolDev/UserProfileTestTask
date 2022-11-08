import UIKit
import PhotosUI

final class EditingViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let editingTableView = EditingTableView()
    private var userInfo = UserInfoModel()
    private var userPhotoIsChanged = false
    
    init(_ userInfo: UserInfoModel, userPhoto: UIImage?) {
        self.userInfo = userInfo
        self.userPhotoImageView.image = userPhoto
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addTapsToUserPhotoImageView()
    }
    
    override func viewWillLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
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
        view.addView(userPhotoImageView)
        editingTableView.setUserModel(userInfo)
        view.addView(editingTableView)
    }
    
    private func authFields(model: UserInfoModel) -> Bool {
        if model.firstName == "Введите данные" ||
            model.firstName == "" ||
            model.secondName == "Введите данные" ||
            model.secondName == "" ||
            model.birthday == "" ||
            model.gender == "" ||
            model.gender == "Не указано" {
            return false
        }
        return true
    }
    
    private func addTapsToUserPhotoImageView() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(userPhotoPressed))
        tapImageView.delegate = self
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func userPhotoPressed() {
        print("pressed")
        if #available(iOS 14.0, *) {
            presentPHPicker()
        } else {
            presentImagePicker()
        }
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
        
        if !authFields(model: editedUserInfo) {
            prestntSimpleAllert(title: "Ошибка", message: "Заполните поля ФИ, дата рождения и пол")
            return
        }
        
        if editedUserInfo == userInfo, userPhotoIsChanged == false {
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert {[weak self] changed in
                guard let self = self else { return }
                if changed {
                    guard let mainViewController = self.navigationController?.viewControllers.first as? MainViewController else {
                        return
                    }
                    mainViewController.changeUserInfo(model: editedUserInfo)
                    mainViewController.changeUserPhoto(image: self.userPhotoImageView.image)
                    
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

//MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension EditingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func presentImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        userPhotoImageView.image = image
        userPhotoIsChanged = true
        dismiss(animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate

@available(iOS 14.0, *)
extension EditingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.userPhotoImageView.image = image
                }
                self.userPhotoIsChanged = true
            }
        }
    }
    
    private func presentPHPicker() {
        var pHPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        pHPickerConfig.selectionLimit = 1
        pHPickerConfig.filter = PHPickerFilter.any(of: [.images])
        
        let pHPickerViewController  = PHPickerViewController(configuration: pHPickerConfig)
        pHPickerViewController.delegate = self
        present(pHPickerViewController, animated: true)
    }
}

//MARK: - UIGestureRecognizerDelegate

extension EditingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gr: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let bezierPath = UIBezierPath(roundedRect: userPhotoImageView.bounds, cornerRadius: userPhotoImageView.layer.cornerRadius)
        let point = touch.location(in: userPhotoImageView)
        return bezierPath.contains(point)
    }
}

//MARK: - setConstraints

extension EditingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            editingTableView.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 20),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
