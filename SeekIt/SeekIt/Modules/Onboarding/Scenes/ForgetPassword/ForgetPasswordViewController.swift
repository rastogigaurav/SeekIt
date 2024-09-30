//
//  ForgetPasswordViewController.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import Foundation

// LoginViewController.swift
import UIKit

protocol ForgetPasswordViewInput: AnyObject {
    // Method to show a loading indicator during an ongoing login process
    func showLoading()

    // Method to hide the loading indicator once the process is complete
    func hideLoading()

    // Method to show a success message when the login is successful
    func showSuccessMessage(_ message: String)

    // Method to show an error message when the login fails
    func showErrorMessage(_ message: String)
}

class ForgetPasswordViewController: BaseViewController {
    var presenter: ForgetPasswordPresenter!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Setup UI components (Text fields, Button, etc.)
        
        titleLabel.font = FontHelper.headerFont()
        titleLabel.textColor = ColorAssets.textPrimary.color
        titleLabel.text = L10n.onboardingLoginForgetPasswordTitleLabelText
        
        descriptionLabel.font = FontHelper.headerFont()
        descriptionLabel.textColor = ColorAssets.textSecondary.color
        descriptionLabel.text = L10n.onboardingLoginForgetPasswordDescriptionLabelText
        
        usernameTextField.font = FontHelper.bodyFont()
        usernameTextField.textColor = ColorAssets.textPrimary.color
        usernameTextField.placeholder = L10n.onboardingForgetPasswordUsernameTextfieldPlaceholder
        
        submitButton.setTitleColor(ColorAssets.textReversed.color, for: .normal)
        submitButton.setTitleColor(ColorAssets.textSecondary.color, for: .highlighted)
        submitButton.backgroundColor = ColorAssets.button.color
        submitButton.titleLabel?.font = FontHelper.buttonFont()
        submitButton.setTitle(L10n.onboardingForgetPasswordSubmitButtonTitle, for: .normal)
    }
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        guard let username = usernameTextField.text, username.count > 0 else {
            showErrorMessage(L10n.onboardingForgetPasswordEmptyFieldsErrorMessage)
            return
        }
        presenter.didTapForgetPassword(with: username)
    }
}

extension ForgetPasswordViewController: ForgetPasswordViewInput {
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
