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
    typealias CreateAction = (Word, Information) async throws -> Void
    
    let createAction: CreateAction
    @State private var state = FormState.idle
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var book: VocabularyBook
    @State private var word = Word()
    
    @State private var defs: String = ""
    @State private var poss: String = ""
    @State private var exs: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
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
                    createWord()
                }, label: {
                    Text("Save")
                })
//                    .onSubmit(createWord)
            )
        }
    }
    
    private func saveWord() {
        print("at saveWord func")
        let info = Information(defs: defs, poss: poss, exs: exs)
        book[word] = info
        presentationMode.wrappedValue.dismiss()
    }
    
    private func createWord() {
        Task {
            state = .working
            do {
                print("at Task in createWord")
                let info = Information(defs: defs, poss: poss, exs: exs)
                try await createAction(word, info)
                dismiss()
            } catch {
                print("[CreateWordView] Cannot create word: \(error)")
                state = .error
            }
        }
    }

}

// MARK: - FormState

private extension CreateWordView {
    enum FormState {
        case idle, working, error
        
        var isError: Bool {
            get {
                self == .error
            }
            set {
                guard !newValue else { return }
                self = .idle
            }
        }
    }
}


struct CreateWordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateWordView(createAction: { _,_  in })
        }.environmentObject(VocabularyBook())
    }
}

