//
//  Views+Extensions.swift
//  to do list app
//
//  Created by Donald Colin on 14/08/24.
import SwiftUI

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    func offsetX(_ offsetX: @escaping (CGFloat) -> Void) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear.preference(key: OffsetPreferenceKey.self, value: proxy.frame(in: .global).minX)
            }
        )
        .onPreferenceChange(OffsetPreferenceKey.self, perform: offsetX)
    }
    
    func onScrollStopped(perform action: @escaping (CGFloat) -> Void) -> some View {
        self.modifier(ScrollStopModifier(onScrollStopped: action))
    }
}

struct ScrollStopModifier: ViewModifier {
    @State private var lastOffset: CGFloat = 0
    let onScrollStopped: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if lastOffset != offset {
                    lastOffset = offset
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        if lastOffset == offset {
                            onScrollStopped(offset)
                        }
                    }
                }
            }
    }
}

    


