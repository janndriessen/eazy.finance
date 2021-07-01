//
//  RequestBuilder.swift
//  eazy
//
//  Created by Jann Driessen on 27.06.21.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestBuilder {
    func buildRequest(for path: String, method: HttpMethod, payload: Data?) -> URLRequest?
    init(baseUrl: String, apiKey: String)
}

final class ApiRequestBuilder: RequestBuilder {
    private let baseUrl: String
    private let apiKey: String

    convenience init() {
        let baseUrl = EazyConfig.apiBaseUrl
        let apiKey = ""
        self.init(baseUrl: baseUrl, apiKey: apiKey)
    }

    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }

    func buildRequest(for path: String, method: HttpMethod, payload: Data? = nil) -> URLRequest? {
        guard let url = getFullUrl(for: path) else { return nil }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
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

final class CircleRequestBuilder: RequestBuilder {
    private let baseUrl: String
    private let apiKey: String

    convenience init() {
        let baseUrl = EazyConfig.circleSandboxBaseUrl
        let sandboxApiKey = EazyConfig.circleSandboxApiKey
        self.init(baseUrl: baseUrl, apiKey: sandboxApiKey)
    }

    init(baseUrl: String, apiKey: String) {
        self.baseUrl = baseUrl
        self.apiKey = apiKey
    }

    func buildRequest(for path: String, method: HttpMethod, payload: Data? = nil) -> URLRequest? {
        guard let url = getFullUrl(for: path) else { return nil }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
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
