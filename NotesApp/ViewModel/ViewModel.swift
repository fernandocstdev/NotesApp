//
//  ViewModel.swift
//  NotesApp
//
//  Created by Fernando Dorantes on 04/12/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject{
	@Published var title = ""
	@Published var body = ""
	@Published var date = Date()
	@Published var isOpenModal = false
	@Published var updateItem : Note!
	
	// core data
	func createNote(context: NSManagedObjectContext){
		let newNote = Note(context: context)
		newNote.title = title
		newNote.body = body
		newNote.date = date
		
		do{
			try context.save()
			print("Guardo correctamente")
			isOpenModal.toggle()
		} catch let error as NSError{
			print("No guardo", error.localizedDescription)
		}
	}
	
	func deleteNote(item: Note, context: NSManagedObjectContext){
		context.delete(item)
		
		try! context.save()
		
		do{
			try context.save()
			print("Eliminado")
		} catch let error as NSError{
			print("No elimino", error.localizedDescription)
		}
	}
	
	func sendData(item: Note){
		updateItem = item
		title = item.title ?? ""
		body = item.body ?? ""
		date = item.date ?? Date()
		
		isOpenModal.toggle()
	}
	
	func editNote(context: NSManagedObjectContext){
		updateItem.date = date
		updateItem.title = title
		updateItem.body = body
		
		do{
			try context.save()
			print("Editado")
		} catch let error as NSError{
			print("No guardo", error.localizedDescription)
		}
	}
}
