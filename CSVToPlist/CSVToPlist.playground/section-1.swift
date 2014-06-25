// Playground - Read a basic CSV and export a plist
import Foundation

/*
Desired export format

<key>Algeria</key>
<dict>
    <key>code</key>
    <string>DZ</string>
    <key>countryCode</key>
    <string>213</string>
    <key>name</key>
    <string>Algeria</string>
</dict>
*/

func readURL() -> NSURL {
    
    // Replace with absolute path to file i.e."/Users/collin/Desktop/countries.txt"
    let CSVFilename = "/Users/yourname/Desktop/countries.txt"
    
    let CSVURL = NSURL.fileURLWithPath(CSVFilename)
    
    return CSVURL
}

func writeURL() -> NSURL {
    // Replace with absolute path of where you want to export the file
    let CSVWriteFilename = "./phone_numbers.plist"
    
    let CSVURL = NSURL.fileURLWithPath(CSVWriteFilename)
    
    return CSVURL;
}

func writeDataToURL(data: String, url: NSURL) {
    data.writeToURL(url, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
}

func convertCSVToPlist(url: NSURL) -> String {
    let CSVContent = String.stringWithContentsOfURL(url, encoding: NSUTF8StringEncoding, error: nil)
    
    var countryDataArray: Array<String> = [];
    
    if let content = CSVContent {
        let countryData = content.stringByReplacingOccurrencesOfString("\r", withString: "")
        countryDataArray = countryData.componentsSeparatedByString("\n")
    }
    
    var plistOfCountries: String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        + "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
        + "<plist version=\"1.0\">\n"
        + "<dict>\n"    
    
    for country in countryDataArray {
        var countryValues = country.componentsSeparatedByString(";")
        plistOfCountries += "\t<key>\(countryValues[1])</key>\n"
        plistOfCountries += "\t<dict>\n"
        plistOfCountries += "\t\t<key>countryCode</key>\n"
        plistOfCountries += "\t\t<string>\(countryValues[1])</string>\n"
        plistOfCountries += "\t\t<key>country</key>\n"
        plistOfCountries += "\t\t<string>\(countryValues[0])</string>\n"
        plistOfCountries += "\t\t<key>number</key>\n"
        plistOfCountries += "\t\t<string>\(countryValues[2])</string>\n"
        plistOfCountries += "\t</dict>\n"
    }
    
    plistOfCountries += "</dict>\n</plist>\n"

    return plistOfCountries
}

let CSVURL = readURL()

let plistData = convertCSVToPlist(CSVURL)

let plistWriteURL = writeURL()

writeDataToURL(plistData, plistWriteURL)


