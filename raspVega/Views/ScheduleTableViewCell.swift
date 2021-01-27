//
//  ScheduleTableViewCell.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 24.11.2020.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        return label
    }()
    
    let numberOfPairLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        return label
    }()
    
    let beginningTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        label.textColor = .systemGray
        return label
    }()
    
    let endingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        label.textColor = .systemGray
        return label
    }()
    
    let typeOfPairLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        label.textColor = .systemGray
        return label
    }()
    
    let classroomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.text = ""
        return label
    }()
    
//    let teacherNameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 17)
//        label.numberOfLines = 2
//        label.textAlignment = .natural
//        label.text = ""
//        return label
//    }()
//    
    
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberOfPairLabel)
        contentView.addSubview(beginningTimeLabel)
        contentView.addSubview(endingTimeLabel)
        contentView.addSubview(typeOfPairLabel)
        contentView.addSubview(classroomLabel)
   
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfPairLabel.translatesAutoresizingMaskIntoConstraints = false
        beginningTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeOfPairLabel.translatesAutoresizingMaskIntoConstraints = false
        classroomLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            numberOfPairLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberOfPairLabel.centerXAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            beginningTimeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            beginningTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            
            endingTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            endingTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 9),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            
            typeOfPairLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            typeOfPairLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            
            classroomLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            classroomLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
                                        
            
        
        ])
        
        accessoryType = .disclosureIndicator
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
