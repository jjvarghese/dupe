import Foundation

extension IndexPath {
    
    func getSmoothPathsFor16Grid() -> [IndexPath] {
        var validItems: [Int] = []
        
        switch item {
        case 0:
            validItems = [4, 1]
        case 1:
            validItems = [0, 5, 2]
        case 2:
            validItems = [1, 6, 3]
        case 3:
            validItems = [2, 7]
        case 4:
            validItems = [0, 5, 8]
        case 5:
            validItems = [1, 6, 9, 4]
        case 6:
            validItems = [2, 10, 5, 7]
        case 7:
            validItems = [3, 6, 11]
        case 8:
            validItems = [4, 9, 12]
        case 9:
            validItems = [5, 8, 13, 10]
        case 10:
            validItems = [6, 9, 14, 11]
        case 11:
            validItems = [7, 10, 15]
        case 12:
            validItems = [8, 13]
        case 13:
            validItems = [12, 9, 14]
        case 14:
            validItems = [13, 10, 15]
        case 15:
            validItems = [14, 11]
        default:
            validItems = []
        }
        
        var validIndexPaths: [IndexPath] = []
        
        for validItem in validItems {
            validIndexPaths.append(IndexPath(item: validItem, section: 0))
        }
        
        return validIndexPaths
    }
    
}
