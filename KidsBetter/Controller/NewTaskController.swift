//
//  NewTaskController.swift
//  KidsBetter
//
//  Created by bxl on 2022/1/4.
//

import UIKit

class NewTaskController: UITableViewController {
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var titleTextField: RoundedTextField! {
        didSet {
            titleTextField.tag = 1
            titleTextField.becomeFirstResponder()
            titleTextField.delegate = self
    } }
    
    @IBOutlet var descriptionTextField: RoundedTextField! {
        didSet {
            descriptionTextField.tag = 2
            descriptionTextField.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath
    : IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default,
            handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary
                ){ let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
                }
                
            }
            present(photoSourceRequestController, animated: true, completion:nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
                }
            navigationController?.navigationBar.standardAppearance=appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        // Get the superview's layout
        let margins = photoImageView.superview!.layoutMarginsGuide
        // Disable auto resizing mask to use auto layout programmatically
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        // Pin the leading edge of the image view to the margin's leading edge
        photoImageView.leadingAnchor.constraint(equalTo:margins.leadingAnchor).isActive = true
        // Pin the trailing edge of the image view to the margin's leading edge
        photoImageView.trailingAnchor.constraint(equalTo:margins.trailingAnchor).isActive = true
        // Pin the top edge of the image view to the margin's leading edge
        photoImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive =
        true
        // Pin the bottom edge of the image view to the margin's leading edge
        photoImageView.bottomAnchor.constraint(equalTo:margins.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }

}

extension NewTaskController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

extension NewTaskController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}
