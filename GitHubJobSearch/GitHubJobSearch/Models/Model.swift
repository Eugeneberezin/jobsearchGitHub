//
//  Model.swift
//  GitHubJobSearch
//
//  Created by Eugene Berezin on 12/16/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation



struct Result: Codable {
    var type: String?
    var url: String?
    var created_at: String?
    var company: String?
    var company_url: String?
    var location: String?
    var title: String?
    var description: String?
    var how_to_apply: String?
    var company_logo: String?
    
}
