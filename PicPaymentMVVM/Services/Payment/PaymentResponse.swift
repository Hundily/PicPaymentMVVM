//
//  PaymentResponse.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira Silva on 12/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

struct PaymentResponse: Codable {
    let transaction: Transaction?
}

struct Transaction: Codable {
    let transactionId: Int?
    let timestamp: Int?
    let value: Double?
    let destinationUser: DestinationUser?
    let success: Bool?
    let status: String?

    private enum CodingKeys: String, CodingKey {
        case transactionId = "id"
        case timestamp
        case value
        case destinationUser
        case success
        case status
    }
}

struct DestinationUser: Codable {
    let id: Int?
    let name: String?
    let img: String?
    let username: String?
}
