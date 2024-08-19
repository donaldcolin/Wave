//
//  Tabbarview.swift
//  to do list app
//
//  Created by Donald Colin on 13/08/24.
//

import SwiftUI

struct Tabbarview: View {
    var body: some View {
        TabView{
            mainhomeview()
                .tabItem {Image(systemName:"house")}
          ProfileView()
                .tabItem {Image(systemName:"plus")}
        }
    }
}

#Preview {
    Tabbarview()
}
