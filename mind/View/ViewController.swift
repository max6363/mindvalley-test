//
//  ViewController.swift
//  mind
//
//  Created by minhazpanara
//  Copyright © 2019 minhazpanara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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

/*
class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    var items: Array = Array<Any>()
    var refreshControl = UIRefreshControl()
    var isLoading = false
    var loadingView: LoadMoreReusableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Register Loading Reuseable View
        
        self.collection.alwaysBounceVertical = true;
        let loadingReusableNib = UINib(nibName: "LoadMoreReusableView", bundle: nil)
        collection.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadMoreReusableView")
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        collection.addSubview(refreshControl)
        
        self.fetchData()
    }
    @objc func refresh(sender:AnyObject) {
        self.isLoading = false
        CacheManager.sharedInstance.clearCache()
        items.removeAll()
        collection.reloadData()
        fetchData()
    }
}

extension ViewController {
    func fetchData() {
        NetworkService.sharedInstance.getData(urlString: "https://pastebin.com/raw/1WcGvnm5") { (response) in
            if (response!.succeeded) {
                self.items = response?.response as! Array<Any>
                self.collection.reloadData()
            } else {
                // show error
                print("Error: \(response?.error?.localizedDescription ?? "")")
            }
            self.refreshControl.endRefreshing()
        }
    }
}

extension ViewController {
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinBoardCell", for: indexPath) as! PinBoardCell
        cell.setCornerRadius(radius: 10, borderWidth: 1, borderColor: UIColor.lightGray)
        
        cell.photo.image = nil
        cell.startLoading()
        let item: [String: Any] = items[indexPath.row] as! [String : Any]
        if let urls: [String: Any] = item["urls"] as? [String : Any] {
            if let thumb = urls["raw"] {
                cell.photo.setImageWithUrl(urlString: thumb as! String) { (image, url) in
                    cell.stopLoading()
                }
            }
        }
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       return CGSize(width: 150.0, height: 200.0)
    }
    
    //MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadMoreReusableView", for: indexPath) as! LoadMoreReusableView
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loading.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.loading.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == items.count - 10 && !self.isLoading {
            //loadMoreData()
        }
    }

    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
               
        }
    }
}
*/
