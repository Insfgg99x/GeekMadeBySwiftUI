//
//  HomeNetwork.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

public enum NetworkkResult<T> {
    case success(T)
    case error(Error)
}

struct HomeNetwork {
    enum HomeApi : TargetType {
        case today
        
        var baseURL: URL {
            return host
        }
        
        var path: String {
            return "today"
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

extension HomeNetwork {
    func loadHomeData() -> Single<[String : Any]> {
        return provider.rx.request(.today).mapJSON().flatMap {
            return .just($0 as! [String : Any])
        }
    }
}
