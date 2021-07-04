//
//  PayoutsApi.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

final class PayoutsApi: ObservableObject {
    func payout(amount: String, completion: @escaping () -> Void) {
        let payoutPath = "/payouts"
    
        let payload = getPayload(for: amount)
        let payloadData = try? JSONEncoder().encode(payload)

        let requestBuilder = CircleRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: payoutPath, method: .post, payload: payloadData) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error testing api request: \(error)")
                completion()
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                completion()
                return
            }

            print("works")
            completion()
        })
        task.resume()
    }

    private func getPayload(for amount: String) -> PayoutsApi.PayoutPayload {
        let metaData = MetaData(beneficiaryEmail: "satoshi@circle.com")
        let amount = Amount(amount: amount, currency: "USD")
        let destination = Destination(id: "3f3aa55a-3977-3be7-9ad5-6dc702cc82a3", type: "wire")
        return PayoutPayload(amount: amount, destination: destination, metaData: metaData)
    }
}

extension PayoutsApi {
    struct Amount: Encodable {
        let amount: String
        let currency: String
    }

    struct Destination: Encodable {
        let id: String
        let type: String
    }

    struct MetaData: Encodable {
        let beneficiaryEmail: String
    }

    struct PayoutPayload: Encodable {
        let idempotencyKey = UUID().uuidString
        let amount: Amount
        let destination: Destination
        let metaData: MetaData
    }
}
