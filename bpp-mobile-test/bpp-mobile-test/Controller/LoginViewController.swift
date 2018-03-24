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
        LoginApi.sharedInstance.authenticateUser(loginTextView.text, passwordTextView.text, callback: {
            error in
            if error == nil {
                let storyboard = UIStoryboard(name: "TimeLine", bundle: nil)
                let timeLineViewController = storyboard.instantiateViewController(withIdentifier: "TimeLineViewController") as UIViewController
                self.present(timeLineViewController, animated: true, completion: nil)
            }
        })
        
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginTextView.text = "waldisney@brasilprepagos.com.br"
        passwordTextView.text = "Br@silPP123"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

