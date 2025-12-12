//
//  PullToRefresh.swift
//  SwiftUI-Weather
//
//  Created by Daniel Felipe Martin Franco on 12/2/25.
//
import SwiftUI

struct PullToRefresh: View {
    
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    @State var needRefresh: Bool = false
    
    var body: some View {
        GeometryReader { geo in
                    if (geo.frame(in: .named(coordinateSpaceName)).midY > 50) {
                        Spacer()
                            .onAppear {
                                needRefresh = true
                            }
                    } else if (geo.frame(in: .named(coordinateSpaceName)).midY < 10) {
                        Spacer()
                            .onAppear {
                                if needRefresh {
                                    needRefresh = false
                                    onRefresh()
                                }
                            }
                    }
                    HStack {
                        Spacer()
                        if needRefresh {
                            ProgressView("Refreshing")
                                .foregroundStyle(.white)
                                .scaleEffect(1.1)
                        } else if (geo.frame(in: .named(coordinateSpaceName)).midY > 3) {
                            Text("Pull down to refresh")
                                .foregroundStyle(.white)
                                .animation(.easeInOut(duration: 0.2))
                        }
                        Spacer()
                    }
                }.padding(.top, -80)
    }
}
