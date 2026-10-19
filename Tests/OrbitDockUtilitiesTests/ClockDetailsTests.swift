import Foundation
import OrbitDockUtilities

final class ClockDetailsTests{
    func testClockZoneCaptionHandlesFixedOffsetsAndHiddenDefault(){
        let date=Date(timeIntervalSince1970:1767225600)
        XCTAssertEqual(ClockZoneCaption.text([:],date:date),"")
        for (zone,text) in [("UTC","UTC"),("UTC+05:45","UTC+05:45"),("UTC-03:30","UTC-03:30"),("UTC+14:00","UTC+14:00")]{XCTAssertEqual(ClockZoneCaption.text(["showTimezone":"true","timezone":zone],date:date),text)}
    }
    func testClockZoneCaptionFollowsSystemAndDaylightSaving(){
        let winter=Date(timeIntervalSince1970:1767225600),summer=Date(timeIntervalSince1970:1782864000),utc=TimeZone(secondsFromGMT:0)!,shanghai=TimeZone(identifier:"Asia/Shanghai")!
        let options=["showTimezone":"true","timezone":"America/New_York"]
        XCTAssertEqual(ClockZoneCaption.text(options,date:winter).contains("UTC-05:00"),true);XCTAssertEqual(ClockZoneCaption.text(options,date:summer).contains("UTC-04:00"),true)
        XCTAssertEqual(ClockZoneCaption.text(["showTimezone":"true","timezone":"UTC-05:00"],date:summer),"UTC-05:00")
        XCTAssertEqual(ClockZoneCaption.text(["showTimezone":"true"],date:winter,systemZone:utc),"UTC")
        XCTAssertEqual(ClockZoneCaption.text(["showTimezone":"true","timezone":"future-zone"],date:winter,systemZone:shanghai).contains("UTC+08:00"),true)
    }
    func testClockBackgroundBoundsColorAndInsetRadius(){
        XCTAssertEqual(ClockBackground([:]).color,nil)
        XCTAssertEqual(ClockBackground(["clockBackground":"true"]).color,ClockBackground.defaultColor)
        XCTAssertEqual(ClockBackground(["clockBackground":"true","clockBackgroundColor":"#aabbcc80"]).color,"#AABBCC80")
        XCTAssertEqual(ClockBackground(["clockBackground":"true","clockBackgroundColor":"bad"]).color,nil)
        XCTAssertEqual(ClockBackground(["clockCornerRadius":"nan"]).radius,8);XCTAssertEqual(ClockBackground(["clockCornerRadius":"-4"]).radius,0)
        let style=ClockBackground(["clockCornerRadius":"80"]);XCTAssertEqual(style.radius,40);XCTAssertEqual(style.radius(width:96,height:48),22);XCTAssertEqual(style.radius(width:3,height:48),0);XCTAssertEqual(style.radius(width:.nan,height:48),0)
    }
    func testClockThreeRowsFitWithoutIncreasingDockHeight(){
        let style=ClockAppearance([:])
        for height in [24.0,32,48,96]{let scale=style.scale(height:height,caption:true,zone:true);XCTAssertLessThanOrEqual((style.timeSize+style.captionSize*2)*1.4*scale+14,height+0.001)}
        XCTAssertEqual(style.scale(height:96,caption:true,zone:true,captionLines:2,zoneLines:2),1)
    }
}
