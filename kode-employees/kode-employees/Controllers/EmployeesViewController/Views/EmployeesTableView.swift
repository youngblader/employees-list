//
//  EmployeesTableView.swift
//  kode-employees
//
//  Created by Евгений Зорич on 5.03.24.
//

import UIKit

private enum EmoloyeesSections: Int, CaseIterable {
    case employees
}

final class EmployeesTableView: UITableView {
    private var employees: [Employee] = []

    var onCellTapped: ((Employee)->())?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        
        self.delegate = self
        self.dataSource = self
        
        self.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        
        self.separatorStyle = .none
//        self.allowsSelection = false
        self.showsVerticalScrollIndicator = false
        
        self.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public update
    func update(_ employees: [Employee]) {
        self.employees = employees
        self.reloadData()
    }
}

extension EmployeesTableView: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employee = employees[indexPath.row]
        
        onCellTapped?(employee)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return EmoloyeesSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = EmoloyeesSections.init(rawValue: section)
        
        switch section {
        case .employees:
            return employees.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = EmoloyeesSections.init(rawValue: indexPath.section)
        
        switch section {
        case .employees:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.reuseId, for: indexPath) as! EmployeeCell
            
            let employee = employees[indexPath.row]
            
            cell.update(employee)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
