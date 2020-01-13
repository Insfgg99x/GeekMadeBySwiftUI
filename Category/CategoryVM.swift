//
//  CategoryVM.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import RxSwift
import Photos

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
    
    func loadData(page : Int = 1, _ end : ((_ canLoadMore: Bool) -> ())? = nil) {
        network
            .loadCategoryData(type, page)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onSuccess: { json in
                let results = json["results"] as? [[String : Any]]
                end?((results?.count ?? 0 > 0))
                let array : [Feed] = decode(results ?? []) ?? []
                if page == 1 {
                    self.feeds = array
                    if self.type == .welfare {
                        self.imgs = array.map { $0.url ?? "" }
                    }
                } else {
                    self.feeds.append(contentsOf: array)
                    if self.type == .welfare {
                        self.imgs.append(contentsOf: array.map { $0.url ?? "" })
                    }
                }
            }, onError: { error in
                print(error.localizedDescription)
                end?(true)
            })
            .disposed(by: bag)
    }
}


extension CategoryVM {
    func save(_ img : String) {
        guard let url = URL.init(string: img) else {
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                return
            }
            PHPhotoLibrary.shared().performChanges({
                guard let data = try? Data.init(contentsOf: url) else {
                    return
                }
                PHAssetCreationRequest.forAsset().addResource(with: .photo, data: data, options: nil)
            }, completionHandler: { (ret, error) in
                if ret {
                    print("Saved success!")
                }
            })
        }
    }
}
