//
//  SplashViewController.swift
//  PicPaymentMVVM
//
//  Created by Hundily Cerqueira on 19/03/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var labelDevelop: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        goAhead()
    }

    func goAhead() {
        UIView.animate(withDuration: 2.5, animations: {
            self.labelDevelop.alpha = 1
            self.view.layoutIfNeeded()
        }) { (val) in
            let nav = UINavigationController(rootViewController: ContactsVC())
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true, completion: nil)
        }
    }
}
