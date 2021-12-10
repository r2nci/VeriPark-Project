//
//  ApiWrapper.swift
//  VeriParkProject
//
//  Created by Ramazan ikinci on 7.12.2021.
//

import Foundation
import Alamofire
import CryptoSwift


class ApiWrapper {
    class func getStartApp(success:@escaping (StartAppResponseDto)->Void,
                          failure:@escaping (String)->Void) {
        Loading.showUniversalLoadingView(true)
        guard let url = AppConstant.baseURL?.appendingPathComponent(AppConstant.startApp).absoluteString.removingPercentEncoding else { return }
        var jsonData : Data?
        var urlWithPath : URLRequest = URLRequest(url: URL(string: url)!)
        urlWithPath.httpMethod = HTTPMethod.post.rawValue
        urlWithPath.setValue("application/json", forHTTPHeaderField: "Content-Type")
        var body = [String:Any]()
        body["deviceID"] = DeviceInfo.getUUID()
        body["deviceModel"] = DeviceInfo.deviceName()
        body["manifacturer"] = "Apple"
        if DeviceInfo.getPlatformName() {
            body["platformName"] = "iOSSimulator"
        } else {
            body["platformName"] = "iOS"
        }
     
        body["systemVersion"] = DeviceInfo.deviceVersion()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlWithPath.httpBody = jsonData
        } catch {
            
        }
        AF.request(urlWithPath).responseJSON { (response) in
            switch response.result {
            case .success(_):
                Loading.showUniversalLoadingView(false)
                guard let data = response.data else { return }
                    guard let json = try? JSONDecoder().decode(StartAppResponseDto.self, from: data) else { return failure("Hata oluştu birazdan tekrar deneyiniz")}
                    success(json)
            case .failure(let err):
                Loading.showUniversalLoadingView(false)
                failure(err.errorDescription ?? "")
            }
        }
    }
    
    class func getStocksList(paramsAuthor:String,paramsPerioad:String,
                            success:@escaping (StocksListResponseDto)->Void,
                             failure:@escaping (String)->Void) {
        Loading.showUniversalLoadingView(true)
        guard let url = AppConstant.baseURL?.appendingPathComponent(AppConstant.stockList).absoluteString.removingPercentEncoding else { return }
        var body = [String:Any]()
        var jsonData : Data?
        var urlWithPath : URLRequest = URLRequest(url: URL(string: url)!)
        urlWithPath.httpMethod = HTTPMethod.post.rawValue
        urlWithPath.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlWithPath.setValue(paramsAuthor, forHTTPHeaderField:"X-VP-Authorization")
        
        body["period"] = paramsPerioad
        do {
            jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlWithPath.httpBody = jsonData
        } catch {
            
        }
        AF.request(urlWithPath).responseJSON { response in
            switch response.result {
            case .success(_):
                Loading.showUniversalLoadingView(false)
                guard let data = response.data else { return }
                    guard let json = try? JSONDecoder().decode(StocksListResponseDto.self, from: data) else { return  failure("Hata oluştu birazdan tekrar deneyiniz")}
                success(json)
            case .failure(let err):
                Loading.showUniversalLoadingView(false)
            }
          
        }
    }
    
    class func getStockDetail(paramsID:String,paramsAuthor:String,
                              success:@escaping (StockDetailResponseDto)->Void,
                              failure:@escaping (String) -> Void) {
        Loading.showUniversalLoadingView(true)
        guard let url = AppConstant.baseURL?.appendingPathComponent(AppConstant.stockDetail).absoluteString.removingPercentEncoding else { return }
        var body = [String:Any]()
        var jsonData : Data?
        var urlWithPath : URLRequest = URLRequest(url: URL(string: url)!)
        urlWithPath.httpMethod = HTTPMethod.post.rawValue
        urlWithPath.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlWithPath.setValue(paramsAuthor, forHTTPHeaderField:"X-VP-Authorization")
        body["id"] = paramsID
        do {
            jsonData = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            urlWithPath.httpBody = jsonData
        } catch {
            
        }
        AF.request(urlWithPath).responseJSON { response in
            switch response.result {
              
            case .success(_):
                Loading.showUniversalLoadingView(false)
                guard let data = response.data else { return }
                guard let json = try? JSONDecoder().decode(StockDetailResponseDto.self, from: data) else { return  failure("Hata oluştu birazdan tekrar deneyiniz") }
                success(json)
                
            case .failure(let err):
                Loading.showUniversalLoadingView(false)
                print(err)
            }
          
        }
    }
}

