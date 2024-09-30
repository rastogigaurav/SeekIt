// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Please wait...
  internal static let commonApiClientLoadingIndicatorDescription = L10n.tr("Localizable", "common_api_client_loading_indicator_description", fallback: "Please wait...")
  /// Loading
  internal static let commonApiClientLoadingIndicatorTitle = L10n.tr("Localizable", "common_api_client_loading_indicator_title", fallback: "Loading")
  /// Unable to proceed to due no internet
  internal static let commonApiClientNoInternetErrorMessage = L10n.tr("Localizable", "common_api_client_no_internet_error_message", fallback: "Unable to proceed to due no internet")
  /// No Internet
  internal static let commonApiClientNoInternetErrorTitle = L10n.tr("Localizable", "common_api_client_no_internet_error_title", fallback: "No Internet")
  /// Unable to proceed to due to an eror
  internal static let commonApiClientUnknownErrorMessage = L10n.tr("Localizable", "common_api_client_unknown_error_message", fallback: "Unable to proceed to due to an eror")
  /// Unknown Error
  internal static let commonApiClientUnknownErrorTitle = L10n.tr("Localizable", "common_api_client_unknown_error_title", fallback: "Unknown Error")
  /// Ok
  internal static let commonErrorPopupActionButtonText = L10n.tr("Localizable", "common_error_popup_action_button_text", fallback: "Ok")
  /// Error!
  internal static let commonErrorPopupTitleText = L10n.tr("Localizable", "common_error_popup_title_text", fallback: "Error!")
  /// Are you sure you want to logout?
  internal static let logoutMessage = L10n.tr("Localizable", "logout_message", fallback: "Are you sure you want to logout?")
  /// Input username to proceed.
  internal static let onboardingForgetPasswordEmptyFieldsErrorMessage = L10n.tr("Localizable", "onboarding_forget_password_empty_fields_error_message", fallback: "Input username to proceed.")
  /// Submit
  internal static let onboardingForgetPasswordSubmitButtonTitle = L10n.tr("Localizable", "onboarding_forget_password_submit_button_title", fallback: "Submit")
  /// Username
  internal static let onboardingForgetPasswordUsernameTextfieldPlaceholder = L10n.tr("Localizable", "onboarding_forget_password_username_textfield_placeholder", fallback: "Username")
  /// Input username and password to proceed.
  internal static let onboardingLoginEmptyFieldsErrorMessage = L10n.tr("Localizable", "onboarding_login_empty_fields_error_message", fallback: "Input username and password to proceed.")
  /// Forget?
  internal static let onboardingLoginForgetPasswordButtonTitle = L10n.tr("Localizable", "onboarding_login_forget_password_button_title", fallback: "Forget?")
  /// Don't worry! It happens. Please enter the address associated with your account.
  internal static let onboardingLoginForgetPasswordDescriptionLabelText = L10n.tr("Localizable", "onboarding_login_forget_password_description_label_text", fallback: "Don't worry! It happens. Please enter the address associated with your account.")
  /// Forgot Password?
  internal static let onboardingLoginForgetPasswordTitleLabelText = L10n.tr("Localizable", "onboarding_login_forget_password_title_label_text", fallback: "Forgot Password?")
  /// Login Successfull
  internal static let onboardingLoginLoggedInSuccessMessage = L10n.tr("Localizable", "onboarding_login_logged_in_success_message", fallback: "Login Successfull")
  /// Login
  internal static let onboardingLoginLoginButtonTitle = L10n.tr("Localizable", "onboarding_login_login_button_title", fallback: "Login")
  /// Password
  internal static let onboardingLoginPasswordTextfieldPlaceholder = L10n.tr("Localizable", "onboarding_login_password_textfield_placeholder", fallback: "Password")
  /// Localiable-String.strings
  ///   SeekIt
  /// 
  ///   Created by g.b.rastogi on 29/09/24.
  internal static let onboardingLoginTitleLabelMessage = L10n.tr("Localizable", "onboarding_login_title_label_message", fallback: "Ready to take the next step?")
  /// Username
  internal static let onboardingLoginUsernameTextfieldPlaceholder = L10n.tr("Localizable", "onboarding_login_username_textfield_placeholder", fallback: "Username")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
