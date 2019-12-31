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
    
    var body: some View {
        WaterfallGrid(vm.imgs, id: \.self) { img in
            KFImage(URL(string: img))
                .resizable()
                .aspectRatio(contentMode: .fit)
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
