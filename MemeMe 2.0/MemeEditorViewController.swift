//
//  MemeEditorViewController.swift
//  MemeMe 1.0 Reboot
//
//  Created by Jaemoon Park on 11/5/16.
//
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var btmCamera: UIBarButtonItem!
    @IBOutlet weak var btmAlbum: UIBarButtonItem!
    @IBOutlet weak var btmShare: UIBarButtonItem!
    @IBOutlet weak var btmCancel: UIBarButtonItem!
    @IBOutlet weak var txtFieldTop: UITextField!
    @IBOutlet weak var txtFieldBtm: UITextField!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var barNavigation: UINavigationBar!
    @IBOutlet weak var barTool: UIToolbar!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextField(textField: txtFieldTop)
        prepareTextField(textField: txtFieldBtm)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btmCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        //dismiss first responder when tapping on view controller
        let select = UITapGestureRecognizer(target: self, action: #selector(MemeEditorViewController.dismissFirstResponders))
        view.addGestureRecognizer(select)
        subscribeToKeyboardNotification()
        
        //disable share/save button when no image is selected
        btmShare.isEnabled = (viewImage.image != nil)
    }
    
    func prepareTextField(textField: UITextField){
        let txtFieldAttributes = [NSStrokeColorAttributeName: UIColor.black,
                                  NSStrokeWidthAttributeName: -5.0,
                                  NSForegroundColorAttributeName: UIColor.white,
                                  NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!] as [String : Any]
        textField.defaultTextAttributes = txtFieldAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.delegate = self
    }
    
    func dismissFirstResponders(){
        txtFieldTop.resignFirstResponder()
        txtFieldBtm.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeToKeyboardNotification()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //clearing text if selected & default text
        if(textField.text == "TOP" || textField.text == "BOTTOM"){
            textField.text = ""
        }
    }
    
    @IBAction func pick(selector: AnyObject){
        let controllerImagePick = UIImagePickerController()
        controllerImagePick.delegate = self
        controllerImagePick.sourceType = (selector as! NSObject == btmAlbum) ? UIImagePickerControllerSourceType.savedPhotosAlbum :
            UIImagePickerControllerSourceType.camera
        present(controllerImagePick, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            viewImage.image = image
        }
        btmShare.isEnabled = (viewImage.image != nil)
        dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotification(){
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }
    
    func getKeyBoardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(notification: NSNotification){
        if(view.frame.origin.y == 0 && txtFieldBtm .isFirstResponder){
            view.frame.origin.y =  getKeyBoardHeight(notification: notification) * -1
        }
    }
    
    func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func saveAndShare(){
        let viewActivity = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        present(viewActivity, animated: true, completion: nil)
        viewActivity.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                //appending meme to memes array in AppDelegate
                (UIApplication.shared.delegate as! AppDelegate).memes.append(self.saveMeme())
            }
        }
    }
    
    func saveMeme() -> Meme{
        return Meme(strTop: self.txtFieldTop.text!, strBtm: self.txtFieldBtm.text!, imageOrig: self.viewImage.image!, imageFinal: self.generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage{
        //hiding bars and resigning first responders for screen capture
        barTool.isHidden = true
        barNavigation.isHidden = true
        txtFieldBtm.resignFirstResponder()
        txtFieldTop.resignFirstResponder()
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //unhiding bars
        barTool.isHidden = false
        barNavigation.isHidden = false
        return memedImage
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
}

