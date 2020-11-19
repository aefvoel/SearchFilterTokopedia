//
//  ApiRequest.swift
//  SearchFilterTokopedia
//
//  Created by Toriq Wahid Syaefullah on 18/11/20.
//

import Foundation
import SwiftyJSON
import Alamofire

enum NetworkError: Error {
    case failure
    case success
}


class APIRequest {
    let baseUrl = "https://ace.tokopedia.com/search/v2.5/"
    func filter(params: Parameter, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        let filterUrl = "\(baseUrl)product?q=\(params.q)&pmin=\(params.pmin)&pmax=\(params.pmax)&wholesale=\(params.wholesale)&official=\(params.official)&fshop=\(params.fshop)&start=\(params.start)&rows=\(params.rows)"
        
        AF.request(filterUrl).responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            let json = try? JSON(data: data)
            let results = json?["data"].arrayValue
            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(results, .success)
        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        AF.request(url).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}
