//
//  AppDelegate.swift
//  Mementos
//
//  Created by hijos on 21/4/18.
//  Copyright © 2018 Carlos de la Herrán. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        // Leemos la base de datos
//        initCoreData()
        
        // Trasteamos con objetos
        // trastearConCoreData()
        
        // Añado datos de ejemplo
        addDummyData()
        
        
        return true
    }

}

