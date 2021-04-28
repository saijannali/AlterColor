//
//  EditPhotoViewController.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

// Assignment 02 4/27/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

import UIKit

class EditPhotoViewController: UIViewController {
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!
    var theSavedData:SavedData!
    
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
    }
    @IBAction func BrightnessButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Brightness"
        theDataModel.editMode = ColorDataModel.EDIT_MODE_BRIGHTNESS
    }
    @IBAction func ContrastButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Contrast"
        theDataModel.editMode = ColorDataModel.EDIT_MODE_CONTRAST
    }
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let filename = "bingus"
        let date = "march 10"
        theSavedData.save(img:theDataModel.getCurrent()!, file:filename, when:date)
        if let thetable = navigationController?.children[2]{
            navigationController?.show(thetable, sender: self)
        }
    }
    @IBAction func BackButtonPressed(_ sender: Any) {
        showButtons()
    }
    @IBAction func SliderSlid(_ sender: Any) {
        theDataModel.adjustCurrent(value: Slider.value)
        imageToEdit.image = theDataModel.getCurrent()
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
        self.theSavedData = self.appDelegate.savedData
        
        print("\(self.theDataModel.originalImage)")
        imageToEdit.image = theDataModel.getCurrent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageToEdit.image = theDataModel.getCurrent()
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
