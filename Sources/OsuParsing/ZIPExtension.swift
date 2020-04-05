import Foundation
import ZIPFoundation

extension Entry {
    func isOsuFile() -> Bool {
        return self.path.hasSuffix(OsuFile.fileSuffix)
    }
}

extension Archive {
    func extractOsu(_ file: Entry, _ complition: (String?) -> Void) {
        do {
            try self.extract(file) { data in
                let content = String(data: data, encoding: .utf8)
                complition(content)
            }
        } catch {
            complition(nil)
        }
    }
}
