//
//  PageControl.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages : Int
    @Binding var currentPage : Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let c = UIPageControl.init()
        c.numberOfPages = numberOfPages
        return c
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
