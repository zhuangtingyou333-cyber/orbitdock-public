import Foundation
import OrbitDockUtilities

final class BadgeTrackerTests{
    func testBadgesEstablishBaselineThenNotifyOnlyNewAttention() {
        var tracker=BadgeTracker();let path="/Applications/Fixture.app",paths:Set<String>=[path]
        XCTAssertEqual(tracker.apply([path:"4"],complete:true,activePaths:paths),[])
        XCTAssertEqual(tracker.apply([path:"5"],complete:true,activePaths:paths),[path])
        XCTAssertEqual(tracker.apply([path:"3"],complete:true,activePaths:paths),[])
        XCTAssertEqual(tracker.apply([path:"3"],complete:true,activePaths:paths),[])
        XCTAssertEqual(tracker.apply([path:""],complete:true,activePaths:paths),[])
        XCTAssertEqual(tracker.badges,[:])
        XCTAssertEqual(tracker.apply([path:"New"],complete:true,activePaths:paths),[path])
    }
    func testPartialBadgeReadNeverClearsOrRetriggersMissingApps() {
        var tracker=BadgeTracker();let a="/Applications/One.app",b="/Applications/Two.app",paths:Set<String>=[a,b]
        tracker.apply([a:"1",b:"2"],complete:true,activePaths:paths)
        XCTAssertEqual(tracker.apply([a:"1"],complete:false,activePaths:paths),[])
        XCTAssertEqual(tracker.badges[b],"2")
        XCTAssertEqual(tracker.apply([a:"1",b:"2"],complete:true,activePaths:paths),[])
        tracker.apply([:],complete:false,activePaths:paths)
        XCTAssertEqual(tracker.apply([b:"3"],complete:false,activePaths:paths),[b])
    }
    func testBadgeIdentityAndRestartBaselineAreIndependentOfDisplayName() {
        var tracker=BadgeTracker();let a="/Applications/One.app",b="/Applications/Other/One.app",paths:Set<String>=[a,b]
        tracker.apply([a:"1",b:"9"],complete:true,activePaths:paths)
        XCTAssertEqual(tracker.apply([a:"2",b:"8"],complete:true,activePaths:paths),[a])
        tracker.apply([:],complete:false,activePaths:[b]);XCTAssertEqual(tracker.badges[a],nil)
        XCTAssertEqual(tracker.apply([a:"7",b:"8"],complete:true,activePaths:paths),[])
        XCTAssertEqual(tracker.apply([a:"0"],complete:false,activePaths:paths),[])
        XCTAssertEqual(tracker.badges[a],nil);XCTAssertEqual(tracker.badges[b],"8")
    }
}
