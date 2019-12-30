//
//  Decoder.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation

public func decode<T: Decodable>(_ json: Any) -> T? {
    guard let data: Data = try? JSONSerialization.data(withJSONObject: json, options: .init()) else {
        return nil
    }
    let decoder = JSONDecoder()
    let result = try? decoder.decode(T.self, from: data)
    return result
}

public func decode<T : Decodable>(_ data : Data) -> T? {
    let decoder = JSONDecoder()
    let result = try? decoder.decode(T.self, from: data)
    return result
}
