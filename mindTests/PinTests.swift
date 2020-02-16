//
//  PinTests.swift
//  mindTests
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import XCTest
@testable import mind

class PinTests: XCTestCase {

    func testParseEmptyPin() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing
        // expected valid converter with valid data
        let completion : ((Result<PinData, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }

}
