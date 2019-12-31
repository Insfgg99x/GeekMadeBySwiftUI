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
    @State var isFavorite : Bool = false
    
    var body: some View {
        WebView(redirect: feed.url)
            .navigationBarTitle("Detail", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if DBManager.shared.entityWithId(self.feed._id) != nil {
                    DBManager.shared.deleteById(self.feed.id)
                } else {
                    DBManager.shared.insert(feed: self.feed)
                }
                DBManager.shared.save()
                self.isFavorite = DBManager.shared.entityWithId(self.feed._id) != nil
            }) {
                if self.isFavorite {
                    Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                    .foregroundColor(.gray)
                }
            })
            .padding()
            .onAppear {
                self.isFavorite = DBManager.shared.entityWithId(self.feed._id) != nil
            }
    }
}

struct FeedDetail_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetail(feed: defaultFeed)
    }
}


