//
//  ProfessionalTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 17.03.2024.
//

import UIKit

class ProfessionalTableViewCell: UITableViewCell {

    static let identifier = "Professional"
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "ProbaPro-Medium", size: 24)
        label.text = "Професійно-орієнтовані"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.backgroundColor = UIColor.backgroundBlue
        
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    

}
