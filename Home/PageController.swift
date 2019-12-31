//
//  PageController.swift
//  GeekMadeBySwiftUI
//
//  Created by xgf on 2019/12/30.
//  Copyright © 2019 xgf. All rights reserved.
//

import SwiftUI

struct PageController: UIViewControllerRepresentable {
    var controllers : [UIViewController]
    @Binding var currentPage : Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let page = UIPageViewController(transitionStyle: .scroll,
                                        navigationOrientation: .horizontal,
                                        options: nil)
        page.delegate = context.coordinator
        page.dataSource = context.coordinator
        return page
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers([controllers[currentPage]],
                                            direction: .forward,
                                            animated: true,
                                            completion: nil)
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator : NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        var page : PageController
        init(_ p : PageController) {
            self.page = p
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = page.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return page.controllers.last
            }
            return page.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = page.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == page.controllers.count - 1 {
                return page.controllers.first
            }
            return page.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed, let visableController = pageViewController.viewControllers?.first, let index = page.controllers.firstIndex(of: visableController) {
                page.currentPage = index
            }
        }
    }
}

