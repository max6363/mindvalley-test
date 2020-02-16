//
//  PinBoardCell.swift
//  mind
//
//  Created by minhazpanara
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import UIKit

class PinBoardCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    func startLoading() {
        loading?.startAnimating()
    }
    
    func stopLoading() {
        loading?.stopAnimating()
    }
}
