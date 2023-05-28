//
//  VocabularyApp.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import SwiftUI
import Firebase

@main
struct VocabularyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            VocabBooksView()
        }
    }
}
