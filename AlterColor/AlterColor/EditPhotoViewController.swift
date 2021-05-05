//
//  EditPhotoViewController.swift
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

import UIKit

class EditPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!
    var theSavedData:SavedData!
    //var theFilePath: FilePath!
    
    @IBOutlet weak var HueButton: UIButton!
    @IBOutlet weak var BrightnessButton: UIButton!
    @IBOutlet weak var ContrastButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var EditLabel: UILabel!
    
    @IBOutlet var imageToEdit: UIImageView!
    
    @IBAction func HueButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Hue"
        theDataModel.editMode = ColorDataModel.EDIT_MODE_HUE
        Slider.value = theDataModel.hueSlider
    }
    @IBAction func BrightnessButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Brightness"
        theDataModel.editMode = ColorDataModel.EDIT_MODE_BRIGHTNESS
        Slider.value = theDataModel.brightnessSlider
    }
    @IBAction func ContrastButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Contrast"
        theDataModel.editMode = ColorDataModel.EDIT_MODE_CONTRAST
        Slider.value = theDataModel.contrastSlider
    }
    @IBAction func SaveButtonPressed(_ sender: Any) {
        if theDataModel.originalImage == nil{
            return
        }
        let filename = "\(Date().timeIntervalSinceReferenceDate)"
        let date = "march 10"
        let pathGenerated = generatePath(fileName: filename, Date: date)
  
        
        // for our use
        theSavedData.save(file: filename, when: date, path: pathGenerated)
        //for storing use
        //theFilePath.save(name: filename, date: date, path: pathGenerated)
        appDelegate.write_plist()
        if let thetable = navigationController?.children[2]{
            navigationController?.show(thetable, sender: self)
        }

    }
    @IBAction func BackButtonPressed(_ sender: Any) {
        showButtons()
    }
    @IBAction func SliderSlid(_ sender: Any) {
        if theDataModel.originalImage == nil{
            return
        }
        theDataModel.adjustCurrent(value: Slider.value)
        imageToEdit.image = theDataModel.getCurrent()
    }
    
    func generatePath(fileName: String, Date: String) -> String{
        // create insatnce
        let fileManager = FileManager.default
        
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(fileName)
        
        //get image
        let image = theDataModel.getCurrent()!
        
        //get png data
        let data = image.pngData()
        
        //store in doc directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        print(imagePath)
        
        
        return  imagePath
    }
    
    
    
    func buttonsAreHidden(hidden:Bool){
        HueButton.isHidden = hidden
        BrightnessButton.isHidden = hidden
        ContrastButton.isHidden = hidden
        SaveButton.isHidden = hidden
    }
    func slidersAreHidden(hidden:Bool){
        BackButton.isHidden = hidden
        Slider.isHidden = hidden
        EditLabel.isHidden = hidden
    }
    func showButtons(){
        buttonsAreHidden(hidden: false)
        slidersAreHidden(hidden: true)
    }
    func showSlider(){
        buttonsAreHidden(hidden: true)
        slidersAreHidden(hidden: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showButtons()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.theDataModel = self.appDelegate.allData
        self.theSavedData = self.appDelegate.mySavedData
        
        print("\(self.theDataModel.originalImage)")
        imageToEdit.image = theDataModel.getCurrent()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageToEdit.image = theDataModel.getCurrent()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : AnyObject]) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
