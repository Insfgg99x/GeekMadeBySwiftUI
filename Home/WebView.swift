//
//  WebView.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/31.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var redirect : String?
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: redirect ?? "") {
            uiView.load(URLRequest.init(url: url))
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(redirect: "https://github.com/dKingbin/GoPlay")
    }
}
