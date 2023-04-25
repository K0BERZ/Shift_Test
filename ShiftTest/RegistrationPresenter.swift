//
//  RegistrationPresenter.swift
//  ShiftTest
//
//  Created by Константин Березовский on 2023-04-23.
//

import UIKit
import CoreData

var currentUser: String = ""

protocol RegistrationPresenterProtocol {
    func registerUser(name: String, surname: String, dateOfBirth: Date, password: String, confirmPassword: String)
}

class RegistrationPresenter: RegistrationPresenterProtocol {
    private weak var view: RegistrationViewProtocol!
    
    init(view: RegistrationViewProtocol) {
        self.view = view
    }
    
    func registerUser(name: String, surname: String, dateOfBirth: Date, password: String, confirmPassword: String) {
        let nameRegex = "^[a-zA-Zа-яА-ЯёЁ]+$"
        guard NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name) else {
            view.showValidationError("Некорректное имя! Имя не должно содержать цифры, пробелы и специальные символы.")
            return
        }
        
        guard NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: surname) else {
            view.showValidationError("Некорректная фамилия! Фамилия не должна содержать цифры, пробелы и специальные символы.")
            return
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        guard NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password) else {
            view.showValidationError("Пароль должен состоять из символов латинского алфавита, содержать как минимум одну заглавную букву, одну строчную букву, одну цифру, один специальный символ и иметь длину не менее 8 символов.")
            return
        }
        
        guard password == confirmPassword else {
            view.showValidationError("Пароли не совпадают")
            return
        }
        
        // Save username to CoreData
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let user = User(context: context)
        currentUser = name
        user.name = name
        user.surname = surname
        user.dateOfBirth = dateOfBirth
        user.password = password
        try? context.save()
    }
}
