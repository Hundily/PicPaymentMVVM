//
//  ReceiptVC.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 19/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class ReceiptVC: UIViewController {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelTransactionTime: UILabel!
    @IBOutlet weak var labelTransactionId: UILabel!
    @IBOutlet weak var labelNumberCard: UILabel!
    @IBOutlet weak var labelTransactionValue: UILabel!
    private var transaction: PaymentResponse?
    private let kReceiptVC = "ReceiptVC"

    init(transaction: PaymentResponse) {
        self.transaction = transaction
        super.init(nibName: kReceiptVC, bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setData() {
        let transactionData = transaction?.transaction
        let userInfos = transaction?.transaction?.destinationUser
        imageProfile.imageFromURL(urlString: userInfos?.img ?? String.empty)
        labelUserName.text = userInfos?.username
        labelTransactionTime.text = String(describing: transactionData?.timestamp)
        labelTransactionId.text = String(describing: transactionData?.transactionId)
        labelNumberCard.text = "Cartão master 1233"
        labelTransactionValue.text = String(describing: transactionData?.value)
    }
}
