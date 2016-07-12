//
//  ViewController.swift
//  Meme Me
//
//  Created by 123 on 7/12/16.
//  Copyright © 2016 123. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    //@IBOutlet weak var navBar: UIToolBar!
    
    //var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextAttribute(topText, str: "TOP TEXT")
        setTextAttribute(bottomText, str: "BOTTOM TEXT")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        
    }
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWIthInfo info: [NSObject: AnyObject]){
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @IBAction func pickAnImage() {
        let pickerController = UIImagePickerController()
        self.presentViewController(pickerController, animated: true, completion:nil)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImage(sender: AnyObject){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        presentViewController(imagePicker, animated:true, completion:nil)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            //imageView.image = image
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//    }
    
    @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func generateNewImage() -> UIImage
    {
        toolBar.hidden = true
        //navBar.hidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        //navBar.hidden = false
        
        return newImage
    }
    
    
    func save(){
        let newImage = generateNewImage()
        var meme = Meme(topText: topText.text!, bottomText: bottomText.text!, image: imagePickerView.image!, newImage: newImage)
    }

    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    //The following 3 methods were adapted from user gfelot from github
    // https://github.com/gfelot/MemeMe-1.0/blob/master/MemeMe1.0/ViewController.swift
    
    func setTextAttribute(textField : UITextField, str : String) {
        //textField.delegate = self
        textField.text = str
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
    }
    
    
    func textFieldDidBeginEditing(textField:UITextField) {
        if (textField == topText && topText.text == "TOP TEXT" ){
            topText.text = ""
        }
        else if (textField == bottomText && bottomText.text == "BOTTOM TEXT"){
            bottomText.text = ""
        }
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size:38)!,
        NSStrokeWidthAttributeName : NSNumber(float: -3.0)]
    
}