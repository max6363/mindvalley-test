//
//  CacheManager.swift
//
//  Created by minhazpanara
//  Copyright © 2019 minhazpanara. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageWithUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let data: NSData? = CacheManager.sharedInstance.cache.object(forKey: urlString as AnyObject) as? NSData
        
        if let imageData = data {
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.setImage(image: image!, animated: true)
                completionHandler(image, urlString)
            }
        }
        else {
            self.cancelImageloadingWithUrl(urlString: urlString)
            let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        if data != nil {
                            let image = UIImage.init(data: data!)
                            if let image = image {
                                CacheManager.sharedInstance.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                                self.setImage(image: image, animated: true)
                                completionHandler(image, urlString)
                            } else {
                                completionHandler(nil, urlString)
                            }
                        }
                    } else {
                        completionHandler(nil, urlString)
                    }
                }
            }
            CacheManager.sharedInstance.setCurrentTask(task: downloadTask, urlString: urlString)
            downloadTask.resume()
        }
    }
    
    func setImage(image: UIImage, animated: Bool) {
        if animated {
            UIView.transition(with: self,
            duration: 0.75,
            options: .transitionCrossDissolve,
            animations: { self.image = image },
            completion: nil)
        } else {
            self.image = image
        }
    }
    
    func cancelImageloadingWithUrl(urlString: String) {
        CacheManager.sharedInstance.cancelCurrentTaskWithUrl(url: urlString)
    }
}

extension UIButton {
    
}

