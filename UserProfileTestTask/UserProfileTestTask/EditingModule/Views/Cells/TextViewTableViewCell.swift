import UIKit

protocol NameTextViewProtocol: AnyObject {
    func changeSize()
}

final class TextViewTableViewCell: UITableViewCell {
    
    static let idTextViewTableViewCell = "idTextViewTableViewCell"
    
    weak var nameTextViewDelegate: NameTextViewProtocol?
    
    private let nameLabel = UILabel()
    private let nameTextView = NameTextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
        setDelegates()
        textViewDidChange(nameTextView)
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        nameLabel.font = Resources.Fonts.avenirNextRegular(with: 18)
        addView(nameLabel)
        contentView.addView(nameTextView)
    }
    
    private func setDelegates() {
        nameTextView.delegate = self
    }
    
    internal func cellConfigure(name: String, scrollEnable: Bool) {
        nameLabel.text = name
        nameTextView.isScrollEnabled = scrollEnable
    }
}

//MARK: - UITextViewDelegate

extension TextViewTableViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        contentView.heightAnchor.constraint(equalTo: nameTextView.heightAnchor, multiplier: 1).isActive = true
        nameTextViewDelegate?.changeSize()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите данные"
            textView.textColor = .lightGray
        }
    }
}

//MARK: - setConstraints

extension TextViewTableViewCell {
    private func setConstraints() {
        //        NSLayoutConstraint.activate([
        //            heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
        //        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameTextView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            //nameTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
}
