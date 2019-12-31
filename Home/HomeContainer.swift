//
//  Copyright © 2019 Paolo Leonardi. All rights reserved.
//

import SwiftUI

struct HomeContainer: View {
    @EnvironmentObject var vm : HomeVM
    
    var body: some View {
        NavigationView {
            List {
                PageView(vm.banners.map { KFImage(URL(string: $0)) })
                    .scaledToFill()
                    .frame(height: sw * 0.6)
                    .clipped()
                    .listRowInsets(EdgeInsets())
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
            .navigationBarTitle("Today", displayMode: .inline)
        }
    }
}

struct HomeContainer_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainer().environmentObject(HomeVM())
    }
}