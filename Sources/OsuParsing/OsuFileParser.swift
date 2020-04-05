import Foundation
class OsuFileParser {
    
    internal func parse(_ content: String?) -> Beatmap? {
        if !isValid(content: content) {
            return nil
        }
        
        let content = content!
        let version = getVersion(from: content)
        let sectionTitles = seperateSectionTitle(from: content)
        let sectionContents = seperateSectionContent(from: content, with: sectionTitles)
        let section = Dictionary(uniqueKeysWithValues: zip(sectionTitles, sectionContents))
        guard let beatmapDetail = try? section.mapValues ({ content -> DetailObject in
            let key = (section as NSDictionary).allKeys(for: content)[0] as! String
            let detail = try getParser(of: key)!.parse(content)
            return detail
        }) else {
            return nil
        }
        
        
        return Beatmap(version: version,
                       info: beatmapDetail[Beatmap.Section.General.rawValue] as! GeneralInfo,
                       editor: beatmapDetail[Beatmap.Section.Editor.rawValue] as! Editor,
                       metadata: beatmapDetail[Beatmap.Section.Metadata.rawValue] as! Metadata,
                       diff: beatmapDetail[Beatmap.Section.Difficulty.rawValue] as! Difficulty,
                       events: beatmapDetail[Beatmap.Section.Events.rawValue] as! Events,
                       timing: beatmapDetail[Beatmap.Section.TimingPoints.rawValue] as! TimingPoints,
                       colours: beatmapDetail[Beatmap.Section.Colours.rawValue] as! Colours,
                       objects: beatmapDetail[Beatmap.Section.HitObjects.rawValue] as! HitObjects
        )
    }
    
    private func isValid(content: String?) -> Bool {
        return content != nil && isValidOsuFile(content: content!)
    }
    
    private func isValidOsuFile(content: String) -> Bool {
        return content.starts(with: Beatmap.versionDeclarationHead)
    }
    
    private func getVersion(from content: String) -> Int {
        let firstLine = content.components(separatedBy: CharacterSet.newlines).first!
        return Int(firstLine.dropFirst(Beatmap.versionDeclarationHead.count))!
    }
    
    private func seperateSectionTitle(from content: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: Beatmap.sectionTitleRegex)
            let results = regex.matches(in: content, range: NSRange(content.startIndex..., in: content))
            return results.map { result in
                if let range = Range(result.range(withName: "sectionName"), in: content) {
                    return String(content[range])
                }
                return ""
            }
        } catch {
            return []
        }
    }
    
    private func seperateSectionContent(from content: String, with titles: [String]) -> [String] {
        let option = NSRegularExpression.Options.dotMatchesLineSeparators
        var contents: [String] = []
        for i in 0 ..< titles.count-1 {
            let regexPattern = String(format: Beatmap.sectionContentRegex, arguments: [titles[i], titles[i+1]])
            let sectionContent = extractSectionContent(content, with: regexPattern, option: option)
            contents.append(sectionContent)
        }
        let lastContent = extractLastSection(content, lastTitle: titles.last!)
        contents.append(lastContent)
        return contents
    }
    
    private func extractSectionContent(_ content: String, with pattern: String, option: NSRegularExpression.Options) -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: option)
            if let result = regex.firstMatch(in: content, range: NSRange(content.startIndex..., in: content)) {
                let range = Range(result.range(withName: "content"), in: content)!
                return String(content[range])
            } else {
                return ""
            }
        } catch {
            return ""
        }
    }
    
    private func extractLastSection(_ content: String, lastTitle: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "\(lastTitle)\\](?<content>.+)", options: .dotMatchesLineSeparators)
            if let result = regex.firstMatch(in: content, range: NSRange(content.startIndex..., in: content)) {
                let range = Range(result.range(withName: "content"), in: content)!
                return String(content[range])
            } else {
                return ""
            }
        } catch {
            return ""
        }
    }
    
    private func getParser(of parserRaw: String) -> Parser? {
        let parserMap: [String: Parser] = [
            Beatmap.Section.General.rawValue: GeneralInfoParser(),
            Beatmap.Section.Editor.rawValue: EditorParser(),
            Beatmap.Section.Metadata.rawValue: MetadataParser(),
            Beatmap.Section.Difficulty.rawValue: DifficultyParser(),
            Beatmap.Section.Events.rawValue: EventsParser(),
            Beatmap.Section.TimingPoints.rawValue: TimingPointsParser(),
            Beatmap.Section.Colours.rawValue: ColoursParser(),
            Beatmap.Section.HitObjects.rawValue: HitObjectsParser()
        ]
        return parserMap[parserRaw]
    }
}
