// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Error {
    /// Unable to manage your response, Please try after sometime.
    internal static let decodingFailed = L10n.tr("Localizable", "Error.decodingFailed")
    /// Please check your internet connectivity.
    internal static let noInternet = L10n.tr("Localizable", "Error.noInternet")
    /// Something went wrong, Please try after sometime.
    internal static let somethingWentWrong = L10n.tr("Localizable", "Error.somethingWentWrong")
    /// Your session has been timed out. Please login again.
    internal static let unauthorized = L10n.tr("Localizable", "Error.unauthorized")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
