//
//  MapView.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 02/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotattion: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotattion, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "CMDX"
        annotation.subtitle = "Capital de México"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 19, longitude: -99)
        mapView.addAnnotation(annotation)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
