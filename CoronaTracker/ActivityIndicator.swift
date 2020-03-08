//
//  ActivityIndicator.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/8/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
