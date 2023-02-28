//
//  TableViewCell.swift
//  PreOnboarding
//
//  Created by Muker on 2023/02/27.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    lazy var progressBar: UIProgressView = {
        let bar = UIProgressView()
        bar.progress = 0.5
        return bar
    }()
    
    let loadButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("Load", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.tintColor = .yellow
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        return bt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setCell()
    }
    
    func setCell() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        image.heightAnchor.constraint(equalToConstant: 95).isActive = true
        image.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        addSubview(loadButton)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        loadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        loadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        loadButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loadButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 5).isActive = true
        progressBar.trailingAnchor.constraint(equalTo: self.loadButton.leadingAnchor, constant: -5).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

