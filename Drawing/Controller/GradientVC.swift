//
//  GradientVC.swift
//  Drawing
//
//  Created by Жанадил on 3/5/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

class GradientVC: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(exitButton)
    }
    
    @IBAction func exitButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
