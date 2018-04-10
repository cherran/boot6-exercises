//
//  DownloadImgOperation.swift
//  ClosureAndGCD
//
//  Created by Carlos de la Herrán Martín on 9/4/18.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

class DownloadImgOperation: Operation {
    
    let urlString: String
    var imageClosure: ((Bool, UIImage?, Error?) -> Void)?
    
    // "Chapuza" para que la DownloadImageOperation no acabe antes de que la imagen se haya descargado
    var end = false
    override var isFinished: Bool {
        return end
    }
    
    init(urlString: String) {
        self.urlString = urlString
        super.init()
    }
    
    // Aquí introducimos la operación en sí
    override func main() {
        if let endClosure = imageClosure {
            let url = URL(string: urlString)
            
            let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: // Utilizo la URLSession por defecto
               { (data, urlResponse, error) in
                    if let imgData = data {
                        endClosure(true, UIImage(data: imgData), nil)
                    } else {
                        endClosure(false, nil, error)
                    }
                
                // "Chapuza" para que la DownloadImageOperation no acabe antes de que la imagen se haya descargado
                self.willChangeValue(forKey: "isFinished") // KVO.
                self.end = true
                _ = self.isFinished
                self.didChangeValue(forKey: "isFinished")   // KVO
            })
            
            // Arranco la tarea
            dataTask.resume()
        }
    }
}
