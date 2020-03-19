//
//  PaymentVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol UpdateCreditCard {
    func updateCreditCard(creditCard: CreditCard)
    func goAhead(_ creditCard: CreditCard, _ contact: Contact)
}

class PaymentVC: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelNickName: UILabel!
    @IBOutlet weak var labelCreditCard: UILabel!
    @IBOutlet weak var labelMoneyType: UILabel!
    @IBOutlet weak var labelErrorPayment: UILabel!
    @IBOutlet weak var inputValue: UITextField!
    @IBOutlet weak var buttonPayment: CustomButton!
    private var contact: Contact?
    private var creditCard: CreditCard?
    private var kPaymentVC = "PaymentVC"
    private var viewModel = PaymentViewModel()
    
    init(_ contact: Contact,_ creditCard: CreditCard) {
        self.contact = contact
        self.creditCard = creditCard
        super.init(nibName: kPaymentVC, bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setValue()
        viewModel.delegate = self
    }

    private func setupUI() {
        labelErrorPayment.isHidden = true
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        inputValue.textColor = .gray
        inputValue.tintColor = .clear
        inputValue.delegate = self
        inputValue.addTarget(self, action: #selector(moneyTextFieldDidChange), for: .editingChanged)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func setValue() {
        imgProfile.imageFromURL(urlString: self.contact?.img ?? String.empty)
        labelNickName.text = contact?.username ?? String.empty
        let last4 = String(self.creditCard?.cardNumber.suffix(4) ?? "")
        labelCreditCard.text = "\(last4)"
    }

    @IBAction func actionEditCreditCard(_ sender: Any) {
        guard let contact = contact else { return }
        let registerCreditCardVC = RegisterCreditCardVC(.edit, creditCard, contact)
        registerCreditCardVC.delegate = self
        let navRegisterCreditCardVC = UINavigationController(rootViewController: registerCreditCardVC)
        self.navigationController?.present(navRegisterCreditCardVC, animated: true, completion: nil)
    }

    @IBAction func actionPay(_ sender: Any) {
        guard let value = inputValue.text else  { return }
        if let card = creditCard?.cardNumber, let expiryDate = creditCard?.cardExpired, let cvv = creditCard?.cardCvv, let userId = contact?.id {
            let cardNumberCast = card.trimmingCharacters(in: .whitespaces)
            let doubleAmount = value.trimmingCharacters(in: .whitespaces).currencyToDouble()
            if let cvvCast = Int(cvv) {
                let paymentModel = Payment(cardNumber: cardNumberCast, cvv: cvvCast, value: doubleAmount, expiryDate: expiryDate, destinationUserId: userId)

                viewModel.fetchPayment(payment: paymentModel)
            }
        }
    }
}

extension PaymentVC: UpdateCreditCard {
    func goAhead(_ creditCard: CreditCard, _ contact: Contact) {
        //
    }

    func updateCreditCard(creditCard: CreditCard) {
        self.creditCard = creditCard
        setValue()
    }
}

extension PaymentVC: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        handleTextIsEmpty()
    }

    private func handleTextIsEmpty() {
        if let value = inputValue.text {
            let doubleAmount = value.trimmingCharacters(in: .whitespaces).currencyToDouble()
            if doubleAmount == 0 {
                self.buttonPayment.layoutButton(.disabled)
            } else {
                self.buttonPayment.layoutButton(.enabled)
            }
        }
    }

    @objc func moneyTextFieldDidChange(_ textField: UITextField) {
        if let amountString = inputValue.text?.currencyFormatting() {
            if amountString.isEmpty {
                textField.text = "0.00"
                textField.textColor = .gray
                labelMoneyType.textColor = .gray
            } else {
                textField.text = amountString
                textField.textColor = ColorName.green.color
                labelMoneyType.textColor = ColorName.green.color
            }
        }
    }
}

extension PaymentVC: PaymentViewModelDelegate {
    func show() {
        //
    }

    func showError(_ error: Error) {
        labelErrorPayment.isHidden = false
        labelErrorPayment.text = error.localizedDescription
    }

    func routerRegisterCreditCard(contact: Contact) {
        //
    }

    func routerPayment(_ contact: Contact, _ creditCard: CreditCard) {
        //
    }
}
