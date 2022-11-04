import Foundation

struct UserInfoModel {
    var firstName = ""
    var secondName = ""
    var thirdName = ""
    var birthday = ""
    var gender = ""
    
    static func == (_ firstModel: UserInfoModel, _ secondModel: UserInfoModel) -> Bool {
        firstModel.firstName == secondModel.firstName &&
        firstModel.secondName == secondModel.secondName &&
        firstModel.thirdName == secondModel.thirdName &&
        firstModel.birthday == secondModel.birthday &&
        firstModel.gender == secondModel.gender
    }
}
