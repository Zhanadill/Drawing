//
//  ImageCell.swift
//  Drawing
//
//  Created by Жанадил on 3/3/21.
//  Copyright © 2021 Жанадил. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    let imageLayer = CALayer()
    var sampleImage: UIImage?
    
    override func awakeFromNib() {
        super .awakeFromNib()
        imgView.layer.addSublayer(imageLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layer = imgView.layer
        layer.cornerRadius = 30
        layer.shadowOffset = CGSize(width: 8, height: 8)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.masksToBounds = false
        
        imageLayer.frame = layer.bounds
        imageLayer.contents = sampleImage?.cgImage
        imageLayer.masksToBounds = true
        imageLayer.cornerRadius = layer.cornerRadius
        
        //imageLayer.borderColor = UIColor.gray.cgColor
        //imageLayer.borderWidth = 3
        
        imageLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
    
}
