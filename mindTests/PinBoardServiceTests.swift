//
//  PinBoardServiceTests.swift
//  mindTests
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import XCTest
@testable import mind

class PinBoardServiceTests: XCTestCase {

    func testCancelRequest() {
        
        // giving a "previous" session
        PinBoardService.shared.fetchPins({ (_) -> (Void) in
            // ignore call
        })
        
        // Expected to task nil after cancel
        PinBoardService.shared.cancelFetchPins()
        XCTAssertNil(PinBoardService.shared.task, "Expected task nil")
    }

}
