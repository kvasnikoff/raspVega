//
//  GroupChangeTableViewCell.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 24.11.2020.
//

import UIKit

class GroupChangeTableViewCell: UITableViewCell {
    
    let groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = "📘 Изменить группу"
        return label
    }()
    


    
    
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(groupLabel)
        
        
        accessoryType = .disclosureIndicator
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
