import Foundation

extension Array where Element == Int {

    mutating func toggle(element: Int) {
        if contains(element) {
            removeAll { (containingElement) -> Bool in
                return containingElement == element
            }
        } else {
            append(element)
        }
    }
    
    mutating func addIfNotAlreadyThere(element: Int) {
        if !contains(element) {
            append(element)
        }
    }
}

