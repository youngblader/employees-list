//
//  CallService.swift
//  kode-employees
//
//  Created by Евгений Зорич on 7.03.24.
//

import UIKit

protocol CallService {
    func call(_ phone: String)
}

final class CallServiceImpl: CallService {
    func call(_ phone: String) {
        guard let url = URL(string: "tel://\(phone)") else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Failed to make a call")
        }
    }
}
