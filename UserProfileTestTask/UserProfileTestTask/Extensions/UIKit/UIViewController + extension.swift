import UIKit

extension UIViewController {
    
    func prestntSimpleAllert(title: String, message: String) {
        
        let allertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        allertController.addAction(okButton)
        
        present(allertController, animated: true)
    }
    
    func presentChangeAlert(completionHandler: @escaping(Bool) -> Void) {
        
        let allertController = UIAlertController(title: "Данные были изменены",
                                                 message: "Вы желаете сохранить изменения, в противном случае внесенные правки будут отменены",
                                                 preferredStyle: .alert)
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            completionHandler(true)
        }
        
        let skipButton = UIAlertAction(title: "Пропустить", style: .default) { _ in
            completionHandler(false)
        }
        
        allertController.addAction(saveButton)
        allertController.addAction(skipButton)
        
        present(allertController, animated: true)
    }
}
