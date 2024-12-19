//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Jasper Tan on 12/12/24.
//

import SwiftUI
import SwiftData

    @main
    struct BookwormApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
            .modelContainer(for: Book.self)
        }
    }
