//
//  SearchBar.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit
 
final class SearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.searchBarStyle = .minimal
        self.showsCancelButton = false
        
        self.delegate = self
        
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBar: UISearchBarDelegate {
    func setupSearchBar() {
        self.setImage(UIImage(named: "searchLight"), for: .search, state: .normal)
        self.showsBookmarkButton = true
        self.placeholder = "Введи имя, тег, почту..."
    }
}
