//
//  MapView.swift
//  CoronaTracker
//
//  Created by Lucas Stettner on 3/6/20.
//  Copyright © 2020 Lucas Stettner. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var lm = LocationManager()
    @Binding var selectedAnnotation: MKAnnotation?
    @State var selectedZone: InfectionZoneAnnotation?
    @ObservedObject var zs = ZoneStore()

    // NYC
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
    
    func makeCoordinator() -> MapViewCoordinator{
         MapViewCoordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        let span = MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25)
        let region = MKCoordinateRegion(center: lm.location?.coordinate ?? defaultCoordinate, span: span)
        view.setRegion(region, animated: true)
        
        // set view delegate as context coordinator
        view.delegate = context.coordinator
        view.addAnnotations(zs.zones)
        
        let compass = MKCompassButton(mapView: view)
        compass.compassVisibility = .visible
        
        // Loops through points and draws circle
        for zone in zs.zones {
            let circle = MKCircle(center: zone.coordinate, radius: zone.radius)
            view.addOverlay(circle)
        }
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(selectedAnnotation: .constant(nil))
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewController: MapView

    init(_ control: MapView) {
      self.mapViewController = control
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      let circleRenderer = MKCircleRenderer(overlay: overlay)
      circleRenderer.strokeColor = #colorLiteral(red: 0.937254902, green: 0.3058823529, blue: 0.3058823529, alpha: 0.8)
        circleRenderer.fillColor = #colorLiteral(red: 0.937254902, green: 0.3058823529, blue: 0.3058823529, alpha: 0.2)
      circleRenderer.lineWidth = 2.0
      return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotation === mapView.userLocation {
            return nil
        }

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        annotationView?.image = #imageLiteral(resourceName: "pin")
        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let coordinates = view.annotation?.coordinate else { return }
        let span = mapView.region.span
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
        mapViewController.selectedAnnotation = view.annotation
    }
}
