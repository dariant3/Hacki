//
//  HackiApp.swift
//  Hacki
//
//  Created by Darian Tichler on 2022-03-13.
//

import SwiftUI
import Firebase
@main
struct HackiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(LoginViewModel())
                .environmentObject(UserViewModel())
                .environmentObject(SessionViewModel())
                //.environmentObject(ProfileViewModel())
                .environmentObject(LocationViewModel())
                //.environmentObject(SessionPlayViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
