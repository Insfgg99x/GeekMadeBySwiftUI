//
//  PageView.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct PageView<T : View>: View {
    @State var currentPage = 0
    private var controllers : [UIHostingController<T>]
    
    init(_ views : [T]) {
        self.controllers = views.map { UIHostingController(rootView: $0)}
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageController(controllers: controllers,
                           currentPage: $currentPage)
            PageControl(numberOfPages: controllers.count,
                        currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView([Image("1"), Image("2"), Image("3")])
    }
}
