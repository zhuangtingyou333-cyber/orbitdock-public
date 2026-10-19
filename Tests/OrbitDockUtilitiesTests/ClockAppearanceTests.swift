import Foundation
import OrbitDockUtilities

final class ClockAppearanceTests{
    func testClockAppearancePreservesDefaultsAndBoundsTypography(){
        let old=ClockAppearance([:]);XCTAssertEqual(old.timeSize,13);XCTAssertEqual(old.captionSize,9);XCTAssertEqual(old.timeWeight,.medium);XCTAssertEqual(old.captionWeight,.regular);XCTAssertEqual(old.timeColor,nil);XCTAssertEqual(old.captionColor,nil)
        let malformed=ClockAppearance(["fontSize":"nan","captionFontSize":"inf","fontWeight":"new-weight","captionFontWeight":"true","textColor":"red","captionColor":"#xyzxyz"])
        XCTAssertEqual(malformed,old)
        let bounded=ClockAppearance(["fontSize":"400","captionFontSize":"2","textColor":"#aabbcc80"]);XCTAssertEqual(bounded.timeSize,40);XCTAssertEqual(bounded.captionSize,8);XCTAssertEqual(bounded.timeColor,"#AABBCC80")
    }
    func testClockTypographyFitsAssignedCellWithoutChangingBarHeight(){
        let style=ClockAppearance(["fontSize":"40","captionFontSize":"40"])
        for height in [24.0,32,48,64] {
            let scale=style.scale(height:height,caption:true),total=(style.timeSize+style.captionSize)*1.4*scale+3+8
            XCTAssertEqual(total<=height+0.001,true);XCTAssertEqual(scale>0 && scale<=1,true)
        }
        XCTAssertEqual(style.scale(height:.nan,caption:false),0.01)
    }
}
