//
//  ColorDataModel.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

import Foundation
import UIKit
import Accelerate


class ColorDataModel{
    
    // constant values for edit modes, part of class itself not instances
    static let EDIT_MODE_NONE = 0
    static let EDIT_MODE_HUE = 1
    static let EDIT_MODE_BRIGHTNESS = 2
    static let EDIT_MODE_CONTRAST = 3
    
    // which aspect we're editing
    var editMode: Int
    var originalImage : UIImage? = nil
    var currentImage : UIImage? = nil
    var originalCG : CGImage? = nil
    var format : vImage_CGImageFormat? = nil
    
    //var imageFormat = vImage_CGImageFormat(
    
    init(image:UIImage?){
        self.editMode = ColorDataModel.EDIT_MODE_NONE
        self.originalImage = image
    }
    
    func loadImage(image:UIImage?){
        self.originalImage = image?.copy() as! UIImage?
        self.currentImage = image?.copy() as! UIImage?
        self.originalCG = originalImage?.cgImage
        if (originalCG != nil){
            self.format = vImage_CGImageFormat(cgImage: self.originalCG!)
        }
    }
    
    func getCurrent() -> UIImage? {
        return self.currentImage
    }
    
    func adjustHue(amount: Double){
        
    }
    
}
