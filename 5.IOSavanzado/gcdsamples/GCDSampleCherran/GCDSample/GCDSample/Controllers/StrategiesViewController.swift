//
//  StrategiesViewController.swift
//  GCDSample
//
//  Created by hijos on 20/4/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit

class StrategiesViewController: UITableViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // este método se llama antes de que el controlador (destinationVC) cargue sus vistas
        
        guard let identificator = segue.identifier else {
            print("\(segue) has no id")
            return
        }
        
        guard let destinationVC = segue.destination as? DownloadViewController else {
            print("\(segue) has wrong type of destination")
            return
        }
        
        // Es demasiado temprano para usar este método (sus vistas no están cargadas)
        // destinationVC.serialDownload()
        
        // Le paso el segueId al VC y el ya sabe de qué forma tiene que descargar la imagen
        destinationVC.segueId = identificator
    }

}
