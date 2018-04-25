//
//  AsyncData.swift
//  GCDSample
//
//  Created by Carlos de la Herrán on 21/4/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import UIKit


typealias ImageCompletion = (UIImage) -> ()
let nopCompletion: ImageCompletion = { (_: UIImage) in } // A completion handler that does nothing -> Completion clausure nula


// Esta clase puede accederse desde fuera del módulo en que se encuentra --> frameworks, librerías
open class AsyncImage {
    // class VS struct --> la clase tiene identidad, puede haber dos o más referencias a la misma clase, mientras que siendo struct cada referencia tendría una copia. Si va a tener un protocolo delegado, siempre tiene que ser clase
    
    private var placeholderImage: UIImage
    private let remoteImageURL: URL
    private var localImage: UIImage?
    
    // Cola privada
    private let privateQueue: DispatchQueue
    
    // Clausura de finalización
    private var completion: ImageCompletion
    private weak var delegate : AsyncImageDelegate? // Siempre el delegado como weak, ya que el delegado suele terner una referencia fuerte hacia el "delegador"
    // Todo lo que tenga un delegado debería ser una clase (y no una struct), ya que tienen acceso al heap
    
    var image: UIImage {
        get {
            guard let img = localImage else {
                return placeholderImage
            }
            return img
        }
    }
    
    
    
    // MARK: - Initialization
    
    
    // Designated initializer: a single entry point. All other inits call it
    // Provides a "do-nothing" completion closure by default
    init(placeholderImage img: UIImage, remoteUrl url: URL, downloadQueue: DispatchQueue, completion: @escaping ImageCompletion = nopCompletion) { // Chapuza por bug del compilador, que no permite una clausura opcionall
        
        placeholderImage = img
        remoteImageURL = url
        privateQueue = downloadQueue
        self.completion = completion
        
        // start downloading and return
        loadImage(remoteURL: url)
    }
}

// MARK: - Convenience inits
extension AsyncImage {
    
    // Private queue, no completion closure
    convenience init(placeholderImage img: UIImage, remoteUrl url: URL) {
        self.init(placeholderImage: img,
                  remoteUrl: url,
                  downloadQueue: DispatchQueue(label: "dev.cherran.AsyncImage<\(url)"))
    }
    
    // Private queue, completion closure
    convenience init(placeholderImage img: UIImage, remoteUrl url: URL, completion: @escaping ImageCompletion = nopCompletion) {
        self.init(placeholderImage: img,
                  remoteUrl: url,
                  downloadQueue: DispatchQueue(label: "dev.cherran.AsyncImage<\(url)"),
                  completion: completion)
    }
}



// MARK: - Downloading
extension AsyncImage {
    
    func downloadRemoteImage(remoteURL: URL){

        privateQueue.async {

            // Notify the delegate in the main queue and move on
            // Lo mejor es hacerlo en la cola principal ya que no sabemos para qué va a usar la imagen el delegado
            DispatchQueue.main.async {
                self.delegate?.asyncImage(self, willDowloadImageAt: remoteURL)
            }
            // ¿Por qué no lo ejecuto fuera del privateQueue.async? Porque no estoy seguro de que fuera esté en la cola principal, ya que me han podido llamar desde otra cola

            // Estoy en mi cola privada, que haga lo que haga no bloquea el main thread (la interfaz de usuario)
            if let data = try? Data(contentsOf: self.remoteImageURL),
                let img = UIImage(data: data) {

                // Save to cache
                _ = self.saveToLocalStorage(remoteURL: remoteURL, image: img)

                // Tenemos la imagen, guardarla en localImage, pasarsela a completion (siempre en la cola principal)
                // Además notificar al delegado y a través de Notificaciones
                DispatchQueue.main.async {
                    self.localImage = img
                    self.completion(img)
                    self.delegate?.asyncImage(self, didDownloadImageAt: remoteURL)
                    self.postCompletionNotification(self.createCompletionNotification(image: img))
                }
            } else {
                // La cagamos. Algo salió mal
            }
        }
    }
}



// MARK : -  Delegate protocol
protocol AsyncImageDelegate : AnyObject{ // AnyObject -> Protocolo que debe implemen
    
    func asyncImage(_ ai: AsyncImage, willDowloadImageAt url: URL)
    func asyncImage(_ ai: AsyncImage, didDownloadImageAt url: URL)
    
}

