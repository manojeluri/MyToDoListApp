//
//  MyToDoListAppApp.swift
//  MyToDoListApp
//
//  Created by Manoj Eluri on 10/19/23.
//

import SwiftUI

@main
struct MyToDoListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
