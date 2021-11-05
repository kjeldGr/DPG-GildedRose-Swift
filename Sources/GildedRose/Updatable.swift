protocol Updatable {
    var maxQuality: Int { get }
    var qualityUpdateValue: Int { get }
    var sellInUpdateValue: Int { get }
}

extension Updatable {
    
    var maxQuality: Int {
        50
    }
    
    var sellInUpdateValue: Int {
        -1
    }
    
}
