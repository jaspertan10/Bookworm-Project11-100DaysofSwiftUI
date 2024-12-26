//
//  AddBookView.swift
//  Bookworm
//
//  Created by Jasper Tan on 12/13/24.
//

import SwiftUI


struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
   
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Select Genre"
    @State private var review = ""
    
    @State private var missingEntriesAlert = false
    
    let genres = ["Select Genre", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        if (validateBookEntry == true) {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                        else {
                            missingEntriesAlert = true
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Missing Details:", isPresented: $missingEntriesAlert) {
                Button("OK") {}
            } message: {
                Text(formulateAlertMessage)
            }

        }
    }
    
    var formulateAlertMessage: String {
        
        var alertMessage = ""
        
        if title.isEmpty {
            alertMessage.append("Title\n")
        }
        if author.isEmpty {
            alertMessage.append("Author\n")
        }
        if genre == genres[0] {
            alertMessage.append("Genre\n")
        }
        
        return alertMessage
        
    }
    
    
    var validateBookEntry: Bool {
        if (title.isEmpty || author.isEmpty || genre == genres[0]) {
            return false
        }
        
        return true
    }
}

#Preview {
    AddBookView()
}
