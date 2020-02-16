//
//  CacheManager.swift
//
//  Created by minhazpanara.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation

class CacheManager {
    
    var cache = NSCache<AnyObject, AnyObject>()
    var tasks = NSCache<AnyObject, AnyObject>()

    class var sharedInstance : CacheManager {
        struct Static {
            static let instance : CacheManager = CacheManager()
        }
        return Static.instance
    }
    
    init() {
        self.cache.countLimit = 50
        self.cache.totalCostLimit = 50
        self.cache.evictsObjectsWithDiscardedContent = true
    }
    
    func clearCache() {
        self.cache.removeAllObjects()
    }
    
    func setCurrentTask(task: URLSessionDataTask, urlString: String) {
        self.tasks.setObject(task as AnyObject, forKey: urlString as AnyObject)
    }
    
    func cancelCurrentTaskWithUrl(url: String) {
        let task: URLSessionDataTask? = self.tasks.object(forKey: url as AnyObject) as? URLSessionDataTask
        if let t = task {
            t.cancel()
            self.tasks.removeObject(forKey: url as AnyObject)
        }
    }
}
