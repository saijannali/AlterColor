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
    
    func save(file:String, when:String, path:String){
        images.append(savedImage(theFilename: file, theDate: when,thePath: path))
    }
    
}

class savedImage: NSObject, Codable{
    
    //var image: UIImage
    var filename : String
    var dateModified : String
    var imagePath: String
    
    init(/*theImage:UIImage*/ theFilename:String, theDate: String, thePath: String){
        self.filename = theFilename
        self.dateModified = theDate
        self.imagePath = thePath
    }
    
}

/*class FilePath{
    var paths : [ImagePath]
    
    init(data: [ImagePath]){
        self.paths = data
    }
    
    func save(name: String, date: String, path: String){
        paths.append(ImagePath(theFilename: name, theDate: date, thePath: path))
    }
}

class ImagePath{
    
    var filename : String
    var dateModified : String
    var filePath : String
    
    init(theFilename:String, theDate: String, thePath: String){
        self.filename = theFilename
        self.dateModified = theDate
        self.filePath = thePath
    }
}*/

