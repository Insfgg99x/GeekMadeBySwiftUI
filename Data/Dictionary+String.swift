//
//  Dictionary+String.swift
//  ClouderWork
//
//  Created by 峰哥 on 2019/5/16.
//  Copyright © 2019 https://www.clouderwork.com. All rights reserved.
//

import Foundation


public extension Dictionary {
    func string() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .init()) else {
            return nil
        }
        let str = String.init(data: data, encoding: .utf8)
        return str
    }
}

public extension String {
    func dictionary() -> [String : Any]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
        return json
    }
    
    func jsonArray() -> [[String : Any]]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]]
        return json
    }
    
    func array() -> [Any]? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
        return json
    }
}

public extension Array {
    func string() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .init()) else {
            return nil
        }
        let str = String.init(data: data, encoding: .utf8)
        return str
    }
}
