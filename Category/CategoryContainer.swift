
//
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct CategoryContainer: View {
    @EnvironmentObject var vm : CategoryVM
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("type", selection: $vm.type) {
                    ForEach(Feed.FeedType.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0)
                            .font(.system(size: 8))
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 10)
                if vm.type == .welfare {
                    ImageContainer()
                        .padding(10)
                        .environmentObject(vm)
                } else {
                    List(vm.feeds) { feed in
                        NavigationLink(destination: FeedDetail(feed: feed)) {
                            FeedView(feed: feed)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .navigationBarTitle("Category", displayMode: .inline)
        }
    }
}

struct CategoryContainer_Previews: PreviewProvider {
    static var previews: some View {
        CategoryContainer()
    }
}
