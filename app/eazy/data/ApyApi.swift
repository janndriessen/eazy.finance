//
//  ApyApi.swift
//  eazy
//
//  Created by Jann Driessen on 04.07.21.
//

import Foundation

import SwiftUI

enum ApyApiError: Error {
    case unexpected(message: String)
    case missingResponse
}

final class ApyApi: ObservableObject {
    @Published var borrowApy: String = ""
    @Published var supplyApy: String = ""

    func fetch() {
        fetchBorrowApy()
        fetchSupplyApy()
    }
}

extension ApyApi {
    private func fetchBorrowApy() {
        let path = "/borrow/apy"
        let requestBuilder = ApiRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                let error = ApyApiError.unexpected(message: error.localizedDescription)
                print(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let error = ApyApiError.unexpected(message: "Error with the response - unexpected status code")
                print(error)
                return
            }

            if let data = data, let result = try? JSONDecoder().decode(ApyResponse.self, from: data) {
                DispatchQueue.main.async {
                    print(result)
                    self.borrowApy = String(format: "%.2f%%", result.apy)
                }
            }
        })
        task.resume()
    }
}

extension ApyApi {
    private func fetchSupplyApy() {
        let path = "/supply/apy"
        let requestBuilder = ApiRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                let error = ApyApiError.unexpected(message: error.localizedDescription)
                print(error)
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                let error = ApyApiError.unexpected(message: "Error with the response - unexpected status code")
                print(error)
                return
            }

            if let data = data, let result = try? JSONDecoder().decode(ApyResponse.self, from: data) {
                DispatchQueue.main.async {
                    print(result)
                    self.supplyApy = String(format: "%.2f%%", result.apy)
                }
            }
        })
        task.resume()
    }
}

private struct ApyResponse: Decodable {
    let apy: Double
    let asset: String
}
