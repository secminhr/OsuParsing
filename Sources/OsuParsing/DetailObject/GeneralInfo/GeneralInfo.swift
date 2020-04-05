class GeneralInfo: DetailObject, Equatable {
    
	let audioFileName: String
	private(set) var audioLeadIn = 0
	private(set) var previewTime = -1
	private(set) var countdown = Countdown.Normal
    private(set) var sampleSet = SampleSet.Normal
	private(set) var stackLeniecy = 0.7
    private(set) var mode = GameMode.Osu
	private(set) var letterBoxInBreaks = false
    private(set) var useSkinSprite = false
    private(set) var overlayPosition = OverlayPosition.NoChange
	private(set) var skinPreference: String = ""
	private(set) var epilepsyWarning = false
	private(set) var countdownOffset = 0
    private(set) var specialStyle = false
	private(set) var widescreenStoryboard = false
    private(set) var samplesMatchPlaybackRate = false
	
	internal var isEmpty: Bool {
		get {
			return audioFileName.isEmpty
		}
	}
	internal var isNotEmpty: Bool {
		get {
			return !isEmpty
		}
	}
	
	private init(audioFileName: String) {
		self.audioFileName = audioFileName
	}
    
    static func == (lhs: GeneralInfo, rhs: GeneralInfo) -> Bool {
        return lhs.audioFileName == rhs.audioFileName &&
            lhs.audioLeadIn == rhs.audioLeadIn &&
            lhs.previewTime == rhs.previewTime &&
            lhs.countdown == rhs.countdown &&
            lhs.sampleSet == rhs.sampleSet &&
            lhs.stackLeniecy == rhs.stackLeniecy &&
            lhs.mode == rhs.mode &&
            lhs.letterBoxInBreaks == rhs.letterBoxInBreaks &&
            lhs.useSkinSprite == rhs.useSkinSprite &&
            lhs.overlayPosition == rhs.overlayPosition &&
            lhs.skinPreference == rhs.skinPreference &&
            lhs.epilepsyWarning == rhs.epilepsyWarning &&
            lhs.countdownOffset == rhs.countdownOffset &&
            lhs.specialStyle == rhs.specialStyle &&
            lhs.widescreenStoryboard == rhs.widescreenStoryboard &&
            lhs.samplesMatchPlaybackRate == rhs.samplesMatchPlaybackRate
    }
    
    enum Attributes: String {
        case audioLeadIn = "AudioLeadIn"
    }
    
	
	class Builder {
		private let info: GeneralInfo
        
		init(audioFileName: String) {
			info = GeneralInfo(audioFileName: audioFileName)
		}
        
		func setAudioLeadIn(to leadIn: Int) -> Builder {
			info.audioLeadIn = leadIn
			return self
		}
        
		func setPreviewTime(to time: Int) -> Builder {
			info.previewTime = time
			return self
		}
        
		func setCountdown(to countdown: Countdown) -> Builder {
			info.countdown = countdown
			return self
		}
        
		func setCountdown(to countdown: Int) -> Builder {
			guard let count = Countdown.init(rawValue: countdown) else {
				return self
			}
			info.countdown = count
			return self
		}
        
        func setSampleSet(to sampleSet: SampleSet) -> Builder {
            info.sampleSet = sampleSet
            return self
        }
        
		func setStackLeniecy(to leniecy: Double) -> Builder {
			info.stackLeniecy = leniecy
			return self
		}
        
        func setMode(to mode: GameMode) -> Builder {
            info.mode = mode
            return self
        }
        
		func setLetterBoxInBreaks(_ letterBox: Bool) -> Builder {
			info.letterBoxInBreaks = letterBox
			return self
		}
        
        func setUseSkinSprite(_ use: Bool) -> Builder {
            info.useSkinSprite = use
            return self
        }
        
        func setOverlayPosition(to position: OverlayPosition) -> Builder {
            info.overlayPosition = position
            return self
        }
        
		func setSkinPreference(to preference: String) -> Builder {
			info.skinPreference = preference
			return self
		}
        
		func setEpilepsyWarning(_ warning: Bool) -> Builder {
			info.epilepsyWarning = warning
			return self
		}
        
		func setCountdownOffset(to offset: Int) -> Builder {
			info.countdownOffset = offset
			return self
		}
        
        func setUseSpecialStyle(_ use: Bool) -> Builder {
            info.specialStyle = use
            return self
        }
        
		func setUseWidescreenStoryBoard(_ use: Bool) -> Builder {
			info.widescreenStoryboard = use
			return self
		}
        
        func setUseSamplesMatchPlaybackRate(_ use: Bool) -> Builder {
            info.samplesMatchPlaybackRate = use
            return self
        }
        
		func build() -> GeneralInfo {
			return info
		}
	}
}

enum Countdown: Int {
	case None = 0
	case Normal = 1
	case Half = 2
	case Double = 3
}

enum SampleSet: String {
    case Normal = "Normal"
    case Soft = "Soft"
    case Drum = "Drum"
}

enum GameMode: Int {
	case Osu = 0
	case Taiko = 1
	case CatchTheBeat = 2
	case OsuMania = 3
}

enum OverlayPosition: String {
    case NoChange = "NoChange"
    case Below = "Below"
    case Above = "Above"
}
