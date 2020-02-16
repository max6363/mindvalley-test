//
//  PinBoardViewController.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import UIKit

class PinBoardViewController: UIViewController {

     @IBOutlet weak var collection: UICollectionView!
        let dataSource = PinBoardDataSource()
        var refreshControl = UIRefreshControl()
        
        lazy var viewModel : PinBoardViewModel = {
           let viewModel = PinBoardViewModel(dataSource: dataSource)
            return viewModel
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
            collection.addSubview(refreshControl)
            
            self.collection.dataSource = self.dataSource
            self.collection.delegate = self.dataSource
            self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
                self?.collection.reloadData()
            }
            
            // Error handling
            self.viewModel.onErrorHandling = { [weak self] _ in
                self!.refreshControl.endRefreshing()
                // display error ?
                let controller = UIAlertController(title: "An error occured", message: "Oops, something went wrong!", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
                self?.present(controller, animated: true, completion: nil)
            }
            
            self.viewModel.fetchData()
        }
        
        @objc func refresh(sender:AnyObject) {
            CacheManager.sharedInstance.clearCache()
    //        items.removeAll()
            collection.reloadData()
            self.viewModel.fetchData()
        }

}
