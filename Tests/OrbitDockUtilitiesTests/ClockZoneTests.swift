import Foundation
import OrbitDockUtilities

final class ClockZoneTests{
    func testClockZonesFollowSystemAndPreserveNamedDaylightSaving(){
        XCTAssertEqual(ClockTimeZone.parse(nil),.system);XCTAssertEqual(ClockTimeZone.parse("  "),.system);XCTAssertEqual(ClockTimeZone.parse("system"),.system)
        let ny=ClockTimeZone.parse("America/New_York")!
        let winter=Date(timeIntervalSince1970:1767225600),summer=Date(timeIntervalSince1970:1782864000)
        XCTAssertEqual(ny.resolve(following:TimeZone(secondsFromGMT:0)!).secondsFromGMT(for:winter),-18000)
        XCTAssertEqual(ny.resolve(following:TimeZone(secondsFromGMT:0)!).secondsFromGMT(for:summer),-14400)
        XCTAssertEqual(ClockTimeZone.system.resolve(following:TimeZone(secondsFromGMT:20700)!).secondsFromGMT(),20700)
    }
    func testClockFixedOffsetsSupportHalfQuarterAndCompactForms(){
        for (raw,seconds) in [("UTC+05:45",20700),("GMT-0330",-12600),("+8",28800),("-04:30",-16200),("+0545",20700),("UTC+14:00",50400),("GMT-14",-50400),("Z",0),("UTC-00:00",0)]{
            let parsed=ClockTimeZone.parse(raw);XCTAssertEqual(parsed,.offset(seconds));XCTAssertEqual(ClockTimeZone.parse(parsed!.storedValue),parsed)
        }
    }
    func testClockZonesRejectMalformedAndOutOfRangeOffsets(){
        for raw in ["UTC+14:01","UTC-15:00","+05:60","+5:5","+","UTC+","UTC 08:00","+01:02:03","+０８:00","Mars/Sea","UTC+NaN",String(repeating:"x",count:129)]{XCTAssertEqual(ClockTimeZone.parse(raw),nil)}
        XCTAssertEqual(ClockTimeZone.parse("Etc/GMT+8"),.named("Etc/GMT+8"))
    }
}
