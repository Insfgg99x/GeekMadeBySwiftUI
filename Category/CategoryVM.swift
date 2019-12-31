//
//  CategoryVM.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import RxSwift

final class CategoryVM : ObservableObject {
    @Published var feeds = [defaultFeed]
    @Published var type : Feed.FeedType = .ios {
        didSet {
            loadData()
        }
    }
    @Published var imgs = [String]()
    
    private let bag = DisposeBag()
    private let network = Network()
    
    init() {
        loadData()
    }
    
    func loadData() {
        network
            .loadCategoryData(type)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: { json in
                let results = json["results"] as? [[String : Any]]
                self.feeds = decode(results ?? []) ?? []
                if self.type == .welfare {
                    self.imgs = self.feeds.map { $0.url ?? "" }
                }
            }, onError: { error in
                print(error.localizedDescription)
            })
    }
}
