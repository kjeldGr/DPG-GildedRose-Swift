import XCTest

@testable import GildedRose

final class ItemTests: XCTestCase {
    
    func testItem() {
        let name = "TestItem"
        let sellIn = 0
        let quality = 5
        let item = Item(name: name, sellIn: sellIn, quality: quality)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.sellIn, sellIn)
        XCTAssertEqual(item.quality, quality)
        XCTAssertEqual(item.description, "\(name), \(sellIn), \(quality)")
        
        XCTAssertFalse((item as Any) is Updatable)
    }
    
    func testConjuredItem() {
        let name = "TestConjuredItem"
        let sellIn = 0
        let quality = 5
        let item = ConjuredItem(name: name, sellIn: sellIn, quality: quality)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.sellIn, sellIn)
        XCTAssertEqual(item.quality, quality)
        XCTAssertEqual(item.description, "\(name), \(sellIn), \(quality)")
        
        XCTAssert((item as Any) is Updatable)
        XCTAssertEqual(item.qualityUpdateValue, -2)
        
        item.sellIn = -1
        XCTAssertEqual(item.qualityUpdateValue, -4)
    }
    
    func testExpiringItem() {
        let name = "TestExpiringItem"
        let sellIn = 11
        let quality = 5
        let item = ExpiringItem(name: name, sellIn: sellIn, quality: quality)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.sellIn, sellIn)
        XCTAssertEqual(item.quality, quality)
        XCTAssertEqual(item.description, "\(name), \(sellIn), \(quality)")
        
        XCTAssert((item as Any) is Updatable)
        XCTAssertEqual(item.qualityUpdateValue, 1)
        
        item.sellIn = 9
        XCTAssertEqual(item.qualityUpdateValue, 2)
        
        item.sellIn = 4
        XCTAssertEqual(item.qualityUpdateValue, 3)
        
        item.sellIn = -1
        XCTAssertEqual(item.qualityUpdateValue, -quality)
    }
    
    func testQualityIncreasingItem() {
        let name = "TestQualityIncreasingItem"
        let sellIn = 0
        let quality = 5
        let item = QualityIncreasingItem(name: name, sellIn: sellIn, quality: quality)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.sellIn, sellIn)
        XCTAssertEqual(item.quality, quality)
        XCTAssertEqual(item.description, "\(name), \(sellIn), \(quality)")
        
        XCTAssert((item as Any) is Updatable)
        XCTAssertEqual(item.qualityUpdateValue, 1)
        
        item.sellIn = -1
        XCTAssertEqual(item.qualityUpdateValue, 2)
    }
    
    func testUpdatableItem() {
        let name = "TestUpdatableItem"
        let sellIn = 0
        let quality = 5
        let item = UpdatableItem(name: name, sellIn: sellIn, quality: quality)
        
        XCTAssertEqual(item.name, name)
        XCTAssertEqual(item.sellIn, sellIn)
        XCTAssertEqual(item.quality, quality)
        XCTAssertEqual(item.description, "\(name), \(sellIn), \(quality)")
        
        XCTAssert((item as Any) is Updatable)
        XCTAssertEqual(item.qualityUpdateValue, -1)
        
        item.sellIn = -1
        XCTAssertEqual(item.qualityUpdateValue, -2)
    }
    
    // MARK: - XCTestCase

    static var allTests = [
        ("testItem", testItem),
        ("testConjuredItem", testConjuredItem),
        ("testExpiringItem", testExpiringItem),
        ("testQualityIncreasingItem", testQualityIncreasingItem),
        ("testUpdatableItem", testUpdatableItem),
    ]
    
}
