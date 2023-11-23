import Foundation

class ParseManager {
    
    static let shared = ParseManager()
    
    let networkManager: NetworkManager = NetworkRouter(parser: CustomParser())
    
    private init() {}
    
    private func handleRequestResult<T: Decodable>(result: Result<T>, statusCode: Int, completion: @escaping (T?, Error?) -> ()) {
        switch result {
        case .failure(let error):
            DispatchQueue.main.async {
                completion(nil, error as? Error)
            }
        case .success(let value):
            DispatchQueue.main.async {
                if statusCode != 200 && statusCode != 201 {
                    if statusCode == 429 {
                        completion(value, nil)
                    } else {
                        completion(value, "\(statusCode)" as? Error)
                    }
                } else {
                    completion(value, nil)
                }
            }
        }
    }
    
    func multipartFormData<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, Error?) -> ()) -> Void {
        let endpoint = Endpoints.multipartFormData(url: url, parameters: parameters)
        let dispatch = DispatchQueue.global(qos: .userInitiated)
        
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>, statusCode: Int) in
                self.handleRequestResult(result: result, statusCode: statusCode, completion: completion)
            }
        }
    }
    
    func postRequest<T: Decodable>(url: String, parameters: Parameters? = nil, urlParameters: Parameters? = nil, completion: @escaping (T?, Error?) -> ()) -> Void {
        let endpoint: EndpointType = Endpoints.post(url: url, parameters: parameters, urlPamaters: urlParameters)
        let dispatch = DispatchQueue.global(qos: .userInitiated)
        
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>, statusCode: Int) in
                self.handleRequestResult(result: result, statusCode: statusCode, completion: completion)
            }
        }
    }
    
    func putRequest<T: Decodable>(url: String, parameters: Parameters? = nil, urlParameters: Parameters? = nil, completion: @escaping (T?, Error?) -> ()) -> Void {
        let endpoint: EndpointType = Endpoints.put(url: url, parameters: parameters, urlParameters: urlParameters)
        let dispatch = DispatchQueue.global(qos: .userInitiated)
        
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>, statusCode: Int) in
                self.handleRequestResult(result: result, statusCode: statusCode, completion: completion)
            }
        }
    }
    
    func getRequest<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?, Error?) -> ()) -> Void {
        let endpoint: EndpointType = Endpoints.get(url: url, parameters: parameters)
        let dispatch = DispatchQueue.global(qos: .userInitiated)
        
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>, statusCode: Int) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(nil, error as? Error)
                    }
                case .success(let value):
                    DispatchQueue.main.async {
                        if statusCode == 400 {
                            completion(value, "\(statusCode)" as? Error)
                        } else {
                            completion(value, nil)
                        }
                    }
                }
            }
        }
    }
    
    func deleteRequest<T: Decodable>(url: String, parameters: Parameters? = nil, token: String? = nil, completion: @escaping (T?, Error?) -> ()) -> Void {
        let endpoint = Endpoints.delete(url: url, parameters: parameters)
        let dispatch = DispatchQueue.global(qos: .userInitiated)
        
        dispatch.async {
            self.networkManager.request(endpoint) { (result: Result<T>, statusCode: Int) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(nil, error as? Error)
                    }
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(value, nil)
                    }
                }
            }
        }
    }
}
