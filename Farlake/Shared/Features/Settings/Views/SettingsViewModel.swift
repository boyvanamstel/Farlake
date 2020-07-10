//
//  File.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

final class SettingsViewModel {

    private  let servicesProvider: ServicesProvider
    private var imageDataCache: ImageDataCache { servicesProvider.imageDataCache }

    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
    }

    // MARK: - Actions

    func flushImageDataCache() {
        imageDataCache.clear()
    }

}
