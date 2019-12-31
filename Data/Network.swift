//
//  Network.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public enum NetworkkResult<T> {
    case success(T)
    case error(Error)
}

struct Network {
    enum HomeApi : TargetType {
        case today
        case category(_ type : Feed.FeedType)
        
        var baseURL: URL {
            return host
        }
        
        var path: String {
            switch self {
            case .today:
                return "today"
            case .category(let type):
                return "data/\(type.rawValue)/20/1"
            }
        }
        
        var method: Moya.Method {
            return .get
        }
        
        var sampleData: Data {
            return "".data(using: .utf8)!
        }
        
        var task: Task {
            return .requestPlain
        }
        
        var headers: [String : String]? {
            return nil
        }
    }
    
    private let provider = MoyaProvider<HomeApi>()
}

extension Network {
    func loadHomeData() -> Single<[String : Any]> {
        return provider.rx.request(.today).mapJSON().flatMap {
            return .just($0 as! [String : Any])
        }
    }
    
    func loadCategoryData(_ type : Feed.FeedType) -> Single<[String : Any]> {
        return provider.rx.request(.category(type)).mapJSON().flatMap {
            return .just($0 as! [String : Any])
        }
    }
}
