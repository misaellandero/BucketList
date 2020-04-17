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
  @State private var locations = [CodableMKPointAnnotation]()
  @State private var selectedPlace: MKPointAnnotation?
  @State private var showingPlaceDetails = false
  @State private var showingEditaScreen = false
    var body: some View {
        ZStack {
            if isUnlook {
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
                                let newLocation = CodableMKPointAnnotation()
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
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            
            
            
        }
        .alert(isPresented: $showingPlaceDetails){
            Alert(title: Text(selectedPlace?.title ?? "Desconocido"), message: Text(selectedPlace?.subtitle ?? "Informacion del lugar desconocida"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Editar")){
                self.showingEditaScreen = true
            })
        }
        .sheet(isPresented: $showingEditaScreen, onDismiss: SaveData){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: LoadData /*,authenticate*/)
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func LoadData(){
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
       do{
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func SaveData() {
         do {
               let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
               let data = try JSONEncoder().encode(self.locations)
               try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
           } catch {
               print("Unable to save data.")
           }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
