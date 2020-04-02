//
//  ContentView.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 01/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI
struct User: Identifiable, Comparable {
    var id = UUID()
    var name: String
    var lastName: String
    
    static func < (lhs: User, rhs: User ) -> Bool {
        lhs.lastName < rhs.lastName
    }
}
struct ContentView: View {
    let users = [
        User(name:"Jacky", lastName: "Ruiz"),
        User(name:"Vianney", lastName: "Pacheco"),
        User(name:"Nadia", lastName: "Nicacio"),
    ].sorted()
    var body: some View {
        List(users){ user in
            Text("\(user.name) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
