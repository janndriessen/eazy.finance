//
//  BorrowApi.swift
//  eazy
//
//  Created by Jann Driessen on 30.06.21.
//

import Foundation
import SwiftUI

struct AmountPayload: Encodable {
    let amount: Int
}

final class BorrowApi {
    func getCollateral(for amount: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        let path = "/borrow/liquidity"
        let payload = AmountPayload(amount: amount)
        let payloadData = try? JSONEncoder().encode(payload)

        let requestBuilder = ApiRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get, payload: payloadData) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print("Error testing api request: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data {
            let result = try? JSONDecoder().decode(CollateralResponse.self, from: data)
            print(result)
        }

            print("works")
        })
        task.resume()
    }
}

private struct CollateralResponse: Decodable {
    let borrowAmount: Int
    let collateralNeeded: Int
}
