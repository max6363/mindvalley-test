//
//  PinBoardDataSource.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation
import UIKit

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class PinBoardDataSource: GenericDataSource<Pin>, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinBoardCell", for: indexPath) as! PinBoardCell
        cell.setCornerRadius(radius: 10, borderWidth: 1, borderColor: UIColor.lightGray)
        
        cell.photo?.image = nil
        cell.startLoading()

        let data = self.data.value[indexPath.row]
        cell.photo?.setImageWithUrl(urlString: data.url) { (image, url) in
            cell.stopLoading()
        }
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let data = self.data.value[indexPath.row]
        let h = 200 * (data.width / data.height)
        return CGSize(width: 150, height: Double(h))
    }
    
    
}
