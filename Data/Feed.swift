//
//  Feed.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import Foundation

struct Feed : Hashable, Codable {
    var _id: String?
    var createdAt: String?
    var desc: String?
    var publishedAt: String?
    var source: String?
    var type: String?
    var url: String?
    var used: Bool?
    var who: String?
    var images : [String]?
    
    enum FeedType: String, CaseIterable {
        case ios = "iOS"
        case web =  "前端"
        case android = "Android"
        case vedio = "休息视频"
        case lib = "拓展资源"
        case welfare = "福利"
    }
}

extension Feed : Identifiable {
    var id: String? {
        return _id
    }
}

extension Feed {
    var time : String? {
        get {
            guard let pa = publishedAt else {
                return nil
            }
            guard pa.count >= 10 else {
                return pa
            }
            let t = String.init(pa[pa.index(pa.startIndex, offsetBy: 5) ..< pa.index(pa.startIndex, offsetBy: 10)])
            return t
        }
    }
}

let defaultFeed : Feed = decode([
    "_id": "5cd527ed9d212239df927aa2",
    "createdAt": "2019-05-10T07:27:41.223Z",
    "desc": "GoPlay 是一款基于FFmpeg/OpenGL ES 2.0 的iOS播放器。支持FFmpeg内嵌的所有格式。而且可以自定义各种滤镜, 包括VR、水印等。",
    "images": [
        "https://ww1.sinaimg.cn/large/0073sXn7gy1g37vymj8etj30ij0agn42",
        "https://ww1.sinaimg.cn/large/0073sXn7gy1g37vynuh2uj30ik0agdrz",
        "https://ww1.sinaimg.cn/large/0073sXn7gy1g37vyqf0gvj30il0aedof"
    ],
    "publishedAt": "2019-05-20T08:49:42.980Z",
    "source": "web",
    "type": "iOS",
    "url": "https://github.com/dKingbin/GoPlay",
    "used": true,
    "who": "lijinshanmx"
])!

let defaultFeedData = HomeData(feeds: [defaultFeed], category: "iOS")
