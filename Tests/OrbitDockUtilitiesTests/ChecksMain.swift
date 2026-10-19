import Foundation
import OrbitDockUtilities

func XCTAssertEqual<T: Equatable>(_ actual: T, _ expected: T, file: StaticString = #fileID, line: UInt = #line) {
    guard actual == expected else { fatalError("Equality check failed at \(file):\(line)") }
}
func XCTAssertLessThanOrEqual(_ actual: Double, _ expected: Double, file: StaticString = #fileID, line: UInt = #line) {
    guard actual <= expected else { fatalError("Upper-bound check failed at \(file):\(line)") }
}

@main struct UtilitiesChecks {
    static func main() {
        BadgeTrackerTests().testBadgesEstablishBaselineThenNotifyOnlyNewAttention()
        print("PASS testBadgesEstablishBaselineThenNotifyOnlyNewAttention")
        BadgeTrackerTests().testPartialBadgeReadNeverClearsOrRetriggersMissingApps()
        print("PASS testPartialBadgeReadNeverClearsOrRetriggersMissingApps")
        BadgeTrackerTests().testBadgeIdentityAndRestartBaselineAreIndependentOfDisplayName()
        print("PASS testBadgeIdentityAndRestartBaselineAreIndependentOfDisplayName")
        ClockAppearanceTests().testClockAppearancePreservesDefaultsAndBoundsTypography()
        print("PASS testClockAppearancePreservesDefaultsAndBoundsTypography")
        ClockAppearanceTests().testClockTypographyFitsAssignedCellWithoutChangingBarHeight()
        print("PASS testClockTypographyFitsAssignedCellWithoutChangingBarHeight")
        ClockDetailsTests().testClockZoneCaptionHandlesFixedOffsetsAndHiddenDefault()
        print("PASS testClockZoneCaptionHandlesFixedOffsetsAndHiddenDefault")
        ClockDetailsTests().testClockZoneCaptionFollowsSystemAndDaylightSaving()
        print("PASS testClockZoneCaptionFollowsSystemAndDaylightSaving")
        ClockDetailsTests().testClockBackgroundBoundsColorAndInsetRadius()
        print("PASS testClockBackgroundBoundsColorAndInsetRadius")
        ClockDetailsTests().testClockThreeRowsFitWithoutIncreasingDockHeight()
        print("PASS testClockThreeRowsFitWithoutIncreasingDockHeight")
        ClockZoneTests().testClockZonesFollowSystemAndPreserveNamedDaylightSaving()
        print("PASS testClockZonesFollowSystemAndPreserveNamedDaylightSaving")
        ClockZoneTests().testClockFixedOffsetsSupportHalfQuarterAndCompactForms()
        print("PASS testClockFixedOffsetsSupportHalfQuarterAndCompactForms")
        ClockZoneTests().testClockZonesRejectMalformedAndOutOfRangeOffsets()
        print("PASS testClockZonesRejectMalformedAndOutOfRangeOffsets")
        print("12 regression cases passed")
    }
}
