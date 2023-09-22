//
//  Extensions.swift
//  Astra
//
//  Created by Amit Shah on 22/09/23.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, radius :Int = 0) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.layer.cornerRadius = CGFloat(radius)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, radius :Int = 0) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, radius: radius)
    }
}
