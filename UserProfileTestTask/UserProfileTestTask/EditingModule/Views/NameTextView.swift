import UIKit

final class NameTextView: UITextView {
    
    override init(frame: CGRect, textContainer:NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Введите данные"
        textColor = .lightGray
        textAlignment = .right
        font = Resources.Fonts.avenirNextRegular(with: 18)
    }
}
