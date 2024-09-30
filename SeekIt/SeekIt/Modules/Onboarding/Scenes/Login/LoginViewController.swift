//
//  LoginViewController.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

// LoginViewController.swift
import UIKit

protocol LoginViewInput: AnyObject {
    // Method to show a loading indicator during an ongoing login process
    func showLoading()

    // Method to hide the loading indicator once the process is complete
    func hideLoading()

    // Method to show a success message when the login is successful
    func showSuccessMessage(_ message: String)

    // Method to show an error message when the login fails
    func showErrorMessage(_ message: String)
}

class LoginViewController: BaseViewController {
    var presenter: LoginPresenter!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Setup UI components (Text fields, Button, etc.)
        usernameTextField.font = FontHelper.bodyFont()
        usernameTextField.textColor = ColorAssets.textPrimary.color
        usernameTextField.placeholder = L10n.onboardingLoginUsernameTextfieldPlaceholder
        
        passwordTextField.font = FontHelper.bodyFont()
        usernameTextField.textColor = ColorAssets.textPrimary.color
        passwordTextField.placeholder = L10n.onboardingLoginPasswordTextfieldPlaceholder
        
        forgetPasswordButton.setTitleColor(ColorAssets.button.color, for: .normal)
        forgetPasswordButton.setTitleColor(ColorAssets.textSecondary.color, for: .highlighted)
        forgetPasswordButton.backgroundColor = .clear
        forgetPasswordButton.titleLabel?.font = FontHelper.bodyFont()
        forgetPasswordButton.setTitle(L10n.onboardingLoginForgetPasswordButtonTitle, for: .normal)
        
        loginButton.setTitleColor(ColorAssets.textReversed.color, for: .normal)
        loginButton.setTitleColor(ColorAssets.textSecondary.color, for: .highlighted)
        loginButton.backgroundColor = ColorAssets.button.color
        loginButton.titleLabel?.font = FontHelper.buttonFont()
        loginButton.setTitle(L10n.onboardingLoginLoginButtonTitle, for: .normal)
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text, username.count > 0, password.count > 0 else {
            showErrorMessage(L10n.onboardingLoginEmptyFieldsErrorMessage)
            return
        }
        presenter.didTapLogin(with: username, and: password)
    }
    
    @IBAction func didTapForgetPasswordButton(_ sender: Any) {
        guard let username = usernameTextField.text else {
            return
        }
        presenter.didTapForgetPassword(with: username)
    }
}

extension LoginViewController: LoginViewInput {
    func showLoading() {
        // Code to show a loading indicator
        showLoadingIndicator()
    }

    func hideLoading() {
        // Code to hide the loading indicator
        hideLoadingIndicator()
    }

    func showSuccessMessage(_ message: String) {
        // Code to show a success message to the user
        showSuccessToast(message: message)
    }

    func showErrorMessage(_ message: String) {
        // Code to show an error message to the user
        showFailureToast(message: message)
    }
}
