//
//  SettingsView.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import SwiftUI

// swiftlint:disable multiple_closures_with_trailing_closure
struct SettingsView: View {

    var viewModel: SettingsViewModel?

    @State var isCacheCleared = false

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .systemGroupedBackground

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("CACHE")) {
                    Button(action: {
                        self.viewModel?.flushImageDataCache()
                        withAnimation {
                            self.isCacheCleared = true
                        }
                    }) {
                        HStack(spacing: 10) {
                            if isCacheCleared {
                                Image(systemName: "checkmark")
                            }
                            Text("Flush Thumbnail Cache")
                        }
                    }
                    Text("Frees up space, but requires all images to be downloaded and resized again.")
                        .foregroundColor(.secondary)
                }
                Section(header: Text("ABOUT")) {
                    VStack(alignment: .center, spacing: 10.0) {
                        Image("FarlakeIcon")
                            .padding()
                        Text("\(Bundle.main.appName) \(Bundle.main.appShortVersion) (\(Bundle.main.appVersion))")
                        HStack(spacing: 4.0) {
                            Text("by").font(.subheadline)
                            Button(action: {
                                UIApplication.shared.open(Bundle.main.appWebsite)
                            }) { Text(Bundle.main.companyName).font(.subheadline) }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
            .navigationBarTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
// swiftlint:enable multiple_closures_with_trailing_closure
