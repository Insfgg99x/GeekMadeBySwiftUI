//
//  FeedDetail.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct FeedDetail: View {
    var feed : Feed
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FeedDetail_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetail(feed: defaultFeed)
    }
}
