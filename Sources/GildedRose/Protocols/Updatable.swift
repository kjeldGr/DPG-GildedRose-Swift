protocol Updatable {
    var qualityUpdateValue: Int { get }
    var sellInUpdateValue: Int { get }
    
    static var maxQuality: Int { get }
}

extension Updatable {
    
    var sellInUpdateValue: Int {
        -1
    }
    
    static var maxQuality: Int {
        50
    }
    
}
