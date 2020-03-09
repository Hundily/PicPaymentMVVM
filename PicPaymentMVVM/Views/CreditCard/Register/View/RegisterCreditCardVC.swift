//
//  RegisterCreditCardVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterCreditCardVC: UIViewController {
    
    @IBOutlet weak var labelCardNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardName: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardExpired: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardCVV: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func actionRegisterCreditCard(_ sender: Any) {
        let creditCard = CreditCard(cardNumber: labelCardNumber.text ?? String.empty, cardName: labelCardName.text ?? String.empty, cardExpired: labelCardExpired.text ?? String.empty, cardCvv: labelCardCVV.text ?? String.empty)
        
        
        print(creditCard)
    }

}

extension RegisterCreditCardVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
