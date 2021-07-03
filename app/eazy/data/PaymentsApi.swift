//
//  PaymentsApi.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation
import ObjectivePGP

final class PaymentsApi: ObservableObject {
    private let baseUrl = EazyConfig.circleSandboxBaseUrl
    private let sandboxApiKey = EazyConfig.circleSandboxApiKey

    private var publicKey: PublicKey?

    init() {
        getPublicKey()
    }

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
                print("Error with the response, unexpected status code")
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

    // Returns success or error
    func createPayment(amount: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        let path = "/payments"

        guard let publicKey = publicKey else { return }
        let entryptedData = getEncryptedCvv("123", publicKey: publicKey.publicKey)

        let payload = CreateCardPaymentPayload(verification: "cvv",
                                               keyId: publicKey.keyId,
                                               amount: Amount(amount: String(amount), currency: "USD"),
                                               source: Source(id: "58c93589-911f-4bcb-a918-87c593296791", type: "card"),
                                               description: "Supply Payment",
                                               metadata: MetaData(email: "satoshi@circle.com",
                                                                  phoneNumber: "+14155555555",
                                                                  sessionId: "DE6FA86F60BB47B379307F851E238617",
                                                                  ipAddress: "244.28.239.130"),
                                               entryptedData: entryptedData)
        guard let payloadData = try? JSONEncoder().encode(payload) else { return }

        let requestBuilder = CircleRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .post, payload: payloadData) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error testing api request: \(error)")
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code")
                completion(.success(false))
                return
            }

            if let data = data, let paymentStatusResponse = try? JSONDecoder().decode(PaymentStatusResponse.self, from: data) {
                print("Created payment with id:", paymentStatusResponse.data.id)
                completion(.success(true))
                return
            }
            completion(.success(false))
        })
        task.resume()
    }
}

// MARK: - Private

extension PaymentsApi {
    private func getEncryptedCvv(_ cvv: String, publicKey: String) -> String? {
        let cvv = EncryptedData(cvv: cvv)
        guard let cvvJson = try? JSONEncoder().encode(cvv) else { return nil }

        guard let decodedKey = Data(base64Encoded: publicKey) else { return nil }
//        let armoredKey = Armor.armored(decodedKey, as: .publicKey)
//        guard let armoredKeyData = armoredKey.data(using: .utf8) else { return nil }
        guard let keys = try? ObjectivePGP.readKeys(from: decodedKey) else { return nil }

        guard let encrypted = try? ObjectivePGP.encrypt(cvvJson, addSignature: false, using: keys, passphraseForKey: nil) else { return nil }
        let entryptedData = encrypted.base64EncodedString()
        return entryptedData
    }

    private func getPublicKey() {
        let path = "/encryption/public"
        let requestBuilder = CircleRequestBuilder()
        guard let request = requestBuilder.buildRequest(for: path, method: .get) else { return }

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                print("Error getting public key: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code")
                return
            }

            if let data = data, let result = try? JSONDecoder().decode(PublicKeyResponse.self, from: data) {
                self.publicKey = result.data
                print(result.data)
                
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

    struct EncryptedData: Encodable {
        let cvv: String
    }

    struct CreateCardPaymentPayload: Encodable {
        let idempotencyKey = UUID().uuidString
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
    struct PaymentStatus: Decodable {
        let id: String
        let type: String
        let merchantId: String
        let amount: Amount
        let description: String
        let status: String
    }

    struct PaymentStatusResponse: Decodable {
        let data: PaymentStatus
    }
}

extension PaymentsApi {
    struct PublicKey: Decodable {
        let keyId: String
        let publicKey: String
    }

    struct PublicKeyResponse: Decodable {
        let data: PublicKey
    }
}
