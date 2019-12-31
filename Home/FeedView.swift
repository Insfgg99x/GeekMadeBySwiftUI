//
//  FeedView.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct FeedView : View {
    var feed : Feed
    var body : some View {
        VStack(alignment: .leading) {
            Text(feed.desc ?? "")
                .font(.subheadline)
            if (feed.images?.count ?? 0) > 0 {
                HStack {
                    ForEach(feed.images!, id: \.self) { img in
                        KFImage(URL(string: img))
                            .frame(width: (sw - 50)/4, height: (sw - 50) / 8)
                            .scaledToFill()
                            .clipped()
                            
                    }
                }
            } else {
                Spacer()
            }
            HStack {
                Text(feed.who ?? "")
                    .padding(.all, 2)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .background(Color.init(red: Double(0x16) / 255.0,
                                           green: Double(0x98) / 255.0,
                                           blue: Double(0xaf) / 255.0))
                    .cornerRadius(2)
                Spacer()
                Text(feed.time ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.all, 15)
    }
}

struct FeedView_Previews : PreviewProvider {
    static var previews: some View {
        FeedView(feed: defaultFeed)
    }
}
