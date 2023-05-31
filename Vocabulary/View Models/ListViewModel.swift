//
//  WordsViewModel.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 5/30/23.
//

import Foundation

@MainActor
class ListViewModel: ObservableObject {
//    @Published var words = [Post.testPost]
    @Published var book = VocabularyBook.testVocabBook
    
    func makeCreateAction() -> CreateWordView.CreateAction {
        print("at makeCreateAction")
        return { [weak self] word, info  in
            try await CollectionRepository.create(word, info)
            self?.book[word] = info
//            self?.posts.insert(word, at: 0)
//            if let book = self?.book {
//                book[word] = info
//            }
        }
    }
}
