//
//  RequestBuilder.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

final class RequestBuilder {
    private let baseUrl = EazyConfig.circleSandboxBaseUrl
    private let sandboxApiKey = EazyConfig.circleSandboxApiKey

    func buildCircleApiRequest(for path: String, method: HttpMethod, payload: Data? = nil) -> URLRequest?  {
        guard let url = getFullUrl(for: path) else { return nil }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(sandboxApiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = method.rawValue

        if let payload = payload {
            request.httpBody = payload
        }

        print("Create \(request.httpMethod ?? "") request for url \(request.url?.absoluteString ?? "")")
        return request
    }

    private func getFullUrl(for path: String) -> URL? {
        return URL(string: baseUrl + path)
    }
}

extension RequestBuilder {
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
    }
}
