//
//  ViewController.swift
//  Drawing
//
//  Created by Жанадил on 3/2/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

class VC: UITableViewController {
    var arr = ["1", "2", "3", "4", "5", "6"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "cell1")
        tableView.rowHeight = 400
    }
}



//MARK: TableView DataSource Methods
extension VC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ImageCell
        //cell.imgView.image = UIImage(named: arr[indexPath.row])
        cell.sampleImage = UIImage(named: arr[indexPath.row])
        cell.contentView.layer.cornerRadius = 20
        
        return cell
    }
}


//MARK: TableView Delegate Methods
extension VC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arr[indexPath.row] == "1"{
            performSegue(withIdentifier: "thermometerSegue", sender: self)
        }else if arr[indexPath.row] == "2"{
            performSegue(withIdentifier: "budgetSegue", sender: self)
        }else if arr[indexPath.row] == "3"{
            performSegue(withIdentifier: "clockSegue", sender: self)
        }else if arr[indexPath.row] == "4"{
            performSegue(withIdentifier: "gradientSegue", sender: self)
        }else if arr[indexPath.row] == "5"{
            performSegue(withIdentifier: "ratingSegue", sender: self)
        }else{
            performSegue(withIdentifier: "graphicSegue", sender: self)
        }
        
    }
}

