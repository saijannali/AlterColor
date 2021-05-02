//
//  PickPhotoViewController.swift
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

class PickPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!
    var state = -1

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()

    
    @IBOutlet weak var pickPhotoButton: UIButton!
    @IBOutlet weak var pickCameraButton: UIButton!
    
    @IBAction func pickPhotoButtonTapped(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        // give the option to choose from camera or gallery
//        imagePicker.SourceType = camera
        
        imagePicker.sourceType = .photoLibrary
        self.state = 0 //0 for photo
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(){
        let picker =  UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        self.state = 1 // 1 for camera
        present(picker, animated: true)
    }
     
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // camera
        if self.state == 1{
            picker.dismiss(animated: true, completion: nil)
        }
        //photo library
        else{
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // if camera chosen
        if self.state == 1{
        
            picker.dismiss(animated: true, completion: nil)
        
            guard let image = info[UIImagePickerController.InfoKey.editedImage] as?
                    UIImage else {
                    return
            }
        
            imageView.image = image
        }
        // if photo library was chosen
        else{
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFill
                imageView.image = pickedImage
                self.theDataModel.loadImage(image: pickedImage)
            }

            dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.backgroundColor = .red
        imagePicker.delegate = self
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.theDataModel = self.appDelegate.allData
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


