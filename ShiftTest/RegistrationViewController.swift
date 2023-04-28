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

class RegistrationViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var surnameTextField: UITextField!
    @IBOutlet private weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var registerButton: UIButton!
    
    private var presenter: RegistrationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.isEnabled = false
        
        // set content size of the scroll view to be equal to the size of the view
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        // Register for keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Add tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
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
   
    func areAllFieldsFilled() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty,
              let surname = surnameTextField.text, !surname.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            return false
        }
        return true
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        // set content inset to height of keyboard
        let bottomInset = keyboardFrame.height
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
    }
    
    @objc private func dismissKeyboard() {
        registerButton.isEnabled = areAllFieldsFilled()
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    func showValidationError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

