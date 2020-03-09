//
//  CreditCardViewModel.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import Foundation

protocol CreditCardProtocol: class {
    func registerCardSuccess()
    func registerCardError()
}

class CreditCardViewModel {
    
    weak var delegate: CreditCardProtocol?
    private var creditCard: CreditCard?
    private var contact: Contact?

    func registerCreditCard(creditCard: CreditCard) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(creditCard) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "CREDIT_CARD")
            self.creditCard = creditCard
            delegate?.registerCardSuccess()
        } else {
            delegate?.registerCardError()
        }
    }
    
    func fetchCreditCardData() {
        if let cardPase = UserDefaults.standard.object(forKey: "CREDIT_CARD") as? Data {
            let decoder = JSONDecoder()
            if let card = try? decoder.decode(CreditCard.self, from: cardPase) {
                self.creditCard = card
            }
        }
    }
    
    func setContact(contact: Contact) {
        self.contact = contact
    }
    
    func getCard() -> CreditCard? {
        return self.creditCard
    }
}