// Default implementation that does nothing: this way the delegate only has to override
// the methods it needs, instead of all of them
// Al darles una implementación vacía por defecto no obligamos a las clase que quieran implementar este protocolo a implementar todas sus funciones
extension AsyncImageDelegate{
    func asyncImage(_ ai: AsyncImage, willDowloadImageAt url: URL){}
    func asyncImage(_ ai: AsyncImage, didDownloadImageAt url: URL){}
}


// MARK: - Notifications
extension AsyncImage{
    
    open static let CompletionNotificationName = Notification.Name(rawValue: "dev.cherran.AsyncImage.DidDownload")
    // Constantes estáticas, de clase, ya que desde las extensiones no se pueden crear variables/propiedades de instacia
    open static let CompletionNotificationImageKey = "Image"
    
    private func createCompletionNotification(image: UIImage)->Notification{
        let n = Notification(name:  AsyncImage.CompletionNotificationName,
                             object: self,
                             userInfo: [AsyncImage.CompletionNotificationImageKey: image])
        
        return n
    }
    
    private func postCompletionNotification(_ n: Notification){
        let nc = NotificationCenter.default
        nc.post(n)
    }
}



// MARK : - Cache
extension AsyncImage{
    
    private func loadImage(remoteURL: URL){
        
        // try to find and load the local image
        // if it doesn't work, start downloading
        self.delegate?.asyncImage(self, willDowloadImageAt: remoteURL)
        privateQueue.async {
            if let localImage = self.loadLocalImage(remoteURL: remoteURL){
                self.localImage = localImage
                
                DispatchQueue.main.async {
                    self.delegate?.asyncImage(self, didDownloadImageAt: remoteURL)
                    self.completion(localImage)
                    self.postCompletionNotification(self.createCompletionNotification(image: localImage))
                }
            } else {
                // Something went wrong. Must download
                self.downloadRemoteImage(remoteURL: remoteURL)
                
            }
            
        }
        
    }
    
    // Unique file name for an image
    private func createUniqueFileName(url: URL)->String{
        // Can't use hashValue, as it's not guaranteed to be equal in
        // different executions of the program: https://apple.co/2pPZszS
        // The best solution would be to create an MD5 or sha of the url, but
        // that would require bridging into CommonCrypto.
        // Cant use the URL directly either, as the max size of urls is 2k chars.
        // The total max path size in iOS is 1024 and the filename part is much
        // lower: 255 chars.
        // According to this article (https://bit.ly/2Ib6Yg7), you better stay
        // substantially below MAX_PATH (1024 chars).
        // Let's use the first 'maxChars' of the url and hope for the best.
        // Worst case scenario, we'll cause a cache miss
        
        let maxChars = 150
        var fileName = "dev.cherran.AsyncImage.cache."
        
        if let host = url.host, let query = url.query{
            fileName =  fileName.appending(host + url.path + query)
        } else {
            fileName = fileName.appending(url.path)
        }
        
        fileName = fileName.replacingOccurrences(of: "/", with: "-")
        
        let prefix = String(fileName.prefix(maxChars))
        
        return prefix
    }
    
    // Caches directory
    // Will return a nil uin case i can't find the caches. Unlikely and no big
    // deal, just download the image
    private var cachesURL : URL?{
        get{
            let fm = FileManager.default
            let urls = fm.urls(for: .cachesDirectory, in: .userDomainMask) // Aquí va a ser borrado periódicamente
            return urls.last
        }
    }
    
    // Do I have a local image?
    // If it returns a nil, it means there's nothing local: go ahead and download
    private func localURLFor(remote:URL) -> URL?{
        let fileURL = cachesURL?.appendingPathComponent(createUniqueFileName(url: remote))
        return fileURL
    }
    
    // Load it
    // if it returns nil, it couldn't read the local file. Download again
    private func loadLocalImage(remoteURL: URL)->UIImage?{
        
        if let localPath =  localURLFor(remote: remoteURL)?.path,
            let img = UIImage(contentsOfFile: localPath){
            return img
        } else {
            return nil
        }
    }
    
    
    // save it
    // Returns true if it correctly saved
    func saveToLocalStorage(remoteURL: URL, image: UIImage) -> Bool{
        
        if let localURL = localURLFor(remote: remoteURL),
            let imgData = UIImageJPEGRepresentation(image, 1),
            let _ = try? imgData.write(to: localURL, options: .atomic){
            return true
        } else {
            return false
        }
    }

}





