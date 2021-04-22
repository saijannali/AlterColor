//
//  ColorDataModel.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

import Foundation
import UIKit


class ColorDataModel{
    
    // constant values for edit modes, part of class itself not instances
    static let EDIT_MODE_NONE = 0
    static let EDIT_MODE_HUE = 1
    static let EDIT_MODE_BRIGHTNESS = 2
    static let EDIT_MODE_CONTRAST = 3
    
    // which aspect we're editing
    var editMode: Int
    var originalImage : UIImage? = nil
    
    
    init(image:UIImage?){
        self.editMode = ColorDataModel.EDIT_MODE_NONE
        self.originalImage = image
    }
    
}
