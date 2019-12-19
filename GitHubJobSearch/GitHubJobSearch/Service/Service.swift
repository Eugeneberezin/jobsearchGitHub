//
//  Service.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() //Singleton
    func fetchJobs(description: String, city:String, completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://jobs.github.com/positions.json?description=\(description.replacingOccurrences(of: " ", with: "+").lowercased())&location=\(city.replacingOccurrences(of: " ", with: "+").lowercased())"
                 guard let url = URL(string: urlString) else { return }

                 // fetch data from internet
                 URLSession.shared.dataTask(with: url) { (data, resp, err) in

                     if let err = err {
                         print("Failed to fetch apps:", err)
                        completion([], nil)
                         return
                     }


                     guard let data = data else { return }

                     do {
                         let searchResult = try JSONDecoder().decode([Result].self, from: data)
                        completion(searchResult, nil)
                        
                        //print(searchResult)
                        print(urlString)

                     } catch let jsonErr {
                         print("Failed to decode json:", jsonErr)
                        completion([], jsonErr)
                     }



                 }.resume() // fires off the request
        
    }
    
     
    }

    
    
    



