//
//  FeedContainer.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct FeedContainer: View {
    var data : HomeData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(data.category)
                .font(.headline)
            if data.feeds.count >= 2 {
                FeedView(feed: data.feeds[0])
                FeedView(feed: data.feeds[0])
            }
        }
        .frame(height : 300)
        .padding()
    }
}

struct FeedContainer_Previews: PreviewProvider {
    static var previews: some View {
        FeedContainer(data : defaultFeedData)
    }
}

