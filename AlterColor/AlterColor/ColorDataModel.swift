//
//  ColorDataModel.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

import Foundation


class ColorDataModel: NSObject, Codable{
    
    // constant values for edit modes, part of class itself not instances
    static let EDIT_MODE_NONE = 0
    static let EDIT_MODE_HUE = 1
    static let EDIT_MODE_BRIGHTNESS = 2
    static let EDIT_MODE_CONTRAST = 3
    
    // which aspect we're editing
    var editMode: Int
    
    // this is an int for now, replace with actual stuff later
    var storedData: Int
    
    init(loadData:Int){
        self.editMode = ColorDataModel.EDIT_MODE_NONE
        self.storedData = loadData // this line is just to make it codable, replace it
        super.init()
    }
    
}
