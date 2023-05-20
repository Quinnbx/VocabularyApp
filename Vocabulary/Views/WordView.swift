//
//  WordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/9/23.
//

import SwiftUI
import SafariServices
import UIKit

struct WebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Nothing to do
    }
}

struct EditableField: View {
    var label: String
    var value: String
    @Binding var editedValue: String
    @Binding var isEditing: Bool
    var buttonImage: String? = nil
    var buttonAction: (() -> Void)? = nil

    var body: some View {
        Section(header: Text(label)) {
            HStack {
                if isEditing {
                    TextField(label, text: $editedValue)
                } else {
                    Text(value)
                    Spacer()
                    if let image = buttonImage, let action = buttonAction {
                        Button(action: action) {
                            Image(systemName: image)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}

struct WordView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var index: Int
    @State private var showWebpage = false

    private var word: Word {
        Array(book.words.keys)[index]
    }

    @State var isEditing = false
    @State var editedName = ""
    @State var editedDef = ""
    @State var editedPos = ""
    @State var editedEx = ""

    init(index: Int) {
        _index = State(initialValue: index)
    }

    var body: some View {
        Form {
            EditableField(label: "Word", value: word.name, editedValue: $editedName, isEditing: $isEditing, buttonImage: "doc.on.doc", buttonAction: {
                UIPasteboard.general.string = word.name
            })
            EditableField(label: "Definitions", value: book[word].getDefinitions(), editedValue: $editedDef, isEditing: $isEditing)
            EditableField(label: "Part of Speech", value: book[word].getPOSs(), editedValue: $editedPos, isEditing: $isEditing)
            EditableField(label: "Examples", value: book[word].getExamples(), editedValue: $editedEx, isEditing: $isEditing)
            HStack {
                if let url = URL(string: "https://www.oxfordlearnersdictionaries.com/us/") {
                    Button(action: {
                        showWebpage = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Oxford Dictionary")
                            .font(.system(size: 10))
                    }
                    .sheet(isPresented: $showWebpage) {
                        WebView(url: url)
                    }
                }
                if let url = URL(string: "https://www.thesaurus.com/") {
                    Button(action: {
                        showWebpage = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Synonyms")
                            .font(.system(size: 10))
                    }
                    .sheet(isPresented: $showWebpage) {
                        WebView(url: url)
                    }
                }
            }
        }
        .navigationBarItems(trailing:
            HStack {
                Button(action: favoriteAction) {
                    Image(systemName: word.favorite ? "heart.fill" : "heart")
                }
                .foregroundColor(word.favorite ? .red : .gray)

                isEditing ?
                    Button("Save", action: saveAction) :
                    Button("Edit", action: editAction)
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
        }
        .onAppear(perform: setupEditedValues)
    }
    
    private func setupEditedValues() {
        editedName = word.name
        editedDef = book[word].getDefinitions()
        editedPos = book[word].getPOSs()
        editedEx = book[word].getExamples()
    }

    private func saveAction() {
        let newWord = Word(name: editedName, favorite: word.favorite)
        var newInfo = book[word]
        newInfo.setDefinitions(editedDef)
        newInfo.setPOSs(editedPos)
        newInfo.setExamples(editedEx)

        if editedName != word.name {
            book.words.removeValue(forKey: word)
            book[newWord] = newInfo
            if let newIndex = Array(book.words.keys).firstIndex(of: newWord) {
                index = newIndex
            }
        } else {
            book[word] = newInfo
        }

        isEditing = false
    }

    private func favoriteAction() {
        var updatedWord = word
        updatedWord.favorite.toggle()
        book.rename(oldWord: word, newWord: updatedWord)
        if let newIndex = Array(book.words.keys).firstIndex(of: updatedWord) {
            index = newIndex
        }
    }

    private func editAction() {
        isEditing = true
    }
}


struct WordView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleWord = Word(name: "example")
        let sampleInfo = Information(defs: "a representative or illustrative instance", poss: "noun", exs: "This is an example of a sentence.")
        let sampleBook = VocabularyBook()
        sampleBook.add(word: sampleWord, info: sampleInfo)
        return NavigationView {
            WordView(index: 0)
                .environmentObject(sampleBook)
        }
    }
}


