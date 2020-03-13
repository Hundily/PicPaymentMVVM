//
//  PaymentViewModel.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 12/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import Foundation

protocol PaymentViewModelDelegate: class {
    func show()
    func showError(_ error: Error)
    func routerRegisterCreditCard(contact: Contact)
    func routerPayment(_ contact: Contact, _ creditCard: CreditCard)
}

class PaymentViewModel {
    private let service: PaymentService?
    weak var delegate: PaymentViewModelDelegate?
    private var creditCard: CreditCard?
    private var selectedContact: Contact?
    
    init() {
        service = PaymentService()
    }
    
    func fetchPayment(payment: Payment) {
        guard let service = service else { return }
        
//        var paymentTest = Payment(card_number: "1111111111112222", cvv: 123, value: 1.0, expiry_date: "10/10", destination_user_id: 1)
        service.fetchPayment(payment: payment) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(payment):
                print(payment)
//                strongSelf.delegate?.show()
            case let .failure(error):
                self?.delegate?.showError(error)
            }
        }
    }
}

