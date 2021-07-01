//
//  PaymentsApi.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

final class PaymentsApi: ObservableObject {
    private let baseUrl = EazyConfig.circleSandboxBaseUrl
    private let sandboxApiKey = EazyConfig.circleSandboxApiKey

    func checkPayment(with paymentId: String) {
        let path = "/payments/\(paymentId)"
        let requestBuilder = CircleRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }
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
            if let data = data {
                let result = try? JSONDecoder().decode(PaymentStatusResponse.self, from: data)
                print(result)
            }
        })
        task.resume()
    }

    func createPayment() {
            let path = "/payments"
            let requestBuilder = CircleRequestBuilder()
            guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }
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
                if let data = data {
                    let result = try? JSONDecoder().decode(PaymentStatusResponse.self, from: data)
                    print(result)
                }
            })
            task.resume()
    }

    func getPublicKey() {
        let path = "/encryption/public"
        let requestBuilder = CircleRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }
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

            print("works")
            if let data = data {
                let result = try? JSONDecoder().decode(PublicKeyResponse.self, from: data)
                print(result)
            }
        })
        task.resume()
    }
}

extension PaymentsApi {
    struct MetaData: Encodable {
      let email: String?
      let phoneNumber: String?
      let sessionId: String
      let ipAddress: String
    }

    struct Amount: Codable {
        let amount: String
        let currency: String
    }

    struct Source: Codable {
        let id: String
        let type: String
    }

    struct CreateCardPaymentPayload: Encodable {
        let idempotencyKey: String
        let verification: String?
        let keyId: String?
        let amount: Amount
        let source: Source
        let description: String?
        let metadata: MetaData
        let entryptedData: String?
    }
}

extension PaymentsApi {
    struct PaymentStatusResponse: Decodable {
        let id: String
        let type: String
        let merchantId: String
        let amount: Amount
        let description: String
        let status: String
    }
}

extension PaymentsApi {
    struct PublicKeyResponseData: Decodable {
        let keyId: String
        let publicKey: String
    }

    struct PublicKeyResponse: Decodable {
        let data: PublicKeyResponseData
    }
}
