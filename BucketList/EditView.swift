
//
//  EditView.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 10/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//
import MapKit
import SwiftUI

struct EditView: View {
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Titulo", text: $placemark.wrappedTitle)
                    TextField("Subtitulo", text: $placemark.wrappedSubtitle)
                }
            .navigationBarTitle("Editar marcador")
                .navigationBarItems(leading: Button("Listo"){
                    self.presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
