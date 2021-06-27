//
//  PayoutsApi.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

final class PayoutsApi: ObservableObject {
    func payout(amount: String) {
        let payoutPath = "/payouts"
    
        let payload = PayoutPayload.getPayload(for: amount)
        let payloadData = try? JSONEncoder().encode(payload)

        let requestBuilder = RequestBuilder()
        guard let request = requestBuilder.buildCircleApiRequest(for: payoutPath, method: .post, payload: payloadData) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error testing api request: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }

            print("works")
        })
        task.resume()
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

    struct PayoutPayload: Encodable {
        let idempotencyKey: String
        let amount: Amount
        let destination: Destination

        init(amount: Amount, destination: Destination) {
            idempotencyKey = UUID().description
            self.amount = amount
            self.destination = destination
        }
    }
}

extension PayoutsApi.PayoutPayload {
    static func getPayload(for amount: String) -> PayoutsApi.PayoutPayload {
        let amount = PayoutsApi.Amount(amount: amount, currency: "USD")
        let destination = PayoutsApi.Destination(id: "3f3aa55a-3977-3be7-9ad5-6dc702cc82a3", type: "wire")
        return PayoutsApi.PayoutPayload(amount: amount, destination: destination)
    }
}
