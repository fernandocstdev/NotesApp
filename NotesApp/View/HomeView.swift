//
//  HomeView.swift
//  NotesApp
//
//  Created by Fernando Dorantes on 04/12/23.
//

import SwiftUI

struct HomeView: View {
	@StateObject var model = ViewModel()
	@Environment(\.managedObjectContext) var context
	@FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)], animation: .snappy()) var results : FetchedResults<Note>
	
    var body: some View {
		NavigationView {
			List{
				ForEach(results) { item in
					VStack(alignment: .leading){
						Text(item.title ?? "Sin nota")
							.font(.title)
							.bold()
						Text(item.date ?? Date(), style: .date)
					}.contextMenu(ContextMenu(menuItems: { // contextMenu abre un menu al dar click largo en el item 
						Button(action:{
							model.sendData(item: item)
						}){
							Label(title:{ Text("Edit")}, icon:{ Image(systemName: "pencil")})
						}
						Button(action:{
							model.deleteNote(item: item, context: context)
						}){
							Label(title:{ Text("Delete")}, icon:{ Image(systemName: "trash")})
						}
					}))
				}
			}.navigationTitle("Notas")
			.toolbar{
				Button(action:{
					model.isOpenModal.toggle()
				}){
					Text("+")
				}
			}
			.sheet(isPresented: $model.isOpenModal, content: {
				FormView(model: model)
			})
		}
    }
}
