//
//  SelectedPointManager.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/7/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import MapKit

class SelectedPointManager: NSObject, ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var selectedPoint: MKAnnotation? {
        willSet { objectWillChange.send() }
    }
    
    override init() {
        super.init()
    }
}
