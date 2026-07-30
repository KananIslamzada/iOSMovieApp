//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Kanan Islamzada on 27.07.26.
//

import SwiftUI
import SwiftData

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for:Title.self)
    }
}
