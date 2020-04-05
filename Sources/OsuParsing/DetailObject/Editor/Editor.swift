class Editor: DetailObject {
    
    private(set) var bookmarks:[Int] = []
    private(set) var distanceSpacing = 0.0
    private(set) var beatDivisor = 0.0
    private(set) var gridSize = 0
    private(set) var timelineZoom = 0.0
    
    static func == (lhs: Editor, rhs: Editor) -> Bool {
        return lhs.bookmarks == rhs.bookmarks &&
            lhs.distanceSpacing == rhs.distanceSpacing &&
            lhs.beatDivisor == rhs.beatDivisor &&
            lhs.gridSize == rhs.gridSize &&
            lhs.timelineZoom == rhs.timelineZoom
    }
    
    class Builder {
        private var editor = Editor()
        
        func setBookmarks(bookmarks: [Int]) -> Builder {
            editor.bookmarks = bookmarks
            return self
        }
        
        func addBookmark(bookmark: Int) -> Builder {
            editor.bookmarks.append(bookmark)
            return self
        }
        
        func setDistanceSpacing(to spacing: Double) -> Builder {
            editor.distanceSpacing = spacing
            return self
        }
        
        func setBeatDivisor(to divisor: Double) -> Builder {
            editor.beatDivisor = divisor
            return self
        }
        
        func setGridSize(to size: Int) -> Builder {
            editor.gridSize = size
            return self
        }
        
        func setTimelineZoom(to zoom: Double) -> Builder {
            editor.timelineZoom = zoom
            return self
        }
        
        func build() -> Editor {
            return editor
        }
    }
}
