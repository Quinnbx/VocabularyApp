//
//  VocabularyApp.swift
//  Vocabulary
//
//  Created by Baiqi Xing on 4/7/23.
//

import SwiftUI
//import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct VocabularyApp: App {
//    init() {
//        FirebaseApp.configure()
//    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            BooksView()
        }
    }
}
