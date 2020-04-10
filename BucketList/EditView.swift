
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
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages =  [Page]()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Datos del marcador")) {
                    TextField("Titulo", text: $placemark.wrappedTitle)
                    TextField("Subtitulo", text: $placemark.wrappedSubtitle)
                }
                
                Section(header: Text("Lugares cercanos")) {
                    if loadingState == .loaded{
                        List(pages, id: \.pageid ){ page in
                            Image(systemName: "mappin.and.ellipse")
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                                Text(page.description )
                            .italic()
                        }
                    } else if loadingState == . loading {
                        Text("Cargando")
                    } else {
                        Text("Error, intente despues.")
                    }
                }
                
            }.onAppear(perform: loadNearPlaces)
            .navigationBarTitle("Editar marcador")
            .navigationBarItems(leading: Button("Listo"){
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    func loadNearPlaces(){
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        
        guard let url = URL(string: urlString) else {
            print("URL incorrecta: \(urlString)")
            return
        }
        
        URLSession.shared.dataTask(with: url){ data , response, error in
            
            if let data = data {
                
                let decoder = JSONDecoder()
                
                if let items = try? decoder.decode(Result.self, from: data) {
                    self.pages = Array(items.query.pages.values).sorted()
                self.loadingState = .loaded
                return
                }
                
            }
            
            self.loadingState = .failed
            
        }.resume()
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
