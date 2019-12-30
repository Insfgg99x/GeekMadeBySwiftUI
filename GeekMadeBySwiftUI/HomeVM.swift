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
    
    private let bag = DisposeBag()
    private let network = HomeNetwork.init()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        network.loadHomeData().subscribeOn(MainScheduler.instance).subscribe(onSuccess: { json in
            let feeds = (json["results"] as? [String : [[String : Any]]] ?? [:]).sorted(by: { (kv1, kv2) -> Bool in
                let key1 = kv1.key as String
                let key2 = kv2.key as String
                return key1 < key2
            })
            var dataArray = [HomeData]()
            for pair in feeds {
                let values = pair.value
//                if pair.key == FeedType.welfare.rawValue {
//                    var sectionArray = [Feed]()
//                    for dict in values {
//                        let f = Mapper<Feed>.init().map(JSON: dict)
//                        if f != nil {
//                            sectionArray.append(f!)
//                        }
//                    }
//                    wkself?.bannerArray.removeAll()
//                    wkself?.bannerArray.append(contentsOf: sectionArray)
//                    wkself?.headView.reloadData()
//                    wkself?.pageControl.numberOfPages = sectionArray.count
//                    wkself?.pageControl.currentPage = 0
//                    continue
//                }
                let array : [Feed] = decode(values) ?? []
                let d = HomeData.init(feeds: array, category: pair.key)
                dataArray.append(d)
            }
            self.data = dataArray
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: bag)
    }
}
