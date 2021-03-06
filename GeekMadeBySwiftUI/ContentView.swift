//
//  ContentView.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectIndex = 0
    
    var body: some View {
        TabView(selection: $selectIndex) {
            HomeContainer()
                .environmentObject(HomeVM())
                .tabItem {
                    Image("tab_home")
                        .renderingMode(.template)
                    Text("Today")
                }
            .tag(0)
            
            CategoryContainer()
                .environmentObject(CategoryVM())
                .tabItem {
                    Image("tab_category")
                        .renderingMode(.template)
                    Text("Category")
                }
            .tag(1)
            
            MineContainer()
                .environmentObject(MineVM())
                .tabItem {
                    Image("tab_me")
                        .renderingMode(.template)
                    Text("Me")
                }
            .tag(2)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
