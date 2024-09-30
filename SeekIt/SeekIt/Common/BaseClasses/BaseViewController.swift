//
//  BaseViewController.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import UIKit
import ProgressHUD

class BaseViewController: UIViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    // MARK: - Common Setup Methods
    func setupView() {
        view.backgroundColor = .white
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    // Method to set the navigation title with custom attributes
    func setNavigationBarTitle(_ title: String, font: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold), color: UIColor = .black) {
        self.navigationItem.title = title
        
        // Customize the title's appearance
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        // Apply to the navigation bar if the view controller is in a navigation controller
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
    }
    
    // MARK: - Loading Indicator
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            ProgressHUD.animate(L10n.commonApiClientLoadingIndicatorDescription, .activityIndicator, interaction: false)
        }
    }
    
    func hideLoadingIndicator() {
        ProgressHUD.dismiss()
    }
    
    func showSuccessToast(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            ProgressHUD.succeed(message,interaction: false, delay: 2.0)
        }
    }
    
    func showFailureToast(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            ProgressHUD.failed(message,interaction: false, delay: 2.0)
        }
    }

    // MARK: - Error Handling
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: L10n.commonErrorPopupTitleText, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.commonErrorPopupActionButtonText, style: .default))
        present(alert, animated: true, completion: nil)
    }
}

