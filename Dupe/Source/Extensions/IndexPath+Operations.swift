import Foundation

extension IndexPath {
    
    /*
        0,0    0,1    0,2    0,3
        1,0    1,1    1,2    1,3
        2,0    2,1    2,2    2,3
        3,0    3,1    3,2    3,3
     */
    func getSmoothPathsForSize16Grid() -> [IndexPath] {
        switch self {
        case IndexPath(row: 0, section: 0):
            return [IndexPath(row: 1, section: 0),
                    IndexPath(row: 0, section: 1)]
        case IndexPath(row: 0, section: 1):
            return [IndexPath(row: 1, section: 0),
                    IndexPath(row: 1, section: 1),
                    IndexPath(row: 0, section: 2)]
        case IndexPath(row: 0, section: 2):
            return [IndexPath(row: 0, section: 1),
                    IndexPath(row: 1, section: 2),
                    IndexPath(row: 0, section: 3)]
        case IndexPath(row: 0, section: 3):
            return [IndexPath(row: 0, section: 2),
                    IndexPath(row: 1, section: 3)]
        case IndexPath(row: 1, section: 0):
            return [IndexPath(row: 1, section: 0),
                    IndexPath(row: 1, section: 1),
                    IndexPath(row: 2, section: 0)]
        case IndexPath(row: 1, section: 1):
            return [IndexPath(row: 0, section: 1),
                    IndexPath(row: 1, section: 2),
                    IndexPath(row: 2, section: 1),
                    IndexPath(row: 1, section: 0)]
        case IndexPath(row: 1, section: 2):
            return [IndexPath(row: 0, section: 2),
                    IndexPath(row: 2, section: 2),
                    IndexPath(row: 1, section: 1),
                    IndexPath(row: 1, section: 3)]
        case IndexPath(row: 1, section: 3):
            return [IndexPath(row: 0, section: 3),
                    IndexPath(row: 1, section: 2),
                    IndexPath(row: 2, section: 3)]
        case IndexPath(row: 2, section: 0):
            return [IndexPath(row: 1, section: 0),
                    IndexPath(row: 2, section: 1),
                    IndexPath(row: 3, section: 0)]
        case IndexPath(row: 2, section: 1):
            return [IndexPath(row: 1, section: 1),
                    IndexPath(row: 2, section: 0),
                    IndexPath(row: 3, section: 1),
                    IndexPath(row: 2, section: 2)]
        case IndexPath(row: 2, section: 2):
            return [IndexPath(row: 1, section: 2),
                    IndexPath(row: 2, section: 1),
                    IndexPath(row: 3, section: 2),
                    IndexPath(row: 2, section: 3)]
        case IndexPath(row: 2, section: 3):
            return [IndexPath(row: 1, section: 3),
                    IndexPath(row: 2, section: 2),
                    IndexPath(row: 3, section: 3)]
        case IndexPath(row: 3, section: 0):
            return [IndexPath(row: 2, section: 0),
                    IndexPath(row: 3, section: 1)]
        case IndexPath(row: 3, section: 1):
            return [IndexPath(row: 3, section: 0),
                    IndexPath(row: 2, section: 1),
                    IndexPath(row: 3, section: 2)]
        case IndexPath(row: 3, section: 2):
            return [IndexPath(row: 3, section: 1),
                    IndexPath(row: 2, section: 2),
                    IndexPath(row: 3, section: 3)]
        case IndexPath(row: 3, section: 3):
            return [IndexPath(row: 3, section: 2),
                    IndexPath(row: 2, section: 3)]
        default:
            return []
        }
    }
    
}
