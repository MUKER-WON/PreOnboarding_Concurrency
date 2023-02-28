//
//  ViewController.swift
//  PreOnboarding
//
//  Created by Muker on 2023/02/27.
//

import UIKit

var photoArr = ["1","2","3","4","5"]

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    lazy var loadAllButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Load All Images", for: .normal)
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 10
        bt.layer.masksToBounds = true
        bt.addTarget(self, action: #selector(getAllImage), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        view.addSubview(loadAllButton)
        loadAllButton.translatesAutoresizingMaskIntoConstraints = false
        loadAllButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10).isActive = true
        loadAllButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor).isActive = true
        loadAllButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor).isActive = true
        loadAllButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loadAllButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func getImage(_ index: UIButton) {
        guard let cell = index.superview as? TableViewCell else { return }
        if tableView.indexPath(for: cell) != nil {
            getImageWeb { image in
                guard let newImage = image else { return }
                DispatchQueue.main.async {
                    cell.image.image = newImage
                }
            }
        }
    }
    
    func getImageWeb(completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = URL(string: "https://picsum.photos/150/95") {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        } else {
            completion(nil)
        }
    }
    
    @objc func getAllImage() {
        let cells = self.tableView.visibleCells
        for i in cells {
            guard let cell = i as? TableViewCell else { continue }
            getImageWeb { image in
                guard let newImage = image else { return }
                DispatchQueue.main.async {
                    cell.image.image = newImage
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell()
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        cell.loadButton.tag = indexPath.row
        cell.loadButton.addTarget(self, action: #selector(getImage(_:)), for: .touchUpInside)
        return cell
    }
}
