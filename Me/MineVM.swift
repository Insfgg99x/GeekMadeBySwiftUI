//
//  MineVM.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation
import Kingfisher

final class MineVM : ObservableObject {
    @Published var data = [defaultFeedData]
    @Published var cacheSize : String = "0 KB"
    
    init() {
        loadData()
        loadCacheSize()
    }
    
    func loadData() {
        let favorites = DBManager.shared.entitys() ?? []
        var groupedArray = [HomeData]()
        var i = 0
        while i < favorites.count {
            let f1 = favorites[i]
            var j = i + 1
            var len = 1
            var sectionArray = [Feed]()
            sectionArray.append(f1.feed())
            while j < favorites.count {
                let f2 = favorites[j]
                if f1.type != f2.type {
                    break
                }
                sectionArray.append(f2.feed())
                j += 1
                len += 1
            }
            let d = HomeData(feeds: sectionArray, category: f1.type ?? "")
            groupedArray.append(d)
            i += len
        }
        DispatchQueue.main.async {
            self.data = groupedArray
        }
    }
    
    func loadCacheSize() {
        ImageCache.default.calculateDiskStorageSize { result in
            switch result {
            case .success(let size):
                self.sizeExpress(size)
            case .failure(_):
                break
            }
        }
    }
    
    func clearCache() {
        ImageCache.default.clearDiskCache {
            self.sizeExpress(0)
            print("cleared")
        }
    }
    
    private func sizeExpress(_ size : UInt) {
        DispatchQueue.main.async {
            if size == 0 {
                self.cacheSize = "0 KB"
            }
            self.cacheSize = ByteCountFormatter.string(fromByteCount: Int64(size), countStyle: .file)
        }
    }
    
    func appVer() -> String {
        let ver = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        return ver
    }
}
