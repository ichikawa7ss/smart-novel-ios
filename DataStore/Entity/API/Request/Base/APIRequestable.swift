//
//  APIRequestable.swift.swift
//  DataStore
//
//  Created by ichikawa on 2020/09/05.
//

import Foundation
import APIKit

protocol APIRequestable: Request, Encodable {}

extension APIRequestable {
    
    var baseURL: URL {
        // qiita
        return URL(string: "https://31qlocs8rf.execute-api.ap-northeast-1.amazonaws.com/default")!
    }
    
    var parameters: Any? {
        return JSONEncoder().encodeToDictionary(self)
    }

    var dataParser: DataParser {
        return DecodableDataParser()
    }
}

extension APIKit.Request where Self.Response: Decodable {
    
    var headerFields: [String: String] {
        return ["x-api-key": "HVl2wfAsVb2IObEbOq6Wz4oyxLuDIXWkaS2wym6S"]
    }
    
    // 成功した場合
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            assertionFailure()
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

extension JSONEncoder {
    
    /// Encodable構造体からDataに変換したのちに、Dictionaryにする(APIのパラメータ生成用)
    func encodeToDictionary<T: Encodable>(_ value: T) -> [String: Any] {
        do {
            let data = try self.encode(value)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (jsonObject as? [String: Any]) ?? [:]
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}

final class DecodableDataParser: DataParser {

    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
