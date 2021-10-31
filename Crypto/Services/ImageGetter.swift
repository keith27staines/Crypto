//
//  ImageGetter.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import UIKit
import Combine

class ImageGetter {

    @Published var image: UIImage?
    @Published var error: Error?
    
    let urlString: String?
    private var subscription: AnyCancellable?
    
    init(urlString: String?) {
        self.urlString = urlString
        getImage()
    }
    
    private func getImage() {
        do {
            guard
                let urlString = urlString,
                let url = URL(string: urlString)
            else {
                throw CryptoError.badURLString(urlString)
            }
            subscription = URLSession.shared.dataTaskPublisher(for: url)
                .subscribe(on: DispatchQueue.global(qos: .default))
                .tryMap { [weak self] in try self?.transformSessionOutputToImage($0) }
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        self.error = error
                    }
                } receiveValue: { fetchedImage in
                    self.image = fetchedImage
                }
        } catch {
            self.error = error
        }
    }
    
    func transformSessionOutputToImage(_ output: URLSession.DataTaskPublisher.Output) throws -> UIImage {
        let data = try Network().transformSessionOutputToData(output)
        guard let image = UIImage(data: data) else {
            throw CryptoError.invalidImageData()
        }
        return image
    }
}
