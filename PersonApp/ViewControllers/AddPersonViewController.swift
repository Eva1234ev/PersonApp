//
//  AddPersonViewController.swift
//  PersonApp
//
//  Created by Eva on 10/22/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import CoreData

protocol AddPersonViewControllerDelegate:class {
    func dismissed()
}
class AddPersonViewController: UIViewController {
    
    @IBOutlet weak private var personImageView: UIImageView!
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var descriptionTextField: UITextField!
    @IBOutlet weak private var topKeyboardConstarint: NSLayoutConstraint!
    @IBOutlet weak private var editView: UIStackView!
    var currentPerson: Person?
    var delegate:AddPersonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (currentPerson != nil)
        {
            if let url = URL( string:currentPerson!.image!)
            {
                personImageView.load(url: url, id : currentPerson!.itemId!)
            }else {
                personImageView.image =  UIImage(named: "profile")
            }
            nameTextField.text = currentPerson?.name
            descriptionTextField.text = currentPerson?.desc
        }
        else {
            personImageView.image = UIImage(named: "profile")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue        
        var keyboardRect = CGRect.zero
        keyboardRectAsObject.getValue(&keyboardRect)
        self.topKeyboardConstarint.constant = -editView.frame.size.height/2
        UIView.animate(withDuration: 0.5,animations: {
            
            self.view.layoutIfNeeded()
            
        })
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        var keyboardRect = CGRect.zero
        keyboardRectAsObject.getValue(&keyboardRect)
        self.topKeyboardConstarint.constant = 0
        
        UIView.animate(withDuration: 0.5,animations: {
            
            self.view.layoutIfNeeded()
            
        })
        
    }
    
    @IBAction func unwindFromSecond(_ segue: UIStoryboardSegue) {
        delegate?.dismissed()
    }
    
    @IBAction func saveButtonaAction(_ sender: Any) {
        if !nameTextField.text!.isEmpty , !descriptionTextField.text!.isEmpty {
            if(currentPerson != nil) {
                CoreDataManager.sharedManager.update(name: nameTextField.text!, desc: descriptionTextField.text!, person: currentPerson!)
            }else{
                _ = CoreDataManager.sharedManager.insertPerson(name: self.nameTextField.text!, desc: self.descriptionTextField.text!)
            }
        }
        delegate?.dismissed()
    }
    
    class func createInstance() -> AddPersonViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddPersonViewController") as! AddPersonViewController
    }
}
