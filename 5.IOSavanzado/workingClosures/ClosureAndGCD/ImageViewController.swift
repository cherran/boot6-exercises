//
//  ImageViewController.swift
//  ClosureAndGCD
//
//  Created by Joaquin Perez on 05/03/2018.
//  Copyright © 2018 Joaquin Perez. All rights reserved.
//

import UIKit

typealias nothingToNothing = () -> Void

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let operationQueue = OperationQueue()
    let mainOperationQueue = OperationQueue.main // En el main thread
    
    var img1: UIImage?
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.imageView1.image = self.img1
//            }
//        }
//    }
    
    
    var img2: UIImage?
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.imageView2.image = self.img2
//            }
//        }
//    }
    
    
    var img3: UIImage?
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.imageView3.image = self.img3
//            }
//        }
//    }
    

    
    var img4: UIImage?
//    {
//        didSet {
//            DispatchQueue.main.async {
//                self.imageView4.image = self.img4
//            }
//        }
//    }
    
    
    var downloadOperation1: DownloadImgOperation!
    var downloadOperation2: DownloadImgOperation!
    var downloadOperation3: DownloadImgOperation!
    var downloadOperation4: DownloadImgOperation!
    
    
    //    "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg"
    //    "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg"
    //    "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg"
    //    "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg"
    //    "http://www.open.ac.uk/earth-research/tindle/AGT/AGT_Home_2010/NASA_Apollo_1_files/Astronaut.jpg"
    //    "http://danielmarin.naukas.com/files/2016/10/Rosetta_s_comet-580x580.jpg"
    //    "http://danielmarin.naukas.com/files/2014/07/Captura-de-pantalla-2014-07-22-a-las-23.48.56.png"
    //    "https://static01.nyt.com/newsgraphics/2017/09/14/cassini-saturn-images/assets/images/huygens-PIA07232-320.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadOperation1 = DownloadImgOperation(urlString: "http://c8.alamy.com/comp/KA3NBR/expo92-district-in-seville-sevilla-spain-white-bioclimatic-sphere-KA3NBR.jpg")
        
        downloadOperation1.imageClosure = {(success: Bool, image: UIImage?, error: Error?) in
            if success {
                self.img1 = image!
            } else {
                print(error!)
            }
        }
        
        
        downloadOperation2 = DownloadImgOperation(urlString: "https://www.ecestaticos.com/image/clipping/939/56c9f8853cafb0265da40eb3478269a4/expo.jpg")
        
        downloadOperation2.imageClosure = { [unowned self] (success, image, error) in
            if (success) {
                self.img2 = image!
            } else {
                print(error!)
            }
        }

        
        downloadOperation3 = DownloadImgOperation(urlString: "http://www.hanedanrpg.com/photos/hanedanrpg/12/55932.jpg")
        
        downloadOperation3.imageClosure = { [unowned self] (success, image, error) in
            if (success) {
                self.img3 = image!
            } else {
                print(error!)
            }
        }
        
        
        downloadOperation4 = DownloadImgOperation(urlString: "http://www.alpha-exposiciones.com/wp-content/uploads/2018/03/marathonweek_expo15_mm-106_r1.jpg")
        
        downloadOperation4.imageClosure = { [unowned self] (success, image, error) in
            if (success) {
                self.img4 = image!
            } else {
                print(error!)
            }
        }

        
        
        
    }
    
    
    

    @IBAction func downloadImage(_ sender: Any) {
        
        let button = sender as! UIButton
        
        // Arranco el activityIndicator y desactivo el botón para que no se pueda volver a pulsar
        activityIndicator.startAnimating()
        button.isEnabled = false

        
        let viewOperation1 = BlockOperation {
            self.imageView1.image = self.img1
        }
        
        viewOperation1.addDependency(downloadOperation1)
        
        
        let viewOperation2 = BlockOperation {
            self.imageView2.image = self.img2
        }
        
        viewOperation2.addDependency(downloadOperation2)
        // Queremos que se muestren en orden (1,2,3,4)
        viewOperation2.addDependency(viewOperation1) // Se pueden establecer varias dependencias
        
        
        let viewOperation3 = BlockOperation {
            self.imageView3.image = self.img3
        }
        
        viewOperation3.addDependency(downloadOperation3)
        viewOperation3.addDependency(viewOperation2)
        
        
        let viewOperation4 = BlockOperation {
            self.imageView4.image = self.img4
        }
        
        viewOperation4.addDependency(downloadOperation4)
        viewOperation4.addDependency(viewOperation3)
        
        
        // Añado las operaciones a las colas. Da igual el orden en el que se añadan.
        
        operationQueue.addOperation(downloadOperation4)
        operationQueue.addOperation(downloadOperation3)
        operationQueue.addOperation(downloadOperation2)
        operationQueue.addOperation(downloadOperation1)
        
        // Así estableceríamos un comportamiento de cola serie
        // operationQueue.maxConcurrentOperationCount = 1
        
        // Las operaciones que modifican las vistas deben añadirse a la cola del Main Thread
        mainOperationQueue.addOperations([viewOperation4, viewOperation3, viewOperation2, viewOperation1], waitUntilFinished: false)
        
        // Paro la animación del activityIndicator y vuelvo a activar el botón
        let userViewOperation = BlockOperation {
                self.activityIndicator.stopAnimating()
                button.isEnabled = true
        }
        
        // Lo añadimos como una operación a la cola del main thread, con dependencia de que se haya mostrado la última imagen
        userViewOperation.addDependency(viewOperation4)
        mainOperationQueue.addOperation(userViewOperation)
        
    }
}

