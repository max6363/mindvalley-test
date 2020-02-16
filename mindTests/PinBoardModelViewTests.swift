//
//  PinBoardModelViewTests.swift
//  mindTests
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import XCTest
@testable import mind

class PinBoardModelViewTests: XCTestCase {

    var viewModel : PinBoardViewModel!
    var dataSource : GenericDataSource<Pin>!
    fileprivate var service : MockPinBoardService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.service = MockPinBoardService()
        self.dataSource = GenericDataSource<Pin>()
        self.viewModel = PinBoardViewModel(service: self.service, dataSource: self.dataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }

    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service for fetching pins")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch pins
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchData()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchPins() {
        
        let expectation = XCTestExpectation(description: "Pins fetch")
        
        // giving a service mocking pin data
        service.pinData = PinData(pins: [Pin]())
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchData()
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchNoPins() {
        
        let expectation = XCTestExpectation(description: "No pins")
        
        // giving a service mocking error during fetching pins
        service.pinData = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.fetchData()
        wait(for: [expectation], timeout: 5.0)
    }
}

fileprivate class MockPinBoardService : PinBoardServiceProtocol {
    
    var pinData : PinData?
    
    func fetchPins(_ completion: @escaping ((Result<PinData, ErrorResult>) -> (Void))) {
        if let d = pinData {
            completion(Result.success(d))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No pin data")))
        }
    }
}
