import Foundation
class GeneralInfoParser: Parser {
	private let requiredPropertyie = "AudioFilename"
    
    func parse(_ content: String) throws -> DetailObject {
		let lines = content.components(separatedBy: CharacterSet.newlines).filter { line in
			return !line.isEmpty
		}
		var propertyMap: [String: String] = [:]
		for line in lines {
			let (name, value) = try extractProperty(line: line)
            propertyMap.updateValue(value, forKey: name)
		}
        if !propertyMap.contains(where: { key, _ in key == requiredPropertyie}) {
			//file format isn't correct
			//return a null info
            throw ParsingError.wrongFormat
		}
        
        let builder = GeneralInfo.Builder(audioFileName: propertyMap["AudioFilename"]!)
        for (property, value) in propertyMap {
            set(builder, withProperty: property, value: value)
        }
        return builder.build()
	}
    
    private func extractProperty(line: String) throws -> (String, String) {
        let splitted = line.split(separator: ":")
        if splitted.count != 2 {
            throw ParsingError.wrongFormat
        }
        let key = splitted[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let value = splitted[1].trimmingCharacters(in: .whitespacesAndNewlines)
        return (key, value)
    }
    
    private func set(_ builder: GeneralInfo.Builder, withProperty property: String, value:  String) {
        switch property {
            case "AudioLeadIn":
                if let leadIn = Int(value) {
                    builder.setAudioLeadIn(to: leadIn)
                } else {
                    
                }
            
        }
    }
}
