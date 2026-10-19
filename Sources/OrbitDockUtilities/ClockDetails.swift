import Foundation

public enum ClockZoneCaption {
    public static func text(_ options:[String:String],date:Date,systemZone:TimeZone = .current)->String {
        guard options["showTimezone"]=="true" else{return ""}
        let selection=ClockTimeZone.parse(options["timezone"]) ?? .system,zone=selection.resolve(following:systemZone)
        let seconds=zone.secondsFromGMT(for:date),amount=abs(seconds)
        let offset=seconds==0 ? "UTC":String(format:"UTC%@%02d:%02d",seconds<0 ? "-":"+",amount/3600,amount%3600/60)+(amount%60==0 ? "":String(format:":%02d",amount%60))
        if case .offset=selection{return offset}
        guard let abbreviation=zone.abbreviation(for:date),!abbreviation.isEmpty,abbreviation.count<=32,!abbreviation.hasPrefix("GMT"),!abbreviation.hasPrefix("UTC") else{return offset}
        return abbreviation+" · "+offset
    }
}

public struct ClockBackground:Equatable,Sendable {
    public static let defaultColor="#0A84FF33"
    public let color:String?
    public let radius:Double
    public init(_ options:[String:String]) {
        color=options["clockBackground"]=="true" ? ClockAppearance.color(options["clockBackgroundColor"] ?? Self.defaultColor):nil
        let value=Double(options["clockCornerRadius"] ?? "8") ?? 8
        radius=value.isFinite ? min(40,max(0,value)):8
    }
    public func radius(width:Double,height:Double)->Double {
        guard width.isFinite,height.isFinite else{return 0}
        return min(radius,max(0,min(width,height)-4)/2)
    }
}
