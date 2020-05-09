//
//  ContentView.swift
//  PinchMe
//
//  Created by Asge Yohannes on 5/9/20.
//  Copyright © 2020 Asge Yohannes. All rights reserved.
//

import SwiftUI

let DEVICE_SIZE = UIScreen.main.bounds

struct ContentView: View {
    
    @State private var contentMode: ContentMode = .fit
    @State private var scaleAmount: CGFloat = 1.0
    @State private var dragAmount: CGSize = .zero
    
    var body: some View {
        Image("deadpool")
            .resizable()
            .aspectRatio(contentMode: contentMode)
            .frame(maxWidth: DEVICE_SIZE.width, maxHeight: DEVICE_SIZE.height / 2)
            .offset(dragAmount)
            .scaleEffect(scaleAmount)
            .onTapGesture(count: 2) {
                withAnimation(.spring()) {
                    (self.contentMode == .fit) ?
                        (self.contentMode = .fill) :
                        (self.contentMode = .fit)
                }
        }
        .gesture(
            MagnificationGesture(minimumScaleDelta: 0.05)
                .onChanged { self.scaleAmount = $0 }
                .onEnded { _ in
                    withAnimation(.spring()) {
                        self.scaleAmount = 1.0
                        self.dragAmount = .zero
                    }
            }
        .simultaneously(with:
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in withAnimation(.spring()) {
                    self.scaleAmount = 1.0
                    self.dragAmount = .zero
                    }
                }
            )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
