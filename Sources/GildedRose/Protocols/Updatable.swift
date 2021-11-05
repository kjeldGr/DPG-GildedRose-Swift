protocol Updatable {
    var qualityUpdateValue: Int { get }
}

extension Updatable {
    
    static var maxQuality: Int {
        50
    }
    
}
