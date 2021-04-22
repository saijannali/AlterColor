//
//  PickPhotoViewController.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

import UIKit

class PickPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()

    
    @IBOutlet weak var pickPhotoButton: UIButton!
    
    @IBAction func pickPhotoButtonTapped(_ sender: Any) {
        
        imagePicker.allowsEditing = false
        // give the option to choose from camera or gallery
//        imagePicker.SourceType = camera
        
        imagePicker.sourceType = .photoLibrary
                
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            self.theDataModel.originalImage = pickedImage
        }

        dismiss(animated: true, completion: nil)
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
