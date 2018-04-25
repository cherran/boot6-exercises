//
//  RemoteImages.swift
//  GCDSample
//
//  Created by hijos on 20/4/18.
//  Copyright © 2018 cherran. All rights reserved.
//

import Foundation

typealias URLString = String // typealias para dar información al humano (dev), y no al compilador

enum RemoteImages: URLString {
    case danny = "https://typeset-beta.imgix.net/rehost/2016/9/13/9f6e6cc4-c86b-4cbb-8d7d-bedf3f8b3937.jpg"
    case missandei = "http://www.nanduti.com.py/wp-content/uploads/2015/10/Bohemian-Rapsody-Queen.jpg"
    case olenna = "https://i.pinimg.com/originals/b2/b7/29/b2b729b8ca326a86ba83bb929847d25c.jpg"
    case cersei = "https://photojournal.jpl.nasa.gov/jpeg/PIA21970.jpg"
    case wrongURLString = "http://www.farfarawaysite.com/section/got/gallery3/gallery4/hires/15.jpg"
    
    static func url(_ aCase: RemoteImages) -> URL? { // El init de URL es un inicializador fallable
        let strRepresentation = aCase.rawValue // String de la URL correspondiente al caso
        return URL(string: strRepresentation)
    }
}
