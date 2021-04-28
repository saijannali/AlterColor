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
    var currentCG : CGImage? = nil
    var format : vImage_CGImageFormat? = vImage_CGImageFormat(
        bitsPerComponent: 8,
        bitsPerPixel: 8 * 3,
        colorSpace: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
        renderingIntent: .defaultIntent)!
    var labFormat : vImage_CGImageFormat? = vImage_CGImageFormat(
        bitsPerComponent: 8,
        bitsPerPixel: 8 * 3,
        colorSpace: CGColorSpace(name: CGColorSpace.genericLab)!,
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
        renderingIntent: .defaultIntent)!
    var originalImageBuffer : vImage_Buffer? = nil
    var currentImageBuffer : vImage_Buffer? = nil
    let RGBtoLab : vImageConverter
    let LabtoRGB : vImageConverter
    
    var currentBrightness : Float = 0.0
    var currentContrast : Float = 1.0
    var currentHue = 0.0
    
    //var imageFormat = vImage_CGImageFormat(
    
    init(image:UIImage?){
        self.editMode = ColorDataModel.EDIT_MODE_NONE
        self.originalImage = image
        do {
            self.RGBtoLab = try vImageConverter.make(sourceFormat: self.format!, destinationFormat: self.labFormat!)
            self.LabtoRGB = try vImageConverter.make(sourceFormat: self.labFormat!, destinationFormat: self.format!)
        } catch {
            fatalError(error.localizedDescription)
        }
        defer {
            currentImageBuffer?.free()
            originalImageBuffer?.free()
        }
    }
    
    func loadImage(image:UIImage?){
        self.originalImage = image?.copy() as! UIImage?
        self.currentImage = image?.copy() as! UIImage?
        self.originalCG = originalImage?.cgImage
        if (originalCG != nil){
            //self.format = vImage_CGImageFormat(cgImage: self.originalCG!)
        }
        setUpBuffers()
        adjustBrightness(amount: 0.0)
        self.currentImage = readFromBuffers()
    }
    
    func getCurrent() -> UIImage? {
        return self.currentImage
    }
    
    func adjustCurrent(value: Float){
        //print("Edit mode is \(editMode)")
        if editMode == ColorDataModel.EDIT_MODE_HUE{
            adjustHue(amount: value)
        }
        if editMode == ColorDataModel.EDIT_MODE_BRIGHTNESS{
            adjustBrightness(amount: value * 6.0 - 3.0)
        }
        if editMode == ColorDataModel.EDIT_MODE_CONTRAST{
            adjustContrast(amount: value * 3.0)
        }
        self.currentImage = readFromBuffers()
    }
    
    func adjustHue(amount: Float){
        
    }
    
    func adjustBrightness(amount: Float){
        self.currentBrightness = amount
        adjustBrightnessContrast(brightness: Float(self.currentBrightness), contrast: Float(self.currentContrast))
    }
    
    func adjustContrast(amount: Float){
        self.currentContrast = amount
        adjustBrightnessContrast(brightness: self.currentBrightness, contrast: self.currentContrast)
    }
    
    func adjustBrightnessContrast(brightness: Float, contrast: Float){
        var planarSource = vImage_Buffer(
            data: originalImageBuffer!.data,
            height: originalImageBuffer!.height,
            width: originalImageBuffer!.width * 3,
            rowBytes: originalImageBuffer!.rowBytes)
        var planarDestination = vImage_Buffer(
            data: currentImageBuffer!.data,
            height: currentImageBuffer!.height,
            width: currentImageBuffer!.width * 3,
            rowBytes: currentImageBuffer!.rowBytes)
        let preset = CurvePreset(
            label: "A1",
            boundary: 255,
            linearCoefficients: [contrast, brightness],
            gamma: 0)
        
        vImagePiecewiseGamma_Planar8(
            &planarSource,
            &planarDestination,
            [0.0],
            preset.gamma,
            preset.linearCoefficients,
            preset.boundary,
            vImage_Flags(kvImageNoFlags))
        print(brightness, contrast)
    }
    
    func setUpBuffers(){
        do {
            try originalImageBuffer = vImage_Buffer(cgImage: originalCG!)
            //try currentImageBuffer = vImage_Buffer(cgImage: originalCG!)
            try currentImageBuffer = vImage_Buffer(
                width: Int(originalImageBuffer!.width),
                height: Int(originalImageBuffer!.height),
                bitsPerPixel: format!.bitsPerPixel)
            
            vImageConvert_RGBA8888toRGB888(
                &originalImageBuffer!,
                &originalImageBuffer!,
                vImage_Flags(kvImageNoFlags))
            
            vImageConvert_RGBA8888toRGB888(
                &originalImageBuffer!,
                &currentImageBuffer!,
                vImage_Flags(kvImageNoFlags))
            
            
        } catch {
            print("setUpBuffers error! ", error)
        }
    }
    
    func readFromBuffers() -> UIImage{
        let CGIntermediary = try? currentImageBuffer?.createCGImage(format: format!)
        return UIImage(cgImage: CGIntermediary!)
    }
        
}


struct CurvePreset {
    let label: String
    let boundary: Pixel_8
    let linearCoefficients: [Float]
    let gamma: Float
}
