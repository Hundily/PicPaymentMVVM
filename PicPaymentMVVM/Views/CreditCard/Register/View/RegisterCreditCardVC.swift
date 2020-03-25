//
//  RegisterCreditCardVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

enum RegisterCreditCardState {
    case edit
    case register
}

class RegisterCreditCardVC: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCardNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardName: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardExpired: SkyFloatingLabelTextField!
    @IBOutlet weak var labelCardCVV: SkyFloatingLabelTextField!
    @IBOutlet weak var buttonRegister: CustomButton!
    private var stateView = RegisterCreditCardState.register
    private var creditCard: CreditCard?
    private var contact: Contact?
    private var kRegisterCreditCardVC = "RegisterCreditCardVC"
    var delegate: UpdateCreditCard?

    var viewModel = CreditCardViewModel()

    init(_ state: RegisterCreditCardState,_ creditCard: CreditCard?,_ contact: Contact?) {
        super.init(nibName: kRegisterCreditCardVC, bundle: Bundle.main)
        self.stateView = state
        self.creditCard = creditCard
        self.contact = contact
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationLayout()
        setDelegate()
        setupUI()
    }

    private func setupNavigationLayout() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.title = String.empty
        navigationController?.navigationBar.tintColor = ColorName.green.color
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setDelegate() {
        viewModel.delegate = self
        labelCardNumber.delegate = self
        labelCardCVV.delegate = self
        labelCardExpired.delegate = self
        labelCardNumber.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
        labelCardExpired.addTarget(self, action: #selector(expirationDateDidChange), for: .editingChanged)
    }

    private func setupUI() {
        buttonRegister.setTitle("Register", for: .normal)

        switch stateView {
        case .edit:
            labelTitle.text = "Edit Card"
            labelCardNumber.text = creditCard?.cardNumber
            labelCardName.text = creditCard?.cardName
            labelCardExpired.text = creditCard?.cardExpired
            labelCardCVV.text = creditCard?.cardCvv
            buttonRegister.setTitle("Edit",for: .normal)
        case .register:
            return
        }
    }

    @objc func didChangeText(textField: UITextField) {
        textField.text = String().formatterCreditCard(str: textField.text ?? String.empty)
    }

    @objc func expirationDateDidChange() {
        labelCardExpired.text = String().formatterExpirationDate(str: labelCardExpired.text ?? String.empty)
     }

    @IBAction func actionRegisterCreditCard(_ sender: Any) {
        let creditCard = CreditCard(cardNumber: labelCardNumber.text ?? String.empty, cardName: labelCardName.text ?? String.empty, cardExpired: labelCardExpired.text ?? String.empty, cardCvv: labelCardCVV.text ?? String.empty)

        viewModel.registerCreditCard(creditCard: creditCard)
    }

}

extension RegisterCreditCardVC: UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
      }

    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text ?? String.empty).count + string.count - range.length

        if textField == labelCardNumber {
            return newLength <= 19
        }

        if textField == labelCardCVV {
            return newLength <= 3
        }

        if textField == labelCardExpired {
            return newLength <= 5
        }

        return true
    }
}

extension RegisterCreditCardVC: CreditCardProtocol {
    func registerCardSuccess() {
        let creditCard = viewModel.getCard()

        switch stateView {
        case .edit:
            if let card = creditCard {
                self.delegate?.updateCreditCard(creditCard: card)
            }

            dismiss(animated: true, completion: nil)
        case .register:
            dismiss(animated: true) {
                if let card = creditCard, let contact = self.contact {
                    self.delegate?.goAhead(card, contact)
                }
            }
        }
    }

    func registerCardError() {
        print("error")
    }
}
