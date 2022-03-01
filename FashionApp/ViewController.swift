//
//  ViewController.swift
//  FashionApp
//
//  Created by Azat Kaiumov on 22.02.2022.
//

import UIKit


class CustomCell: UICollectionViewCell {
    static let reuseIdentifier = "CustomCell"
    
    var labelView: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

extension CustomCell {
    func configure() {
        labelView = UILabel()
        labelView.text = "Stub"
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
        
        let inset = CGFloat(10)
        
        contentView.addSubview(labelView)
        
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.layer.borderWidth = 2
        
        labelView.textAlignment = .center

        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: inset),
            labelView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -inset),
            
            labelView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: inset),
            labelView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -inset)
        ])
    }
}

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var data: [Int] = []
    
    private var cellRegistration: UICollectionView.CellRegistration<CustomCell, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 0..<100 {
            data.append(index)
        }
        setupViews()
    }

    func setupViews() {
        cellRegistration = {
            UICollectionView.CellRegistration(
                handler: {
                    cell, indexPath, itemIdentifier in
                    
                    let item = self.data[itemIdentifier]
                    cell.labelView.text = "\(item)"
                }
            )
        } ()
        
        let layoutWithoutSpace = UICollectionViewFlowLayout()
        
        layoutWithoutSpace.scrollDirection = .vertical
        layoutWithoutSpace.minimumInteritemSpacing = 0
        layoutWithoutSpace.minimumLineSpacing = 0
        
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: createLayout()
        )
        
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        
        if row % 2 == 0 {
            return CGSize(width: 100, height: 100)
        }
        
        return CGSize(width: 150, height: 150)
    }
}

extension ViewController {
    func createLayout() -> UICollectionViewLayout {
        return CustomLayout()
    }
}
