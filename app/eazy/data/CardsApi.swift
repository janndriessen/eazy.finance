//
//  CardsApi.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation
import SwiftUI

struct Card {
    let name: String
    let cardType: String
    let number: String
    let expires: String
}

final class CardsApi: ObservableObject {
    private let baseUrl = EazyConfig.circleSandboxBaseUrl
    private let sandboxApiKey = EazyConfig.circleSandboxApiKey

    @Published var cards: [Card] = []

    func createCard(payload: CreateCardPayload) {
        let cardsUrl = "/v1/cards"

        guard let url = URL(string: baseUrl + cardsUrl) else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(sandboxApiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(payload)

        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with adding car: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }

            print("created")
            let createdCard = Card(name: "Satoshi Nakamoto", cardType: "Visa", number: "4111111111111", expires: "01/22")
            self.cards = [createdCard]
//            if let data = data {
//                let result = try? JSONDecoder().decode(CreateCardResponse.self, from: data)
//            }
        })
        task.resume()
    }

    func testAuth() {
        guard let url = URL(string: "https://api-sandbox.circle.com/v1/configuration") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(sandboxApiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

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

extension CardsApi {
    struct MetaData: Encodable {
      let email: String?
      let phoneNumber: String?
      let sessionId: String
      let ipAddress: String
    }

    struct BillingDetails: Encodable {
        let name: String
        let city: String
        let country: String
        let line1: String
        let line2: String
        let district: String
        let postalCode: String
    }

    struct CreateCardPayload: Encodable {
        let idempotencyKey: String
        let keyId: String
        let encryptedData: String
        let billingDetails: BillingDetails
        let expMonth: Int
        let expYear: Int
        let metadata: MetaData
    }
}

extension CardsApi.CreateCardPayload {
    static var sathoshisVisa: CardsApi.CreateCardPayload {
        let metaData = CardsApi.MetaData(email: "satoshi@circle.com", phoneNumber: "+1415555555", sessionId: "123", ipAddress: "93.226.87.1")
        let billingDetails = CardsApi.BillingDetails(name: "Satoshi Nakamoto",
                                                     city: "Miami Beach",
                                                     country: "US",
                                                     line1: "99 Random St",
                                                     line2: "Suite 1",
                                                     district: "FL",
                                                     postalCode: "01234")
        return CardsApi.CreateCardPayload(idempotencyKey: "ba943ff1-ca16-49b2-ba55-1057e70ca5c7",
                                          keyId: "fe57d4b1-9b8e-4606-a869-827eb4ac5bdf",
                                          encryptedData: "",
                                          billingDetails: billingDetails,
                                          expMonth: 1,
                                          expYear: 2022,
                                          metadata: metaData)
    }
}
