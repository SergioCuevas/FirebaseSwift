//
//  ViewController.swift
//  MapsFirebase
//
//  Created by DAM on 28/3/17.
//  Copyright © 2017 Stucom. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func LogIn(_ sender: Any) {
        
        if email.text == ""{
            
            let alertController = UIAlertController(title: "Error", message: "Introduce un Usuario/Correo y una contraseña", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            FIRAuth.auth()?.signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    print("Iniciando Sesión")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainActivity")
                    self.present(vc!, animated: true, completion: nil)
                    
                    
                }else{
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
        }

    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        
       
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

