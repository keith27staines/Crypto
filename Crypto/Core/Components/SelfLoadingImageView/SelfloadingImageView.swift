//
//  ImageView.swift
//  Crypto
//
//  Created by Keith Staines on 30/10/2021.
//

import Foundation
import SwiftUI

struct SelfloadingImageView: View {
    
    @StateObject private var vm: SelfloadingImageViewModel
    
    init(imageUrlString: String?) {
        let model = SelfloadingImageViewModel(imageUrlString: imageUrlString)
        _vm = StateObject(wrappedValue: model)
    }
    
    var body: some View {
        VStack {
            if let image = vm.uiImage {
                Image(uiImage: image)
                    .resizable()
            }
            if vm.isLoading {
                ProgressView()
            }
        }
    }
}
