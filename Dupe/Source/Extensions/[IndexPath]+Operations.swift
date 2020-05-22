import Foundation

extension Array where Element == IndexPath {
    
    mutating func toggle(element: IndexPath) {
        if contains(element) {
            removeAll { (containingElement) -> Bool in
                return containingElement == element
            }
        } else {
            append(element)
        }
    }
    
    mutating func addIfNotAlreadyThere(element: IndexPath) {
        if !contains(element) {
            append(element)
        }
    }
}

