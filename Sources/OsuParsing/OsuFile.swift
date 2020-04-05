import Foundation

class OsuFile {
    //This version declaration should be followed by a number.
    //For example, osu file format v14
    internal static let versionDeclarationHead = "osu file format v"
    internal static let fileSuffix = ".osu"
    internal static let sectionTitleRegex = "\\[(?<sectionName>.+)\\]"
    internal static let sectionContentRegex = "%@\\](?<content>.+)\\[%@"
    
	internal let version: Int
	internal let generalInfo: GeneralInfo
	internal let editor: Editor
	internal let metadata: Metadata
	internal let difficulty: Difficulty
	internal let events: Events
	internal let timingPoints: TimingPoints
	internal let colours: Colours
	internal let hitObjects: HitObjects
	
	init(version: Int,
		 info: GeneralInfo,
		 editor: Editor,
		 metadata: Metadata,
		 diff: Difficulty,
		 events: Events,
		 timing: TimingPoints,
		 colours: Colours,
		 objects: HitObjects) {
		self.version = version
        self.generalInfo = info
		self.editor = editor
		self.metadata = metadata
		self.difficulty = diff
		self.events = events
		self.timingPoints = timing
		self.colours = colours
		self.hitObjects = objects
	}
	
	enum Section: String {
		case General = "General"
		case Editor = "Editor"
		case Metadata = "Metadata"
		case Difficulty = "Difficulty"
		case Events = "Events"
		case TimingPoints = "TimingPoints"
		case Colours = "Colours"
		case HitObjects = "HitObjects"
	}

}
