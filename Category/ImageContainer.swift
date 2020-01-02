//
//  ImageContainer.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct ImageContainer: View {
    @EnvironmentObject var vm : CategoryVM
    @State var showBigImage = false
    
    var body: some View {
        WaterfallGrid(0 ..< vm.imgs.count, id: \.self) { index in
            KFImage(URL(string: self.vm.imgs[index]))
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    self.showBigImage.toggle()
                }
                .sheet(isPresented: self.$showBigImage) {
                    KFImage(URL(string: self.vm.imgs[index]))
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
