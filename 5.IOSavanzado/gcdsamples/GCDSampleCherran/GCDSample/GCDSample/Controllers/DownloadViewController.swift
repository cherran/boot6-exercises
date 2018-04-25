//
//  DownloadViewController.swift
//  GCDSample
//
//  Created by cherran on 20/4/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit


// Tenemos que mapear segueID -> RemoteImage -> Método
extension RemoteImages{
    static func imageCase(forSegueId segueId: String)-> RemoteImages{
        let result : RemoteImages
        
        switch segueId {
        case "secuencialCazurro":
            result = .danny
            
        case "concurrenteBurro":
            result = .missandei
            
        case "concurrenteCorrecto":
            result = .olenna
            
        case "concurrenteEspabilao":
            result = .cersei
            
        case "asyncImage":
            result = .wrongURLString
            
        default:
            result = .wrongURLString
        }
        
        return result
    }
}



class DownloadViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var segueId: String = "" // Identificador del segue
    
    
    // MARK: - Life cycle of view
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubview(toFront: activityIndicator)
        print("View did load")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View did appear")
        
        
        // Según el idSegue lanzamos una estrategia u otra
        switch RemoteImages.imageCase(forSegueId: segueId) {
        case .danny:
            serialDownload()
        case .missandei:
            concurrentKludge()
        case .olenna:
            correctConcurrent()
        case .cersei:
            smartConcurrent(url: RemoteImages.url(.cersei)!) { image in
                self.imageView.image = image
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
            
        default: // AsyncImage
            
            // Gestión UI
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()

            
            let placeHolder = UIImage(named:"no-thumbnail.png")!
            _ = AsyncImage(placeholderImage: placeHolder,
                                      remoteUrl: RemoteImages.url(.wrongURLString)!,
                                      completion: { (img) in
                                        // Display the new image (downloaded)
                                        self.imageView.image = img
                                        
                                        // Paro y escondo el ActivityIndicator
                                        self.activityIndicator.isHidden = true
                                        self.activityIndicator.stopAnimating()
                                      }
            )
            
            // Mientras no se ha descargado la imagen, mostar el placeholder
            self.imageView.image = placeHolder
        }
    }
    
    
    
    // MARK: - Estrategias
    
    func serialDownload() { // Secuencia cazurro
        
        // Gestión UI
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        // Descarga de la imagen
        if let url = RemoteImages.url(.danny),
            let imgData = try? Data(contentsOf: url), // Esta línea de código es la que bloquea (imagen grande)
            let image = UIImage(data: imgData)
        {
            self.imageView.image = image
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    
    func concurrentKludge() {
        // Gestión UI
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Descarga de la imagen
        DispatchQueue(label: "dev.cherran.concurrent").async {
            if let url = RemoteImages.url(.missandei),
                let imgData = try? Data(contentsOf: url),
                let image = UIImage(data: imgData)
            {
                self.imageView.image = image
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    func correctConcurrent() {
        // Gestión UI
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // Descarga de la imagen
        DispatchQueue(label: "dev.cherran.concurrent").async {
            if let url = RemoteImages.url(.olenna),
                let imgData = try? Data(contentsOf: url),
                let image = UIImage(data: imgData)
            {
                DispatchQueue.main.async { // UIImageView.image must be used from main thread only
                    self.imageView.image = image
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    
    typealias UIImageTask = (UIImage) -> ()
    
    func smartConcurrent(url: URL, completion: @escaping UIImageTask) {
        
        // No sé desde qué cola me llaman, pero sé que el manejo de la UI tiene que ser en primer plano
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            
            // Me voy a segundo plano, y voy a aprovechar una de las colas del sistema
            DispatchQueue.global(qos: .default).async {
                // Ya estoy en segundo plano
                if let imgData = try? Data(contentsOf: url),
                    let image = UIImage(data: imgData) {
                    // No tengo ni idea de los que hará con la imagen la clausura de finalización, pero por si las moscas lo hago siempre en primer plano (vuelvo a él desde un segundo plano así de fácil:
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
    }
}







