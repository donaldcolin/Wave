//
//  ContentView.swift
//  to do list app
//
//  Created by Donald Colin on 13/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    

    var body: some View {

            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
              Tabbarview()
            } else {
               Loginview()
        }
    }
}

#Preview {
    ContentView()
}
