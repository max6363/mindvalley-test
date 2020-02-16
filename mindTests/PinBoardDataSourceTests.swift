//
//  PinBoardDataSourceTests.swift
//  mindTests
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import XCTest
@testable import mind

class PinBoardDataSourceTests: XCTestCase {

    var dataSource : PinBoardDataSource!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.dataSource = PinBoardDataSource()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        collection.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collection), 1, "Expected one section in collection view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.collectionView(collection, numberOfItemsInSection: 0), 0 , "Expected no cell in collection view")
    }

    func testValueInDataSource() {
        
        // giving data value
        let p1 = Pin(id: "1", url: "")
        let p2 = Pin(id: "2", url: "")
        dataSource.data.value = [p1, p2]
        
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        collection.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: collection), 1, "Expected one section in collection view")
        
        // expected two cells
        XCTAssertEqual(dataSource.collectionView(collection, numberOfItemsInSection: 0), 2 , "Expected two cells in collection view")
    }
    
    func testValueCell() {
        
        // giving data value
        let p1 = Pin(id: "1", url: "http://dummyurl.com")
        dataSource.data.value = [p1]
        
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        collection.dataSource = dataSource
        collection.register(PinBoardCell.self, forCellWithReuseIdentifier: "PinBoardCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected PinBoardCell class
        guard let _ = dataSource.collectionView(collection, cellForItemAt: indexPath)  as? PinBoardCell else {
            XCTAssert(false, "Expected PinBoardCell class")
            return
        }
    }

}
