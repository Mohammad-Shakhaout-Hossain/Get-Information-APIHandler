//
//  ApiHandler.swift
//  Get Information
//
//  Created by Shakhawat Hossain Shakib on 9/12/20.
//

import Foundation
class ApiHandler {
    
    var errorMessage = ""
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    typealias QueryResult = ([[String: String]]) -> Void
    
    func getList() {
        
    }
    
    func getApiInfo(searchTerm: String, completion: @escaping QueryResult) {
      dataTask?.cancel()
      if var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/users") {
        guard let url = urlComponents.url else {
          return
        }
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
          defer {
            self?.dataTask = nil
          }
          if let error = error {
            self?.errorMessage += "DataTask error: " +
                                    error.localizedDescription + "\n"
          } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
            var parsedArray = [[String: String]]()
            do {
                if let responseArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]{
                    print("response array: \(responseArray)")
                    
                    for userDict in responseArray {
                        
                        var simplifiedDict = [String: String]()
                        
                        simplifiedDict["id"] = userDict["id"] as? String
                        simplifiedDict["name"] = userDict["name"] as? String
                        simplifiedDict["username"] = userDict["username"] as? String
                        simplifiedDict["email"] = userDict["email"] as? String
                        
                        let addressDict = userDict["address"] as! [String : Any]
                        let addressString = "\(String(describing: addressDict["street"])), \(String(describing: addressDict["suite"])), \(String(describing: addressDict["city"])), \(String(describing: addressDict["zipcode"]))"
                        
                        let geoData = addressDict["geo"] as! [String:String]
                        let latitude = geoData["lat"]
                        let longitude = geoData["lng"]
                        simplifiedDict["address"] = addressString
                        
                        simplifiedDict["phone"] = userDict["phone"] as? String
                        simplifiedDict["website"] = userDict["website"] as? String
                        
                        let companyDict = userDict["company"] as! [String : Any]
                        let companyString = "\(companyDict["name"] as! String), \(companyDict["catchPhrase"] as! String), \(companyDict["bs"] as! String)"
                        simplifiedDict["company"] = companyString
                        
                        parsedArray.append(simplifiedDict)
                    }
                }
            } catch let parseError as NSError {
//                errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
              return
            }
            self?.defaultSession
            DispatchQueue.main.async {
                completion(parsedArray)
            }
          }
        }
        dataTask?.resume()
      }
    }
}
