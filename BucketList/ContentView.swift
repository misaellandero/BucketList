//
//  ContentView.swift
//  BucketList
//
//  Created by Francisco Misael Landero Ychante on 01/04/20.
//  Copyright © 2020 Francisco Misael Landero Ychante. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Cargando...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Exitoso...")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Fallado...")
    }
}

struct ContentView: View {
    enum LoadingState {
        case loading, success, failed
    }
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
