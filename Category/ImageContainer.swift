//
//  ImageContainer.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import Photos

struct ImageContainer: View {
    @EnvironmentObject var vm : CategoryVM
    @State var showBigImage = false
    
    var body: some View {
        WaterfallGrid(0 ..< vm.imgs.count, id: \.self) { index in
            NavigationLink(destination: KFImage(URL(string: self.vm.imgs[index]))
                .resizable()
                .scaledToFill()
                .onLongPressGesture {
                    self.showBigImage.toggle()
                }
                .alert(isPresented: self.$showBigImage) {
                    Alert(title: Text("Save to photolibrary"),
                          primaryButton: Alert.Button.default(Text("Save"), action: {
                            self.vm.save(self.vm.imgs[index])
                          }),
                          secondaryButton: Alert.Button.cancel())
                }) {
                KFImage(URL(string: self.vm.imgs[index]))
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    
            }
        }
        .gridStyle(columns: 2,
                   spacing: 10,
                   padding: EdgeInsets(),
                   scrollDirection: .vertical,
                   animation: .default)
    }
}

struct ImageContainer_Previews: PreviewProvider {
    static var previews: some View {
        ImageContainer()
    }
}
