//
//  ZoneStore.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/8/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

class ZoneStore: ObservableObject {
    @Published var zones: [InfectionZoneAnnotation] = zonesData
}


class InfectionZoneAnnotation: NSObject, MKAnnotation {
    let id = UUID()
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let radius: Double
    
    let reports: Int
    let confirmed: Int
    let deaths: Int
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D, radius: Double, reports: Int, confirmed: Int, deaths: Int) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.radius = radius
        self.reports = reports
        self.confirmed = confirmed
        self.deaths = deaths
    }
}

let zonesData = [
    InfectionZoneAnnotation(title: "Harlem", subtitle: "1 Confirmed Case", coordinate: CLLocationCoordinate2D(latitude: 40.8116, longitude: -73.9465), radius: 1000, reports: 5, confirmed: 1, deaths: 0),
    InfectionZoneAnnotation(title: "Midtown", subtitle: "4 Confirmed Case", coordinate: CLLocationCoordinate2D(latitude: 40.7549, longitude: -73.9840), radius: 5000.0, reports: 10, confirmed: 4, deaths: 1),
    InfectionZoneAnnotation(title: "Midtown", subtitle: "2 Confirmed Case", coordinate: CLLocationCoordinate2D(latitude: 40.7081, longitude: -73.9571), radius: 3000.0, reports: 20, confirmed: 2, deaths: 0)
]
