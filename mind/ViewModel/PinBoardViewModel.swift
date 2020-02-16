//
//  PinBoardViewModel.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation

struct PinBoardViewModel {
    
    weak var dataSource : GenericDataSource<Pin>?
    weak var service : PinBoardServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> (Void))?
    
    init(service: PinBoardServiceProtocol = PinBoardService.shared, dataSource: GenericDataSource<Pin>?) {
        self.service = service
        self.dataSource = dataSource
    }
    
    func fetchData() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchPins { result -> (Void) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    self.dataSource?.data.value = data.pins
                    
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
