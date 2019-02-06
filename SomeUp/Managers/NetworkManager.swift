//
//  NetworkManager.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 5.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()

    static func upload(image: UIImage, completion: @escaping (_ error: NSError?, _ imageUrl: String?) -> ()) {

        let clientID = "a4b7dd947eff839"
        let imgurUrl = "https://api.imgur.com/3/image"

        guard let url = URL(string: imgurUrl), let imageData = image.jpegData(compressionQuality: 1) else {
            completion(NSError.defaultNetworkError(), nil)
            return
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(NSUUID().uuidString)"

        request.setValue("multipart/form-data; boundary=\"\(boundary)\"", forHTTPHeaderField: "Content-Type")
        request.setValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")

        request.httpBody = createBody(boundary: boundary, data: imageData, mimeType: "image/jpeg", filename: "photo.jpg")

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                if let imageData = data, let jsonDict = try JSONSerialization.jsonObject(with: imageData, options: []) as? [String: Any], let dataDict = jsonDict["data"] as? [String: Any] {

                    print(dataDict)
                    
                    if let link = dataDict["link"] as? String {
                        completion(nil, link)
                    } else if let errorDict = dataDict["error"] as? [String: Any], let errorCode = errorDict["code"] as? Int, let errorMessage = errorDict["message"] as? String {
                        let error = NSError.createUploadErrorWith(message: errorMessage, code: errorCode)
                        completion(error, nil)
                    } else {
                        completion(NSError.defaultNetworkError(), nil)
                    }
                }
            } catch {
                completion(NSError.defaultNetworkError(), nil)
            }
        }

        task.resume()
    }

    static func createBody(boundary: String, data: Data, mimeType: String, filename: String) -> Data {
        let body = NSMutableData()

        let boundaryPrefix = "--\(boundary)\n"
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: attachment; name=\"image\"; filename=\"\(filename)\"\n")
        body.appendString("Content-Type: \(mimeType)\n\n")
        body.append(data)
        body.appendString("\n")
        body.appendString("--".appending(boundary.appending("--")))

        return body as Data
    }
}
