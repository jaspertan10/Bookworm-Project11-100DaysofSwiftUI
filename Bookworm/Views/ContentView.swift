//
//  ContentView.swift
//  Bookworm
//
//  Created by Jasper Tan on 12/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Book.title) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {

            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    deleteBooks(at: indexSet)
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        
        //IndexSet is a collection of integer indices
        
        //for loop iterates through each index in the IndexSet, and deletes it from our modelContext
        for offset in offsets {
            let book = books[offset]
            
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
