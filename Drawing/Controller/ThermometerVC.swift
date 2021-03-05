//
//  ThermometerVC.swift
//  Drawing
//
//  Created by Жанадил on 3/5/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

class ThermometerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
