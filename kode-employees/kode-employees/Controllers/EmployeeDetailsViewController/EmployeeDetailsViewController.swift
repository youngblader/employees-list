//
//  EmployeeDetailsViewController.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit
import SnapKit

final class EmployeeDetailsViewController: UIViewController {
    private let provider: EmployeeDetailsProvider
    private let employee: Employee
    
    // MARK: - LoadView
    private var employeeDetailsView: EmployeeDetailsView {
        return self.view as! EmployeeDetailsView
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        self.view = EmployeeDetailsView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        employeeDetailsView.update(employee)
        employeeDetailsView.employeeContainerView.onPhoneViewTapped = { [weak self] in
            self?.didInfoPhoneViewTapped()
        }
    }
    
    //MARK: - Init
    init(provider: EmployeeDetailsProvider, employee: Employee) {
        self.provider = provider
        self.employee = employee
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeAPhoneCall(_ phone: String) {
        provider.callService.call(phone)
    }
    
    deinit {
        print("deinited")
    }
    
    private func didInfoPhoneViewTapped() {
        guard let employeePhone = employee.phone else { return }
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        let callAction = UIAlertAction(title: "\(employeePhone)", style: .default) { _ in
            self.makeAPhoneCall(employeePhone)
        }
        
        [callAction, cancelAction].forEach({ alert.addAction($0) })
        [callAction, cancelAction].forEach({ $0.setValue(UIColor.alertBlack, forKey: "titleTextColor") })
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @objc private func didBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

private extension EmployeeDetailsViewController {
    func setup() {
        let arrowBackButton = UIBarButtonItem(image: UIImage(named: "shevron"), style: .plain, target: self, action: #selector(didBackButtonTapped))
        
        arrowBackButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = arrowBackButton
    }
}
