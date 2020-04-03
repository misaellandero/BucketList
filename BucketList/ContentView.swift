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
    var body: some View {
        VStack {
            if self.isUnlook {
                MapView()
                           .edgesIgnoringSafeArea(.all)
            } else {
                Text("Bloqueado")
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
