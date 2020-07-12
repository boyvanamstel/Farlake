//
//  GalleryEmptyView.swift
//  Farlake
//
//  Created by Boy van Amstel on 10/07/2020.
//  Copyright © 2020 Boy van Amstel. All rights reserved.
//

import SwiftUI

struct GalleryEmptyView: View {
    var body: some View {
        VStack(spacing: 40.0) {
            Image(systemName: "questionmark.diamond")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 100.0)
                .accessibility(identifier: "Gallery Empty Indicator")
            Text("The gallery is empty.")
                .accessibility(identifier: "Gallery Empty Label")
        }
    }
}

struct GalleryEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryEmptyView()
    }
}
