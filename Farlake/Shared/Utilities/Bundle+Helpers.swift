//
//  Bundle+Helpers.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import UIKit

extension Bundle {
    var icon: UIImage? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.first else { return nil }

        return UIImage(named: lastIcon)
    }

    var appName: String { infoDictionary?["CFBundleName"] as! String }
    var appVersion: Int { Int(infoDictionary?["CFBundleVersion"] as! String)! }
    var appShortVersion: String { infoDictionary?["CFBundleShortVersionString"] as! String }

    var companyName: String { "Danger Cove" }
    var appWebsite: URL { URL(string: "https://www.dangercove.com/albumfiller")! }
}
