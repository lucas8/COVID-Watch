//
//  NearbyHospitalManager.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/7/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import Foundation
import Combine
import MapKit

class NearbyHospitalManager: NSObject, ObservableObject {
    @ObservedObject var sp = SelectedPointManager()
    let defaultCoords = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
    let objectWillChange = PassthroughSubject<Void, Never>()
    
     @Published var hospitals: [String] = [] {
       willSet { objectWillChange.send() }
     }
    
    override init() {
        super.init()
        
        getHospitals(coords: sp.selectedPoint?.coordinate ?? defaultCoords, completionHandler: { value in
            for hospital in value!.prefix(5) {
                self.hospitals.append(hospital.name ?? "nil")
            }
        })
    }
    
    private func getHospitals(coords: CLLocationCoordinate2D, completionHandler: @escaping ([MKMapItem]?) -> Void ) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "hospital"

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

        request.region = MKCoordinateRegion(center: coords, span: span)
        
        let localSearch = MKLocalSearch(request: request)
        localSearch.start {response, err in
            if err == nil {
                completionHandler(response?.mapItems)
            } else {
                completionHandler(nil)
            }
        }
    }
}
