import Foundation

public enum ClockFontWeight:String,CaseIterable,Sendable {
    case ultraLight,thin,light,regular,medium,semibold,bold,heavy,black
    public var title:String{switch self{case .ultraLight:return "极细";case .thin:return "纤细";case .light:return "细体";case .regular:return "常规";case .medium:return "中等";case .semibold:return "半粗";case .bold:return "粗体";case .heavy:return "特粗";case .black:return "最粗"}}
    public static func parse(_ raw:String?)->Self? {
        guard let raw else{return nil};if let value=Self(rawValue:raw){return value}
        guard let numeric=Double(raw),numeric.isFinite,numeric.rounded()==numeric,numeric>=100,numeric<=900,Int(numeric)%100==0 else{return nil}
        return allCases[Int(numeric)/100-1]
    }
}

public struct ClockAppearance:Equatable,Sendable {
    public let timeSize:Double,captionSize:Double
    public let timeWeight:ClockFontWeight,captionWeight:ClockFontWeight
    public let timeColor:String?,captionColor:String?
    public init(_ options:[String:String]) {
        timeSize=Self.size(options["fontSize"],fallback:13);captionSize=Self.size(options["captionFontSize"],fallback:9)
        timeWeight=ClockFontWeight.parse(options["fontWeight"]) ?? .medium;captionWeight=ClockFontWeight.parse(options["captionFontWeight"]) ?? .regular
        timeColor=Self.color(options["textColor"]);captionColor=Self.color(options["captionColor"])
    }
    private static func size(_ raw:String?,fallback:Double)->Double{guard let value=Double(raw ?? ""),value.isFinite else{return fallback};return min(40,max(8,value))}
    public static func color(_ raw:String?)->String? {
        guard let raw,raw.first=="#",[7,9].contains(raw.utf8.count),raw.dropFirst().utf8.allSatisfy({(48...57).contains($0) || (65...70).contains($0) || (97...102).contains($0)}) else{return nil}
        return raw.uppercased()
    }
    /// Keep both text lines inside the assigned cell without changing Dock height.
    public func scale(height:Double,caption:Bool,zone:Bool=false,captionLines:Int=1,zoneLines:Int=1)->Double {
        guard height.isFinite,height>0 else{return 0.01}
        let lines=(caption ? 1.0:0)+(zone ? 1.0:0)
        let textLines=(caption ? Double(min(2,max(1,captionLines))):0)+(zone ? Double(min(2,max(1,zoneLines))):0)
        let natural=(timeSize+captionSize*textLines)*1.4,space=height-8-3*lines
        return min(1,max(0.01,space/max(1,natural)))
    }
}
