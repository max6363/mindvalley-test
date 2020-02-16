//
//  Pin.swift
//  mind
//
//  Created by minhazpanara on 16/02/20.
//  Copyright © 2020 minhazpanara. All rights reserved.
//

import Foundation

struct  Pin {
    let id : String
    var url : String
    var width : Float = 0
    var height : Float = 0
}

struct PinData {
    let pins : [Pin]
}

extension PinData : Parceable {
    
    static func parseObject(array: [AnyObject]) -> Result<PinData, ErrorResult> {
        if let array : [AnyObject] = array {
            let pins : [Pin] = array.compactMap({
                print("Pin Item  $$$ ====> ", $0)
                return Pin(id: $0.value(forKey: "id") as! String,
                           url: $0.value(forKeyPath: "urls.full") as! String,
                           width: $0.value(forKey: "width") as! Float,
                           height: $0.value(forKey: "height") as! Float)
            })
            let pinData = PinData(pins: pins)
            return Result.success(pinData)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to prase ==> "))
        }
    }
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<PinData, ErrorResult> {
        return Result.failure(ErrorResult.parser(string: "Unable to prase ==> "))
    }
}
