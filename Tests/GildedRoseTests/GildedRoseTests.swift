import XCTest

@testable import GildedRose

final class GildedRoseTests: XCTestCase {
    
    // MARK: - General tests

    func testUpdateQuality() {
        let item = Item(name: "TestItem", sellIn: 1, quality: 5)
        let conjuredItem = ConjuredItem(name: "TestConjuredItem", sellIn: 1, quality: 5)
        let expiringItem = ExpiringItem(name: "TestExpiringItem", sellIn: 1, quality: 5)
        let qualityIncreasingItem = QualityIncreasingItem(name: "TestQualityIncreasingItem",
                                                          sellIn: 1, quality: 5)
        let updatableItem = UpdatableItem(name: "TestUpdatableItem", sellIn: 1, quality: 5)
        
        let items = [item, conjuredItem, expiringItem, qualityIncreasingItem, updatableItem]
        // Create a copy to compare item changes
        let itemsCopy = NSArray(array: items, copyItems: true)
            .compactMap({ $0 as? Item })
        
        let app = GildedRose(items: itemsCopy)
        app.updateQuality()
        XCTAssertEqual(app.items.count, items.count)
        
        // Make sure non-updatable items are not updated
        XCTAssertEqual(item.name, app.items[0].name)
        XCTAssertEqual(item.sellIn, app.items[0].sellIn)
        XCTAssertEqual(items[0].quality, app.items[0].quality)
        
        // Make sure updatable items are updated
        XCTAssertEqual(conjuredItem.name, app.items[1].name)
        XCTAssertNotEqual(conjuredItem.sellIn, app.items[1].sellIn)
        XCTAssertNotEqual(conjuredItem.quality, app.items[1].quality)
        
        XCTAssertEqual(expiringItem.name, app.items[2].name)
        XCTAssertNotEqual(expiringItem.sellIn, app.items[2].sellIn)
        XCTAssertNotEqual(expiringItem.quality, app.items[2].quality)
        
        XCTAssertEqual(qualityIncreasingItem.name, app.items[3].name)
        XCTAssertNotEqual(qualityIncreasingItem.sellIn, app.items[3].sellIn)
        XCTAssertNotEqual(qualityIncreasingItem.quality, app.items[3].quality)
        
        XCTAssertEqual(updatableItem.name, app.items[4].name)
        XCTAssertNotEqual(updatableItem.sellIn, app.items[4].sellIn)
        XCTAssertNotEqual(updatableItem.quality, app.items[4].quality)
    }
    
    // MARK: - Item
    
    func testItemQualityAndSellInDoesNotChange() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 80)
    }
    
    // MARK: - UpdatableItem
    
    func testUpdatableItemQualityDecreases() {
        let item = UpdatableItem(name: "TestUpdatableItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
    }
    
    func testUpdatableItemQualityDecreasesTwiceAsFastAfterSellInDate() {
        let item = UpdatableItem(name: "TestUpdatableItem", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 2)
    }
    
    // MARK: - QualityIncreasingItem
    
    func testQualityIncreasingItemQualityIncreases() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testQualityIncreasingItemQualityIncreasesTwiceAsFastAfterSellInDate() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 1, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 1)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testQualityIncreasingItemQualityDoesNotIncreaseAboveMaxValue() {
        let item = QualityIncreasingItem(name: "Aged Brie", sellIn: 0, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -2)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - ExpiringItem
    
    func testExpiringItemQualityIncreases() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 10)
        XCTAssertEqual(item.quality, 1)
    }
    
    func testExpiringItemQualityIncreasesTwiceAsFastWithTenDaysLeft() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 9)
        XCTAssertEqual(item.quality, 2)
    }
    
    func testExpiringItemQualityIncreasesThreeTimesAsFastWithFiveDaysLeft() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 5)
        XCTAssertEqual(item.quality, 2)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 5)
    }
    
    func testExpiringItemQualityDropsToZeroAfterSellIn() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 2, quality: 0)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 1)
        XCTAssertEqual(item.quality, 3)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 6)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 0)
    }
    
    func testExpiringItemQualityDoesNotIncreaseAboveMaxValue() {
        let item = ExpiringItem(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 49)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 5)
        XCTAssertEqual(item.quality, 50)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 4)
        XCTAssertEqual(item.quality, 50)
    }
    
    // MARK: - ConjuredItem
    
    func testConjuredItemQualityDecreases() {
        let item = ConjuredItem(name: "Conjured Mana Cake", sellIn: 1, quality: 5)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 3)
    }
    
    func testConjuredItemQualityDecreasesTwiceAsFastAfterSellInDate() {
        let item = ConjuredItem(name: "Conjured Mana Cake", sellIn: 1, quality: 6)
        let app = GildedRose(items: [item])
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, 0)
        XCTAssertEqual(item.quality, 4)
        
        app.updateQuality()
        XCTAssertEqual(item.sellIn, -1)
        XCTAssertEqual(item.quality, 0)
    }
    
    // MARK: - XCTestCase

    static var allTests = [
        ("testUpdateQuality", testUpdateQuality),
        ("testItemQualityAndSellInDoesNotChange", testItemQualityAndSellInDoesNotChange),
        ("testUpdatableItemQualityDecreases", testUpdatableItemQualityDecreases),
        ("testUpdatableItemQualityDecreasesTwiceAsFastAfterSellInDate", testUpdatableItemQualityDecreasesTwiceAsFastAfterSellInDate),
        ("testQualityIncreasingItemQualityIncreases", testQualityIncreasingItemQualityIncreases),
        ("testQualityIncreasingItemQualityIncreasesTwiceAsFastAfterSellInDate", testQualityIncreasingItemQualityIncreasesTwiceAsFastAfterSellInDate),
        ("testQualityIncreasingItemQualityDoesNotIncreaseAboveMaxValue", testQualityIncreasingItemQualityDoesNotIncreaseAboveMaxValue),
        ("testExpiringItemQualityIncreases", testExpiringItemQualityIncreases),
        ("testExpiringItemQualityIncreasesTwiceAsFastWithTenDaysLeft", testExpiringItemQualityIncreasesTwiceAsFastWithTenDaysLeft),
        ("testExpiringItemQualityIncreasesThreeTimesAsFastWithFiveDaysLeft", testExpiringItemQualityIncreasesThreeTimesAsFastWithFiveDaysLeft),
        ("testExpiringItemQualityDropsToZeroAfterSellIn", testExpiringItemQualityDropsToZeroAfterSellIn),
        ("testExpiringItemQualityDoesNotIncreaseAboveMaxValue", testExpiringItemQualityDoesNotIncreaseAboveMaxValue),
        ("testConjuredItemQualityDecreases", testConjuredItemQualityDecreases),
        ("testConjuredItemQualityDecreasesTwiceAsFastAfterSellInDate", testConjuredItemQualityDecreasesTwiceAsFastAfterSellInDate),
    ]
}
