// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum App {
    /// SmileySurvey
    internal static let name = L10n.tr("Localizable", "app.name")
  }

  internal enum General {
    /// Done
    internal static let done = L10n.tr("Localizable", "general.done")
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title")
    internal enum General {
      /// General
      internal static let title = L10n.tr("Localizable", "settings.general.title")
      internal enum Pin {
        /// Not set
        internal static let empty = L10n.tr("Localizable", "settings.general.pin.empty")
        /// PIN
        internal static let title = L10n.tr("Localizable", "settings.general.pin.title")
      }
    }
  }

  internal enum Survey {
    internal enum Detail {
      /// Delete
      internal static let delete = L10n.tr("Localizable", "survey.detail.delete")
      /// %d %%
      internal static func percentage(_ p1: Int) -> String {
        return L10n.tr("Localizable", "survey.detail.percentage", p1)
      }
      /// Start
      internal static let start = L10n.tr("Localizable", "survey.detail.start")
    }
    internal enum Form {
      /// Create survey
      internal static let create = L10n.tr("Localizable", "survey.form.create")
      /// Survey
      internal static let surveySection = L10n.tr("Localizable", "survey.form.surveySection")
      /// New survey
      internal static let title = L10n.tr("Localizable", "survey.form.title")
      internal enum Name {
        /// Must not be empty
        internal static let error = L10n.tr("Localizable", "survey.form.name.error")
        /// Survey name
        internal static let hint = L10n.tr("Localizable", "survey.form.name.hint")
      }
      internal enum Question {
        /// Most not be empty
        internal static let error = L10n.tr("Localizable", "survey.form.question.error")
        /// Survey question
        internal static let hint = L10n.tr("Localizable", "survey.form.question.hint")
      }
    }
    internal enum Grid {
      /// No surveys yet
      internal static let empty = L10n.tr("Localizable", "survey.grid.empty")
      /// Surveys
      internal static let title = L10n.tr("Localizable", "survey.grid.title")
    }
    internal enum Item {
      /// Number of correspondents: %d
      internal static func correspondents(_ p1: Int) -> String {
        return L10n.tr("Localizable", "survey.item.correspondents", p1)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
