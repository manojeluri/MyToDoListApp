//
//  ToDoListView.swift
//  MyToDoListApp
//
//  Created by Manoj Eluri on 10/19/23.
//

import SwiftUI

struct ToDoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.title, ascending: true)],
        animation: .default)
    private var toDos: FetchedResults<ToDo>
    var body: some View {
        NavigationView{
            List{
                ForEach (toDos){listedToDo in
                    NavigationLink(destination: Text(listedToDo.title ?? "Error")
                        .font(.largeTitle)
                        .padding()){
                            Text(listedToDo.title ?? "Error")
                            .lineLimit(1)
                    }
                
                }
                .onDelete(perform: deleteItems)
            }
                .navigationTitle("Quick ToDos")
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: AddToDoView()) {
                            Label("Add Item", systemImage: "plus.circle.fill")
                        }
                    }
                }
        }
        

        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { toDos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

#Preview {
    ToDoListView()
}
