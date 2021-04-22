//
//  EditPhotoViewController.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

import UIKit

class EditPhotoViewController: UIViewController {
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!
    
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
    }
    @IBAction func BrightnessButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Brightness"
    }
    @IBAction func ContrastButtonPressed(_ sender: Any) {
        showSlider()
        EditLabel.text = "Contrast"
    }
    @IBAction func SaveButtonPressed(_ sender: Any) {
    }
    @IBAction func BackButtonPressed(_ sender: Any) {
        showButtons()
    }
    @IBAction func SliderSlid(_ sender: Any) {
        
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
        
        print("\(self.theDataModel.originalImage)")
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
