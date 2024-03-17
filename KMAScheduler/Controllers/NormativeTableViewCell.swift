//
//  NormativeTableViewCell.swift
//  KMAScheduler
//
//  Created by Анастасія Грисюк on 12.01.2024.
//

import UIKit

class NormativeTableViewCell: UITableViewCell {

    static let identifier = "Normative"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkBlue
        label.textAlignment = .left
        label.font = UIFont(name: "ProbaPro-Medium", size: 24)
        label.text = "Нормативні"
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
        self.contentView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            myLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            myLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
