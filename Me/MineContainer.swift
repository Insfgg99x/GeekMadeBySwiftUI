

//
//  Copyright © 2019 Paolo Leonardi. All rights reserved.
//

import SwiftUI

struct MineContainer: View {
    var body: some View {
            NavigationView {
                List {
                    Section {
                        Text("我的收藏")
                    }
                    Section {
                        Text("清除缓存")
                    }
                    Section {
                        Text("意见反馈")
                        Text("点个赞")
                        Text("版本")
                    }
                    Section {
                        Text("推荐给好友")
                    }
                }
                .listStyle(GroupedListStyle())
                .listRowInsets(EdgeInsets())
                .navigationBarTitle("Me", displayMode: .inline)
        }
    }
}

struct MineContainer_Previews: PreviewProvider {
    static var previews: some View {
        MineContainer()
    }
}
