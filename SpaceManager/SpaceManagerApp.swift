//
//  SpaceManagerApp.swift
//  SpaceManager
//
//  Created by Kuba Kromomołowski on 03/04/2024.
//

import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOption launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool{
        
        return true;
    }
}

@main
struct SpaceManagerApp: App {
    
    @StateObject var staySignin = StaySigninViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
         
            if(!staySignin.logged || staySignin.idOfCurrentUser.isEmpty){
                LoginView()
            }else{
                WelcomeView()
            }
            
        }
    }
}
