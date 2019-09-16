//
//  ViewController.swift
//  ChuckNorrisJokes_Lebedev
//
//  Created by Владимир on 15/06/2019.
//  Copyright © 2019 Владимир. All rights reserved.
//

import UIKit
import Alamofire
//import AlamofireImage

extension UIViewController{
    func hideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(Tap)
    }
    @objc func DismissKeyboard(){
        view.endEditing(true)
    }
}

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var jokesArray = [AnyObject]()

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func loadButton(_ sender: UIButton) {
        Alamofire.request("http://api.icndb.com/jokes/random/\(countField.text ?? "0")", method: .get).responseJSON {
            response in
            let result = response.result
            if self.countField.text?.count == 0{
                self.loadBtn.isEnabled = true
            }else{
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    if let innerDict = dict["value"]{
                        self.jokesArray = innerDict as! [AnyObject]
                        self.mTableView.reloadData()
                    }
                }
            } 
        }
        if countField.text == "0"{
            let alert = UIAlertController(title: "Zero? Seriously?", message: "Chuck displeased with you,write this shit allright", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Good...", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        DismissKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.hideKeyboard()
        loadBtn.layer.cornerRadius = 12
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as? MyTableViewCell
        let title = jokesArray[indexPath.row]["joke"]
        cell?.jokesLabel.text = title as? String
        return cell!
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if bottomConstraint.constant == 83{
                bottomConstraint.constant = keyboardSize.height + 40 //тут не понял, почему на разных симуляторах по раpному работает увеличение constraint, а в случае с XR вообще отличаются первое и следующие нажатия
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 83
        self.view.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
