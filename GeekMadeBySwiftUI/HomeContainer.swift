//
//  Copyright © 2019 Paolo Leonardi. All rights reserved.
//

import SwiftUI

struct HomeContainer: View {
    @EnvironmentObject var vm : HomeVM
    
    var body: some View {
        NavigationView {
            List {
                PageView([Image("1"), Image("2"), Image("3")])
                    .aspectRatio(3/2, contentMode: .fit)
                    .frame(height: sw * 2 / 3)
                    .listRowInsets(EdgeInsets())
                    //.edgesIgnoringSafeArea(.top)
                ForEach((0..<vm.data.count), id : \.self) { index in
                    FeedContainer(data: self.vm.data[index])
                }.padding()
                .listRowInsets(EdgeInsets())
            }
            .navigationBarTitle("Home")
        }
    }
}

struct HomeContainer_Previews: PreviewProvider {
    static var previews: some View {
        HomeContainer().environmentObject(HomeVM())
    }
}
