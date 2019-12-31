
//
//  MineFavorite.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct MineFavorite: View {
    @EnvironmentObject var vm : MineVM
    
    var body: some View {
        List {
            ForEach((0..<vm.data.count), id : \.self) { index in
                Section(header:
                    VStack(alignment: .leading) {
                        Text(self.vm.data[index].category)
                        .font(.headline)
                        .bold()
                        .frame(height : 25)
                        .padding(.leading, 15)
                        .offset(x: 0, y: 5)
                        Divider()
                    }
                    .background(Color.white)
                ) {
                    ForEach(self.vm.data[index].feeds) { feed in
                        NavigationLink(destination: FeedDetail(feed: feed)) {
                            FeedView(feed: feed)
                        }
                        .padding(.trailing, -16)//hide accosryView(arrow)
                    }
                }
            }
            .listRowInsets(EdgeInsets())
        }
        .navigationBarTitle("Favorites", displayMode: .inline)
        .onAppear {
            self.vm.loadData()
        }
    }
}

struct MineFavorite_Previews: PreviewProvider {
    static var previews: some View {
        MineFavorite()
    }
}
