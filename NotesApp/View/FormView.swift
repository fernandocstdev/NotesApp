//
//  FormView.swift
//  NotesApp
//
//  Created by Fernando Dorantes on 04/12/23.
//

import SwiftUI

struct FormView: View {
	
	@ObservedObject var model : ViewModel
	@Environment(\.managedObjectContext) var context
	
    var body: some View {
		VStack{
			Text("Add note")
				.font(.largeTitle)
				.bold()
			List{
				Section("Title"){
					TextField("Title", text: $model.title)
				}
				Section("Description"){
					TextField("Description", text: $model.body)
				}
				Section("Description"){
					DatePicker("Date", selection: $model.date)
				}
				Button(action:{
					if model.updateItem != nil{
						model.editNote(context: context)
					} else{
						model.createNote(context: context)
					}
				}){
					if model.updateItem != nil{
						Label(
							title: { Text("Update").foregroundColor(.white).bold() },
							icon: { Image(systemName: "pencil").foregroundColor(.white) }
						)
					}else{
						Label(
							title: { Text("Save").foregroundColor(.white).bold() },
							icon: { Image(systemName: "plus").foregroundColor(.white) }
						)
					}
				}
				.padding()
				.frame(width:UIScreen.main.bounds.width - 30)
				.background(Color.blue)
				.cornerRadius(14)
			}
		}.padding()
    }
}
