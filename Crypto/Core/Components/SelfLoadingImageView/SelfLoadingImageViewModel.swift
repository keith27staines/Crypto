//
//  SelfLoadingImageViewModel.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import UIKit
import Combine

class SelfloadingImageViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var uiImage: UIImage?
    @Published var error: Error?
    
    var imageGetterSubscription: AnyCancellable?
    
    init(imageUrlString: String?) {
        subscribeToPublisher(imageUrlString: imageUrlString)
    }
    
    func subscribeToPublisher(imageUrlString: String?) {
        self.isLoading = true
        imageGetterSubscription = APIFactory
            .makeImageGetter(urlString: imageUrlString)
            .$image
            .sink { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            } receiveValue: { [weak self] uiImage in
                self?.uiImage = uiImage
                self?.isLoading = false
            }
    }
}
