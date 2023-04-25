//
//  ViewController.swift
//  ShiftTest
//
//  Created by Константин Березовский on 2023-04-23.
//

import UIKit

protocol RegistrationViewProtocol: AnyObject {
    func showValidationError(_ message: String)
}

class RegistrationViewController: UIViewController {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    private var presenter: RegistrationPresenterProtocol!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            presenter = RegistrationPresenter(view: self)
        }
    
    
    @IBAction private func registerButtonTapped() {
        let name = nameTextField.text ?? ""
        let surname = surnameTextField.text ?? ""
        let dateOfBirth = dateOfBirthPicker.date
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        presenter.registerUser(name: name, surname: surname, dateOfBirth: dateOfBirth, password: password, confirmPassword: confirmPassword)
        
        performSegue(withIdentifier: "goToContests", sender: nil)
        
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func showValidationError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

