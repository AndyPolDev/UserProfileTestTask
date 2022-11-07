import UIKit

final class GenderTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textAlignment = .right
        tintColor = .clear
        font = Resources.Fonts.avenirNextRegular(with: 18)
        let placeholderFont = Resources.Fonts.avenirNextRegular(with: 18)
        attributedPlaceholder = NSAttributedString(string: "Введите данные",
                                                   attributes: [.foregroundColor : UIColor.lightGray,
                                                                .font : placeholderFont  as Any])
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
}
