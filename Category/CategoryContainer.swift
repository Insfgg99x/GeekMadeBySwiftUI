
//
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct CategoryContainer: View {
    @EnvironmentObject var vm : CategoryVM
    @State var isRefreshing = false
    @State private var page = 1
    @State private var shouldLoadMore = true
    
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
                    .background(PullToRefresh(action: {
                        self.page = 1
                        self.vm.loadData { _ in
                            self.isRefreshing = false
                        }
                    }, isShowing: $isRefreshing))
                    .listRowInsets(EdgeInsets())
                }
                ZStack {
                    Rectangle()
                        .foregroundColor(.init(white: 0.96))
                        .frame(height : 40)
                    Button(action: loadMore) {
                        Text(shouldLoadMore ? "Load More" : "No More Data")
                            .frame(height : 40)
                            .foregroundColor(shouldLoadMore ? .blue : .gray)
                    }
                }
            }
            .navigationBarTitle("Category", displayMode: .inline)
        }
    }
    
    private func loadMore() {
        guard shouldLoadMore else {
            return
        }
        page += 1
        vm.loadData(page: page) {
            self.shouldLoadMore = $0
        }
    }
}

struct CategoryContainer_Previews: PreviewProvider {
    static var previews: some View {
        CategoryContainer()
    }
}
