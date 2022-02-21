//
//  ViewController.swift
//  Netology_IB_Instruments
//
//  Created by Арсений Корнилов on 21.02.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let subview = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? UIView {
            self.view.addSubview(subview)
            subview.frame = CGRect(x: 0, y: 20, width: 400, height: 600)
        }
    }

}

