import Foundation

extension Int {
    
    func getSmoothPathsForSize16Grid() -> [Int] {
        switch self {
        case 0:
            return [4, 1]
        case 1:
            return [0, 5, 2]
        case 2:
            return [1, 6, 3]
        case 3:
            return [2, 7]
        case 4:
            return [0, 5, 8]
        case 5:
            return [1, 6, 9, 4]
        case 6:
            return [2, 10, 5, 7]
        case 7:
            return [3, 6, 11]
        case 8:
            return [4, 9, 12]
        case 9:
            return [5, 8, 13, 10]
        case 10:
            return [6, 9, 14, 11]
        case 11:
            return [7, 10, 15]
        case 12:
            return [8, 13]
        case 13:
            return [12, 9, 14]
        case 14:
            return [13, 10, 15]
        case 15:
            return [14, 11]
        default:
            return []
        }
    }
    
}
