//
//  DetailViewController.swift
//  DemoFoodTracker
//
//  Created by Vu Ngoc Cong on 4/10/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var index: Int?
    var meals = DataServices.shared.meal
    @IBOutlet weak var nameMeal: UITextField!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var isCheckName: Bool = false{
        didSet{
            if isCheckName {
                isError = !((DataServices.shared.meal.filter{ $0.name == nameMeal.text ?? ""}).count == 0)
                isCheckName = false
            }
        }
    }
    
    var isError: Bool = false{
        didSet{
            if isError {
                let alertControl = UIAlertController(title: "Error", message: "Enter new name, Please!", preferredStyle: .alert)
                alertControl.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index != nil {
            nameMeal.text = meals[index ?? 0].name
            photoImageView.image = meals[index ?? 0].photo
            ratingControl.rating = meals[index ?? 0].rating
        }
        
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = selectImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImagePickerController(_ sender: Any) {
        nameMeal.resignFirstResponder()
        let imagePickerControl = UIImagePickerController()
        imagePickerControl.sourceType = .photoLibrary
        imagePickerControl.delegate = self
        present(imagePickerControl, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        nameMeal.resignFirstResponder()
        nameMeal.endEditing(true)
        if let indexPath = index{
            if meals[indexPath].name != nameMeal.text ?? "" {
                isCheckName = true
            }
            if !isError {
                meals[indexPath].name = nameMeal.text ?? ""
                meals[indexPath].photo = photoImageView.image
                meals[indexPath].rating = ratingControl.rating
            }
        }
        else{
            isCheckName = true
            if !isError {
                let meal = Meal(name: nameMeal.text ?? "", photo: photoImageView.image, rating: ratingControl.rating)!
                DataServices.shared.addMeal(meal)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
