import UIKit

var urlFromText = "<p><a href=\"https://jobs.lever.co/gameclosure/a50c5aa4-6526-425f-9767-2b8e11800857?lever-origin=applied&amp;lever-source%5B%5D=GitHub\">https://jobs.lever.co/gameclosure/a50c5aa4-6526-425f-9767-2b8e11800857?lever-origin=applied&amp;lever-source%5B%5D=GitHub</a></p>\n"

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

