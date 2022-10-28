import UIKit

final class PickerViewTableViewCell: UITableViewCell {
    
    static let idPickerViewTableViewCell = "idPickerViewTableViewCell"
    
    private let nameLabel = UILabel()
    private let genderPickerView = GenderPickerView()
    private let genderTextField = GenderTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        nameLabel.font = Resources.Fonts.avenirNextRegular(with: 18)
        addView(nameLabel)
        
        genderTextField.inputView = genderPickerView
        contentView.addView(genderTextField)
    }
    
    private func setDelegates() {
        genderPickerView.genderDelegate = self
    }
    
    internal func cellConfigure(name: String) {
        nameLabel.text = name
    }
}

//MARK: - GenderPickerViewProtocol

extension PickerViewTableViewCell: GenderPickerViewProtocol {
    func didSelect(row: Int) {
        genderTextField.text = Resources.Gender.allCases[row].rawValue
        genderTextField.resignFirstResponder()
    }
}

//MARK: - setConstraints

extension PickerViewTableViewCell {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            genderTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            genderTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            genderTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            genderTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
