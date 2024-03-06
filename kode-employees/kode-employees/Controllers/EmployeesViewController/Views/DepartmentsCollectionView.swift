//
//  DepartmentsCollectionView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class DepartmentsCollectionView: UICollectionView {
    private var departments: [Department] = []
    
    var onCellTapped: ((Department)->())?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.showsHorizontalScrollIndicator = false
        self.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.delegate = self
        self.dataSource = self
        
        self.allowsMultipleSelection = false
        
        self.register(DepartmentCell.self, forCellWithReuseIdentifier: DepartmentCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ departments: [Department], _ isFirstUpdate: Bool = false) {
        self.departments = departments
        self.reloadData()
        
        self.selectItem(at: [0,0], animated: false, scrollPosition: .top)
    }
    
    private func selectItem(_ indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        self.selectItem(at: [0, indexPath.row], animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension DepartmentsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let department = departments[indexPath.row]
        
        onCellTapped?(department)
        selectItem(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartmentCell.reuseId, for: indexPath) as! DepartmentCell
        
        let item = departments[indexPath.row]
        
        cell.update(item.title)
        
        return cell
    }
}
