
//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 10/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import MapKit
extension MKPointAnnotation: ObservableObject{
    public var wrappedTitle: String {
        get {
            self.title ?? "Desconocido"
        }
        
        set {
            title = newValue
        }
    }
    
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "desconocido"
        }
        
        set {
            subtitle =  newValue
        }
    }
}
