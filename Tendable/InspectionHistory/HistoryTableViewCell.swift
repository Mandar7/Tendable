//
//  HistoryTableViewCell.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 04/07/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(idLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(areaLabel)
        contentView.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            typeLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            areaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            areaLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            areaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            scoreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            scoreLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 5),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

