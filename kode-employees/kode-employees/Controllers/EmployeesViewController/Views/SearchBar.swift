//
//  SearchBar.swift
//  kode-employees
//
//  Created by Евгений Зорич on 6.03.24.
//

import UIKit

final class SearchBar: UISearchBar {
    var onFilterButtonTapped: (()->())?
    var onSearchTextChanged: ((String)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSearchBar()
        setupTextField()
        setupCancelButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Setup
private extension SearchBar {
    func setupSearchBar() {
        self.searchBarStyle = .minimal
        self.delegate = self
        
        self.setImage(UIImage(named: "search-light"), for: .search, state: .normal)
        self.setImage(UIImage(named: "filter"), for: .bookmark, state: .normal)
        self.setImage(UIImage(named: "clear"), for: .clear, state: .normal)
        
        self.showsBookmarkButton = true
    }
    
    func setupTextField() {
        self.searchTextField.attributedPlaceholder = NSAttributedString(string: "Введи имя, тег, почту...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderGray])
        
        self.searchTextField.layer.cornerRadius = 16
        
        self.searchTextField.clipsToBounds = true
        self.searchTextField.textColor = .black
        self.searchTextField.backgroundColor = .backgroundLightGray
    }
    
    func setupCancelButton() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.primary,
            .font: UIFont(name: "Inter-SemiBold", size: 14)]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
    }
}

//MARK: Delegate methods
extension SearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.setImage(UIImage(named: "search-dark"), for: .search, state: .normal)
        self.setShowsCancelButton(true, animated: true)
        
        onSearchTextChanged?(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(true, animated: true)
        
        self.setImage(UIImage(named: "search-dark"), for: .search, state: .normal)
        self.showsBookmarkButton = false
        self.placeholder = ""
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor.primary
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(false, animated: true)
        
        self.setImage(UIImage(named: "search-light"), for: .search, state: .normal)
        self.showsBookmarkButton = true
        self.placeholder = "Введи имя, тег, почту..."
        
        self.text = ""
        self.resignFirstResponder()
        
        onSearchTextChanged?("")
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        self.onFilterButtonTapped?()
    }
}
