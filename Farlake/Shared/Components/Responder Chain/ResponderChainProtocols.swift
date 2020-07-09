//
//  ResponderChainProtocols.swift
//  Farlake
//
//  Created by Boy van Amstel on 09/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import Foundation

/// Can be added to a UIResponder that knows how to refresh the gallery.
@objc protocol GalleryRefreshableAction: AnyObject {
  func refreshGallery()
}
