import UIKit

var urlFromText = "<p><a href=\"https://ars2.equest.com/?response_id=e0b804211ba9acb4bb3a3848d81de03a\">Apply here</a></p>\n"
func cleanURL(url: String) -> String {
    var newURL = ""
    let urlComponents = url.components(separatedBy: "\"")
    urlComponents.forEach { (component) in
    
        if component.contains("https") {
            newURL = component
        }
    }
    let newCleanURL = newURL.replacingOccurrences(of: "</a></p>", with: "").replacingOccurrences(of: ">", with: "")
    return newCleanURL
}

print(cleanURL(url: urlFromText))

