//
//  ErrorResult.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
