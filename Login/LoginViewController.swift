//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let titlelabelcolor = UIColor.white
        static let bounds: CGRect = UIScreen.main.bounds
        static let textmargin: CGFloat = 15
        static let verticalspace: CGFloat = 50
        static let buttonTextSize: CGFloat = 24
        static let buttonMargin: CGFloat = 35
        static let buttonHeight: CGFloat = 100
        static let bottomButtonMargin: CGFloat = 50
        
    }
    
    var titlelabel: UILabel = {
        let newlabel = UILabel()
        newlabel.text = "Login View Controller"
        newlabel.font = newlabel.font.withSize(50)
        newlabel.textColor = .white
        newlabel.numberOfLines = 2
        newlabel.textAlignment = .center
        return newlabel
    }()
    
    var newview: UIView = {
        let secondview = UIView()
        secondview.backgroundColor = .white
        secondview.layer.cornerRadius = 10
        secondview.layer.masksToBounds = true
        return secondview
    }()
    
    var loginButton: UIButton = {
        let newButton = UIButton()
        newButton.backgroundColor = Constants.backgroundColor
        newButton.setTitle("Login", for: .normal)
        newButton.setTitleColor(.white, for: .normal)
        newButton.layer.cornerRadius = 10
        newButton.layer.masksToBounds = true
        return newButton
    }()
    
    var emailtext: UITextField = {
        let etext = UITextField()
        etext.placeholder = "berkeley.edu account"
        return etext
    }()
    
    var passwordtext: UITextField = {
        let ptext = UITextField()
        ptext.placeholder = "Password"
        return ptext
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(newview)
        view.addSubview(titlelabel)
        newview.addSubview(emailtext)
        newview.addSubview(passwordtext)
        newview.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchDown)
        setupConstraints()
    }

    @IBAction func loginButtonPressed(sender: UIButton) {
        authenticateUser(username: emailtext.text, password: passwordtext.text)
    }

    func setupConstraints() {
        emailtext.translatesAutoresizingMaskIntoConstraints = false
        passwordtext.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        newview.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        
        newview.center = view.center
        newview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newview.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        newview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titlelabel.widthAnchor.constraint(equalTo: newview.widthAnchor).isActive = true
        titlelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        passwordtext.leadingAnchor.constraint(equalTo: newview.leadingAnchor, constant: Constants.textmargin).isActive = true
        passwordtext.trailingAnchor.constraint(equalTo: newview.trailingAnchor, constant: -Constants.textmargin).isActive = true
        passwordtext.bottomAnchor.constraint(lessThanOrEqualTo: loginButton.topAnchor, constant: -Constants.verticalspace).isActive = true
        
        emailtext.centerXAnchor.constraint(equalTo: passwordtext.centerXAnchor).isActive = true
        emailtext.widthAnchor.constraint(equalTo: passwordtext.widthAnchor).isActive = true
        emailtext.bottomAnchor.constraint(equalTo: passwordtext.topAnchor, constant: -Constants.verticalspace).isActive = true
        emailtext.topAnchor.constraint(equalTo: newview.topAnchor, constant: Constants.verticalspace + 3).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: newview.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: newview.bottomAnchor, constant: -Constants.verticalspace).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
        loginButton.widthAnchor.constraint(equalTo: newview.widthAnchor, multiplier: 0.65).isActive = true
     }
    
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
