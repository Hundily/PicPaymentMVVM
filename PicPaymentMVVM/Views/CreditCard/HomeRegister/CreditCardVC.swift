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
    var delegate: UpdateCreditCard?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.setNavigationBarHidden(true, animated: animated)
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

        let registerCreditCardVC = RegisterCreditCardVC(.register, nil, contact)
        registerCreditCardVC.delegate = self.delegate
        navigationController?.pushViewController(registerCreditCardVC, animated: true)
    }
    
}
