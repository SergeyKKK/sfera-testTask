//
//  CustomCell.swift
//  alefTZ
//
//  Created by Serega Kushnarev on 29.05.2021.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let cellIdentifier = "cell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.frame = CGRect(x: 10, y: 10, width: 150, height: 30)
        return label
    }()
    
    var ageLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20)
        label.frame = CGRect(x: 200, y: 10, width: 50, height: 30)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
