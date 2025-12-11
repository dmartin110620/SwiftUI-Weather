//
//  PagingScrollView.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 12/6/25.
//


import SwiftUI

struct PagingScrollView<Content: View>: UIViewRepresentable {
    var pages: [Content]
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.delegate = context.coordinator
        return scrollView
    }

    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        context.coordinator.update(scrollView: scrollView)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: PagingScrollView
        var hosts: [UIHostingController<Content>] = []

        init(_ parent: PagingScrollView) {
            self.parent = parent
        }

        func update(scrollView: UIScrollView) {
            // Remove old views
            scrollView.subviews.forEach { $0.removeFromSuperview() }
            hosts.removeAll()

            let width = scrollView.bounds.width
            let height = scrollView.bounds.height
            
            for (i, page) in parent.pages.enumerated() {
                let host = UIHostingController(rootView: page)
                host.view.frame = CGRect(
                    x: CGFloat(i) * width,
                    y: 0,
                    width: width,
                    height: height
                )
                scrollView.addSubview(host.view)
                hosts.append(host)
            }

            scrollView.contentSize = CGSize(
                width: width * CGFloat(parent.pages.count),
                height: height
            )

            let x = CGFloat(parent.currentPage) * width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
            parent.currentPage = page
        }
    }
}
