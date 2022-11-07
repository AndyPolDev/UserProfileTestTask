import UIKit

enum Resources {
    
    enum UserInfoFields: String, CaseIterable {
        case firstName = "Имя"
        case secondName = "Фамилия"
        case thirdName = "Отчество"
        case birthday = "Дата рождения"
        case gender = "Пол"
    }
    
    enum Gender: String, CaseIterable {
        case noSpecified = "Не указано"
        case male = "Мужской"
        case female = "Женский"
    }
    
    enum Fonts {
        static func avenirNextRegular(with size: CGFloat) -> UIFont? {
            UIFont(name: "Avenir next", size: size)
        }
    }
}
