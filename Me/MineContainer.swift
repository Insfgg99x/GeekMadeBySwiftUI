

//
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct MineContainer: View {
    @EnvironmentObject var vm : MineVM
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: MineFavorite()
                        .environmentObject(vm)) {
                        Text("我的收藏")
                    }
                }
                Section {
                    HStack {
                        Text("清除缓存")
                        Spacer()
                        Text(vm.cacheSize)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        self.vm.clearCache()
                    }
                }
                Section {
                    Text("意见反馈")
                    Text("点个赞")
                    HStack {
                        Text("版本")
                        Spacer()
                        Text(vm.appVer())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Section {
                    Text("推荐给好友")
                }
            }
            .listStyle(GroupedListStyle())
            .listRowInsets(EdgeInsets())
            .navigationBarTitle("Me", displayMode: .inline)
        }
        .onAppear {
            self.vm.loadCacheSize()
        }
    }
}

struct MineContainer_Previews: PreviewProvider {
    static var previews: some View {
        MineContainer()
    }
}
