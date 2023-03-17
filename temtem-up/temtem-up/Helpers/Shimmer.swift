//
//  Shimmer.swift
//  temtem-up
//
//  Created by Marlon Von Bernales Ansale on 17/03/2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(withConfig config: ShimmerConfig) -> some View {
        self.modifier(ShimmerEffectHelper(config: config))
    }
}

fileprivate struct ShimmerEffectHelper: ViewModifier {
    var config: ShimmerConfig
    @State private var moveTo: CGFloat = -0.5
    
    func body(content: Content) -> some View {
        content
            .hidden()
            .background {
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }.overlay {
                        GeometryReader {
                            let size = $0.size
                            
                            Rectangle()
                                .fill(.linearGradient(colors: [
                                    .white.opacity(0),
                                    config.highlight.opacity(config.highlightOpacity),
                                    .white.opacity(0)
                                ], startPoint: .top, endPoint: .bottom)
                                )
                                .blur(radius: config.blur)
                                .rotationEffect(.init(degrees: -70))
                                .offset(x: size.width * moveTo)
                        }
                    }
                    .mask {
                        content
                    }
            }.onAppear {
                moveTo = 0.7
            }.animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
    }
}

struct ShimmerConfig {
    let tint: Color
    let highlight: Color
    var blur: CGFloat = 0
    var highlightOpacity: CGFloat = 1
    var speed: CGFloat = 1
}

struct ShimmerView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
