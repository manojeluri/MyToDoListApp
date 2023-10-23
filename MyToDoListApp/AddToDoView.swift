//
//  AddToDoView.swift
//  MyToDoListApp
//
//  Created by Manoj Eluri on 10/19/23.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State var toDoTitle = ""
    @FocusState var titleFocus: Bool
    
    var body: some View {
        VStack{
            TextField("Buy Cheese", text: $toDoTitle)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .focused($titleFocus)
                .submitLabel(.go)
                .onSubmit {
                    addToDo()
                }
                .toolbar{
                    Button(action:{
                        addToDo()
                    }){
                        Text("Add to List")
                    }
                }
            Spacer()
        }
        .onAppear{
            titleFocus = true
        }
        
    }
    
    func addToDo(){
        let newToDo = ToDo(context: viewContext)
        newToDo.title = toDoTitle
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        toDoTitle = ""
    }
}

#Preview {
    NavigationView{
        AddToDoView()
    }
}
