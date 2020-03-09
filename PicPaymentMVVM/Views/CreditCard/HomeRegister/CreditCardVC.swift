//
//  CreditCardVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class CreditCardVC: UIViewController {
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(contact: Contact?) {
        self.contact = contact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func actionRegisterCreditCard(_ sender: Any) {
        guard let contact = self.contact else { return }
        let vc = RegisterCreditCardVC()
//        let vc = RegisterCreditCardFormViewController(contact: contact, state: .edit)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
