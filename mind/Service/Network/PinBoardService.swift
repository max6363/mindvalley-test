//
//  PinBoardService.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation

protocol PinBoardServiceProtocol : class {
    func fetchPins(_ completion: @escaping ((Result<PinData, ErrorResult>) -> (Void)))
}

final class PinBoardService : RequestHandler, PinBoardServiceProtocol {
    
    static let shared = PinBoardService()
    
    let endpoint = "https://pastebin.com/raw/1WcGvnm5"
    var task : URLSessionTask?

    func fetchPins(_ completion: @escaping ((Result<PinData, ErrorResult>) -> (Void))) {
        self.cancelFetchPins()        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchPins() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
