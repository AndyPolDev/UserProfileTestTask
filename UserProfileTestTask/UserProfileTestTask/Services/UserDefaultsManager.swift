import UIKit

final class UserDefaultsManager {
    
    private static let defaults = UserDefaults.standard
    private static let userSessionKey = "userKey"
    
    static func getUserDictionary() -> [String : String] {
        defaults.value(forKey: userSessionKey) as? [String : String] ?? [:]
    }
    
    static func saveUserValue(_ key: String, _ value: String) {
        var userDictionary = getUserDictionary()
        userDictionary[key] = value
        defaults.set(userDictionary, forKey: userSessionKey)
    }
    
    static func getUserInfoModel() -> UserInfoModel {
        var userInfoModel = UserInfoModel()
        
        let userDictionary = getUserDictionary()
        userInfoModel.firstName = userDictionary[Resources.UserInfoFields.firstName.rawValue] ?? ""
        userInfoModel.secondName = userDictionary[Resources.UserInfoFields.secondName.rawValue] ?? ""
        userInfoModel.thirdName = userDictionary[Resources.UserInfoFields.thirdName.rawValue] ?? ""
        userInfoModel.birthday = userDictionary[Resources.UserInfoFields.birthday.rawValue] ?? ""
        userInfoModel.gender = userDictionary[Resources.UserInfoFields.gender.rawValue] ?? ""
        
        return userInfoModel
    }
    
    static func getUserInfoValue(_ key: String) -> String {
        let userDictionary = getUserDictionary()
        let stringValue = userDictionary[key] ?? ""
        
        return stringValue
    }
    
    static func saveUserImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        defaults.set(data, forKey: "userPhoto")
    }
    
    static func loadUserImage() -> UIImage {
        guard let data = defaults.data(forKey: "userPhoto"),
              let image = UIImage(data: data) else {
            return UIImage() }
        return image
    }
}
