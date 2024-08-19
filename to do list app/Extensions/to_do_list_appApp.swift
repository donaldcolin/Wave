//
//  to_do_list_appApp.swift
//  to do list app
//
//  Created by Donald Colin on 13/08/24.
//

import SwiftUI
import FirebaseCore

@main
struct to_do_list_appApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
