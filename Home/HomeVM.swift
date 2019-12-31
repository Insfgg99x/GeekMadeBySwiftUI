//
//  HomeVM.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import RxSwift

struct HomeData {
    var feeds : [Feed]
    var category : String
}


final class HomeVM : ObservableObject {
    @Published var data = [defaultFeedData]
    @Published var banners = [""]
    
    private let bag = DisposeBag()
    private let network = Network.init()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        network
            .loadHomeData()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: { json in
                let feeds = (json["results"] as? [String : [[String : Any]]] ?? [:]).sorted(by: { (kv1, kv2) -> Bool in
                    let key1 = kv1.key as String
                    let key2 = kv2.key as String
                    return key1 < key2
                })
                var dataArray = [HomeData]()
                for pair in feeds {
                    let key = pair.key
                    let values = pair.value
                    let array : [Feed] = decode(values) ?? []
                    if key == Feed.FeedType.welfare.rawValue {
                        self.banners = array.map{ $0.url ?? ""}
                    } else {
                        let d = HomeData.init(feeds: array, category: pair.key)
                        dataArray.append(d)
                    }
                }
                self.data = dataArray
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: bag)
    }
}
