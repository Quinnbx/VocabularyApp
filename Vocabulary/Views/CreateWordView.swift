//
//  ModifyWordView.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/14/23.
//

// isValid check
// Views shouldn’t communicate directly with the model.
import SwiftUI

struct CreateWordView: View {
    @EnvironmentObject var book: VocabularyBook
    @State private var word = Word()
    
    @State private var defs: String = ""
    @State private var poss: String = ""
    @State private var exs: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            NavigationView{
                Form {
                    TextField("Word", text: $word.name)
                    
                    Section(header: Text("Definitions")) {
                        TextField("Definitions", text: $defs)
                    }
                    
                    Section(header: Text("Part of Speech")) {
                        TextField("Part of Speech", text: $poss)
                    }
                    
                    Section(header: Text("Examples")) {
                        TextField("Examples", text: $exs)
                    }
                }
                .navigationBarTitle("Create Word")
                .navigationBarItems(trailing:
                    Button(action: {
                        saveWord()
                    }, label: {
                        Text("Save")
                    })
                )
            }
        }
    }
    
    private func saveWord() {
        let info = Information(defs: defs, poss: poss, exs: exs)
        book[word] = info
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateWordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateWordView()
        }.environmentObject(VocabularyBook())
    }
}

