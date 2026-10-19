import Foundation

/// Named zones retain daylight saving rules. Fixed offsets never adopt DST.
public enum ClockTimeZone:Equatable,Sendable {
    case system,named(String),offset(Int)
    public static func parse(_ value:String?)->Self? {
        let text=(value ?? "").trimmingCharacters(in:.whitespacesAndNewlines)
        guard text.count<=128 else{return nil}
        if text.isEmpty || ["system","local","auto"].contains(text.lowercased()){return .system}
        let upper=text.uppercased()
        if ["UTC","GMT","Z"].contains(upper){return .offset(0)}
        var suffix=upper
        let prefixed=upper.hasPrefix("UTC") || upper.hasPrefix("GMT")
        if prefixed{suffix=String(upper.dropFirst(3))}
        if prefixed || suffix.first=="+" || suffix.first=="-" {
            guard let sign=suffix.first,sign=="+" || sign=="-" else{return nil}
            let digits=String(suffix.dropFirst()),parts=digits.split(separator:":",omittingEmptySubsequences:false)
            let hours:String,minutes:String
            if parts.count==2{hours=String(parts[0]);minutes=String(parts[1]);guard minutes.count==2 else{return nil}}
            else if parts.count==1, digits.count<=4{
                if digits.count>2{hours=String(digits.dropLast(2));minutes=String(digits.suffix(2))}else{hours=digits;minutes="00"}
            }else{return nil}
            guard (1...2).contains(hours.count),(hours+minutes).utf8.allSatisfy({(48...57).contains($0)}),let hour=Int(hours),let minute=Int(minutes),hour<=14,minute<60,hour<14 || minute==0 else{return nil}
            return .offset((sign=="-" ? -1:1)*(hour*3600+minute*60))
        }
        guard TimeZone(identifier:text) != nil else{return nil}
        return .named(text)
    }
    public func resolve(following zone:TimeZone)->TimeZone {
        switch self{case .system:return zone;case .named(let identifier):return TimeZone(identifier:identifier) ?? zone;case .offset(let seconds):return TimeZone(secondsFromGMT:seconds) ?? zone}
    }
    public var storedValue:String {
        switch self{
        case .system:return ""
        case .named(let identifier):return identifier
        case .offset(let seconds):return String(format:"UTC%@%02d:%02d",seconds<0 ? "-":"+",abs(seconds)/3600,abs(seconds)%3600/60)
        }
    }
}
