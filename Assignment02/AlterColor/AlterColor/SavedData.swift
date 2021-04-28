//
//  SavedData.swift
//  AlterColor
//
//  Created by Lesh, Aidan Daniel on 4/22/21.
//

// Assignment 02 4/27/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

import Foundation
import UIKit

class SavedData {
    
    var images : [savedImage]
    
    init(data: [savedImage]){
        self.images = data
    }
    
    func save(img:UIImage, file:String, when:String){
        images.append(savedImage(theImage: img, theFilename: file, theDate: when))
    }
    
}

class savedImage{
    
    var image: UIImage
    var filename : String
    var dateModified : String
    
    init(theImage:UIImage, theFilename:String, theDate: String){
        self.image = theImage
        self.filename = theFilename
        self.dateModified = theDate
    }
    
}

