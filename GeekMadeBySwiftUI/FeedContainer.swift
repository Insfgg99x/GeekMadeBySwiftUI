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
            Text(data.category).font(.title)
            Divider()
            ForEach(data.feeds) { feed in
                FeedView(feed: feed)
            }
        }
    }
}

struct FeedContainer_Previews: PreviewProvider {
    static var previews: some View {
        FeedContainer(data : defaultFeedData)
    }
}


struct FeedView : View {
    var feed : Feed
    var body : some View {
        VStack(alignment: .leading) {
            Text(feed.desc ?? "")
            if (feed.images?.count ?? 0) > 0 {
                HStack {
                    ForEach(feed.images!, id: \.self) { img in
                        KFImage(URL(string: img))
                            .frame(width: (sw - 50)/4, height: (sw - 50) / 8)
                            .scaledToFill()
                            .clipped()
                            
                    }
                }
            }
            HStack {
                Text(feed.who ?? "").font(.subheadline)
                Spacer()
                Text(feed.time ?? "").font(.subheadline).foregroundColor(.gray)
            }
        }
    }
}

struct FeedView_Previews : PreviewProvider {
    static var previews: some View {
        FeedView(feed: defaultFeed)
    }
}

