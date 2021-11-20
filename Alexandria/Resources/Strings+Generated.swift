// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
    /// 位置情報をオンにして現在地から近い図書館を検索します。
    internal static let adderessAlertMessage = L10n.tr("Localizable", "adderessAlertMessage")
    /// 対象図書館を確定する
    internal static let adderssConfirmButtonTitle = L10n.tr("Localizable", "adderssConfirmButtonTitle")
    /// キャンセル
    internal static let cancelButtonTitle = L10n.tr("Localizable", "cancelButtonTitle")
    /// 削除する
    internal static let deleteButtonTitle = L10n.tr("Localizable", "deleteButtonTitle")
    /// エラー
    internal static let errorAlertTitle = L10n.tr("Localizable", "errorAlertTitle")
    /// 設定されている位置情報を削除しますか？
    internal static let locationDeleteAlertTitle = L10n.tr("Localizable", "locationDeleteAlertTitle")
    /// 位置情報が設定されていません
    internal static let locationNotSelectAlertTitle = L10n.tr("Localizable", "locationNotSelectAlertTitle")
    /// OK
    internal static let okButtonTitle = L10n.tr("Localizable", "oKButtonTitle")
    /// 最近の検索
    internal static let recentSearchText = L10n.tr("Localizable", "recentSearchText")
    /// 書籍名
    internal static let searchBookName = L10n.tr("Localizable", "searchBookName")
    /// 検索
    internal static let searchButtonText = L10n.tr("Localizable", "searchButtonText")
    /// 書籍を検索
    internal static let seatchBookTitle = L10n.tr("Localizable", "seatchBookTitle")
    /// 近くに図書館が見つかりませんでした。
    internal static let selectAddressErrorEmptyNearbyLibraries = L10n.tr("Localizable", "selectAddressErrorEmptyNearbyLibraries")
    /// エラー
    internal static let selectAddressErrorTitle = L10n.tr("Localizable", "selectAddressErrorTitle")
    /// 近隣の図書館検索結果
    internal static let selectAddressSectionTitle = L10n.tr("Localizable", "selectAddressSectionTitle")
    /// 設定する
    internal static let setButtonTitle = L10n.tr("Localizable", "SetButtonTitle")
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
