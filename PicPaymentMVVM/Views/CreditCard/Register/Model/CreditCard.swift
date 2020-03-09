//
//  CreditCard.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 09/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

struct CreditCard: Codable {
    let cardNumber: String
    let cardName: String
    let cardExpired: String
    let cardCvv: String
}
