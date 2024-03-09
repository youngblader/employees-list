//
//  EmployeesSortViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 7.03.24.
//

import UIKit
import SnapKit

enum SortType {
    case alphabet
    case birthday
}

protocol SortDelegate: AnyObject {
    func sortTypeChanged(_ sortType: SortType)
}

final class EmployeesSortViewController: UIViewController {
    private var sortType: SortType
    weak var sortDelegate: SortDelegate?
    
    // MARK: - LoadView
    private var employeesSortingView: EmployeesSortView {
        return self.view as! EmployeesSortView
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = EmployeesSortView(sortType: sortType)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        
        employeesSortingView.onAlphabetButtonTapped = {
            self.sortDelegate?.sortTypeChanged(.alphabet)
            self.didBackButtonTapped()
        }
        
        employeesSortingView.onBirthdayButtonTapped = {
            self.sortDelegate?.sortTypeChanged(.birthday)
            self.didBackButtonTapped()
        }
    }
    
    //MARK: - Init
    init(sortType: SortType) {
        self.sortType = sortType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc private func didBackButtonTapped() {
        dismiss(animated: true)
    }
}

private extension EmployeesSortViewController {
    func setup() {
        self.title = "Сортировка"
        
        let arrowBackButton = UIBarButtonItem(image: UIImage(named: "shevron"), style: .plain, target: self, action: #selector(didBackButtonTapped))
        
        arrowBackButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = arrowBackButton
    }
    
    func setupNavigationBar() {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Inter-SemiBold", size: 20)!,
            .foregroundColor: UIColor.black
        ]
        
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
