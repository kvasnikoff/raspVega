//
//  GroupTableViewCell.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 24.11.2020.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = "Выбранная группа:"
        return label
    }()
    
    let selectedGroupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        return label
    }()

    
    
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [groupLabel, selectedGroupLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            
        ])
        
        
        accessoryType = .disclosureIndicator
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
