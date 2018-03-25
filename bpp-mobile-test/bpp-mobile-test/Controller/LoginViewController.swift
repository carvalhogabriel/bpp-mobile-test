//
//  ViewController.swift
//  bpp-mobile-test
//
//  Created by Gabriel Carvalho Dev Dev on 23/03/18.
//  Copyright © 2018 GabrielGuerrero. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var loginTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - @IBActions
    @IBAction func confirmButtonClick(_ sender: UIButton) {
        self.buildLoadingAlert()
        LoginApi.sharedInstance.authenticateUser(loginTextView.text, passwordTextView.text, callback: {
            error in
            if error == nil {
                self.fetchTimeLine()
            } else {
                if error?.code == 300 {
                    self.dismiss(animated: true, completion: nil)
                    self.buildUserError()
                }
                self.dismiss(animated: true, completion: nil)
                self.buildAlertError()
            }
        })
        
    }
    
    // MARK: - Private Var's
    var timeLineResults: [NSDictionary]!
    
    //MARK: - Private Methods
    private func fetchTimeLine() {
        TimeLineApi.sharedInstance.fetchTimeLine {
            (results, error) in
            if error != nil {
                self.buildAlertError()
            }
            self.timeLineResults = results
            self.performSegue(withIdentifier: "TimeLineSegue", sender: self)
        }
    }
    
    private func buildLoadingAlert() {
        let loadingAlert = UIAlertController(title: "", message: "\n\n\n\n\n", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        loadingAlert.view.addSubview(indicator)
        indicator.center = CGPoint(x: 130.5, y: 65.5)
        indicator.startAnimating()
        indicator.color = UIColor.black
        indicator.isUserInteractionEnabled = false
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    private func prepareDismissKeyboard() {
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func buildAlertError() {
        let alertError = UIAlertController(title: "Error!", message: "Generic Error", preferredStyle: .alert)
        alertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertError, animated: true, completion: nil)
    }
    
    private func buildUserError() {
        let userAlertError = UIAlertController(title: "Error!", message: "Invalid Usuer", preferredStyle: .alert)
        userAlertError.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
            _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(userAlertError, animated: true, completion: nil)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.prepareDismissKeyboard()
        loginTextView.text = "waldisney@brasilprepagos.com.br"
        passwordTextView.text = "Br@silPP123"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let dvc = segue.destination as? TimeLineViewController {
            dvc.timeLineResults = timeLineResults
            self.timeLineResults = nil
        }
    }
}

