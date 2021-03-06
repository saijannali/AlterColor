//
//  ColorDataModel.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

// Assignment 02 4/27/2021
// Final Project 5/4/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

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
    var labImageBuffer : vImage_Buffer? = nil
    var l_ImageBuffer : vImage_Buffer? = nil
    var a_ImageBuffer : vImage_Buffer? = nil
    var b_ImageBuffer : vImage_Buffer? = nil
    let RGBtoLab : vImageConverter
    let LabtoRGB : vImageConverter
    
    var currentBrightness : Float = 0.0
    var currentContrast : Float = 1.0
    var currentHue : Float = 0.0
    var brightnessSlider : Float = 0.5
    var contrastSlider : Float = 0.5
    var hueSlider : Float = 0.0
    
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
        brightnessSlider = 0.5
        contrastSlider = 0.5
        hueSlider = 0.0
        currentBrightness = 0.0
        currentContrast = 1.0
        currentHue = 0.0
        adjustBrightness(amount: 0.0) //this line is actually vital
        self.currentImage = readFromBuffers()
    }
    
    func getCurrent() -> UIImage? {
        return self.currentImage
    }
    
    func adjustCurrent(value: Float){
        //print("Edit mode is \(editMode)")
        if editMode == ColorDataModel.EDIT_MODE_HUE{
            hueSlider = value
            adjustHue(amount: value * 2 * Float.pi)
        }
        if editMode == ColorDataModel.EDIT_MODE_BRIGHTNESS{
            brightnessSlider = value
            adjustBrightness(amount: value * 6.0 - 3.0)
        }
        if editMode == ColorDataModel.EDIT_MODE_CONTRAST{
            contrastSlider = value
            adjustContrast(amount: value * 3.0)
        }
        self.currentImage = readFromBuffers()
    }
    
    func adjustHue(amount: Float){
        self.currentHue = amount
        applyAdjustments(hue: Float(self.currentHue), brightness: Float(self.currentBrightness), contrast: Float(self.currentContrast))
    }
    
    func adjustBrightness(amount: Float){
        self.currentBrightness = amount
        applyAdjustments(hue: Float(self.currentHue), brightness: Float(self.currentBrightness), contrast: Float(self.currentContrast))
    }
    
    func adjustContrast(amount: Float){
        self.currentContrast = amount
        applyAdjustments(hue: Float(self.currentHue), brightness: self.currentBrightness, contrast: self.currentContrast)
    }
    
    func applyAdjustments(hue: Float, brightness: Float, contrast: Float){
        // hue
        do {
            try RGBtoLab.convert(
                source: originalImageBuffer!,
                destination: &labImageBuffer!)
            vImageConvert_RGB888toPlanar8(
                &labImageBuffer!,
                &l_ImageBuffer!,
                &a_ImageBuffer!,
                &b_ImageBuffer!,
                vImage_Flags(kvImageNoFlags))
        }catch{
            fatalError("Oh no! Error in hue adjusment setup")
        }
        // I'm not exactly sure how this works but I think it's formatting and remapping
        let divisor : Int32 = 0x1000 //4096
        let rawRotationMatrix : [Float] = [
            Float(cos(hue)), Float(-sin(hue)),
            Float(sin(hue)), Float(cos(hue))
        ]
        let rotationMatrix = rawRotationMatrix.map({return Int16($0 * Float(divisor))})
        let preBias = [Int16](repeating: -128, count: 2)
        let postBias : [Int32] = [Int32](repeating: 128 * divisor, count: 2)
        [b_ImageBuffer!, a_ImageBuffer!].withUnsafeBufferPointer{ bufferPointer in
            var src: [UnsafePointer<vImage_Buffer>?] = (0...1).map{bufferPointer.baseAddress! + $0}
            var dst: [UnsafePointer<vImage_Buffer>?] = (0...1).map{bufferPointer.baseAddress! + $0}
            vImageMatrixMultiply_Planar8(
                &src,
                &dst,
                2,
                2,
                rotationMatrix,
                divisor,
                preBias,
                postBias,
                0)
        }
        vImageConvert_Planar8toRGB888(
            &l_ImageBuffer!,
            &a_ImageBuffer!,
            &b_ImageBuffer!,
            &labImageBuffer!,
            vImage_Flags(kvImageNoFlags))
        do{
            try LabtoRGB.convert(source: labImageBuffer!, destination: &currentImageBuffer!)
        }catch{
            print("LabtoRGB conversion error! " + error.localizedDescription)
        }
        
        // brightness, contrast
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
            &planarDestination,  // this isn't &planarsource because we're continuing from the hue, so it needs to be in-place in order to keep hue changes
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
            try labImageBuffer = vImage_Buffer(
                width: Int(originalImageBuffer!.width),
                height: Int(originalImageBuffer!.height),
                bitsPerPixel: labFormat!.bitsPerPixel)
            try l_ImageBuffer = vImage_Buffer(
                width: Int(originalImageBuffer!.width),
                height: Int(originalImageBuffer!.height),
                bitsPerPixel: labFormat!.bitsPerPixel)
            try a_ImageBuffer = vImage_Buffer(
                width: Int(originalImageBuffer!.width),
                height: Int(originalImageBuffer!.height),
                bitsPerPixel: labFormat!.bitsPerPixel)
            try b_ImageBuffer = vImage_Buffer(
                width: Int(originalImageBuffer!.width),
                height: Int(originalImageBuffer!.height),
                bitsPerPixel: labFormat!.bitsPerPixel)
            
            vImageConvert_RGBA8888toRGB888(
                &originalImageBuffer!,
                &originalImageBuffer!,
                vImage_Flags(kvImageNoFlags))
            
            vImageConvert_RGBA8888toRGB888(
                &originalImageBuffer!,
                &currentImageBuffer!,
                vImage_Flags(kvImageNoFlags))
            
            try RGBtoLab.convert(
                source: originalImageBuffer!,
                destination: &labImageBuffer!)
            
            vImageConvert_RGB888toPlanar8(
                &labImageBuffer!,
                &l_ImageBuffer!,
                &a_ImageBuffer!,
                &b_ImageBuffer!,
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
