//
//  temtem_upApp.swift
//  temtem-up
//
//  Created by Marlon Von Bernales Ansale on 17/03/2023.
//

import SwiftUI

@main
struct temtem_upApp: App {
    private lazy var baseURL = URL(string: "https://temtem-api.mael.tech")!
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
