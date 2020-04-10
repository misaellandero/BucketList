//
//  ContentView.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 01/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
  @State private var isUnlook = false
  @State private var centerCoordinate = CLLocationCoordinate2D()
  @State private var locations = [MKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditaScreen = false
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations).edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack{
                Spacer()
                HStack{
                        Spacer()
                        Button(action: {
                            let newLocation = MKPointAnnotation()
                            newLocation.title = "Locación de ejemplo"
                            newLocation.coordinate =  self.centerCoordinate
                            self.locations.append(newLocation)
                            
                            self.selectedPlace = newLocation
                            self.showingEditaScreen = true
                        }){
                            Image(systemName: "plus")
                        }
                    .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails){
            Alert(title: Text(selectedPlace?.title ?? "Desconocido"), message: Text(selectedPlace?.subtitle ?? "Informacion del lugar desconocida"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Editar")){
                self.showingEditaScreen = true
            })
        }
        .sheet(isPresented: $showingEditaScreen){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    .onAppear(perform: authenticate)
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let  reason = "Desbloquea para ver tus datos"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) {
                success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlook = true
                    } else {
                    //hubo un problema
                    }
                }
            }
        } else {
            // sin biometricos
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
