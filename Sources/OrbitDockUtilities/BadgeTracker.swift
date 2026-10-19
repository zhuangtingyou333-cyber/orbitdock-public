import Foundation

/// Badge reads can be truncated by an unresponsive Dock. Missing entries in a
/// partial read are unknown, never a synthetic clear followed by a new badge.
public struct BadgeTracker:Sendable {
    public private(set) var badges:[String:String]=[:]
    private var observed=Set<String>()
    public init(){}
    @discardableResult public mutating func apply(_ sample:[String:String],complete:Bool,activePaths:Set<String>)->Set<String> {
        badges=badges.filter{activePaths.contains($0.key)};observed.formIntersection(activePaths)
        var attention=Set<String>()
        for path in activePaths {
            guard complete || sample[path] != nil else{continue}
            let value=String((sample[path] ?? "").trimmingCharacters(in:.whitespacesAndNewlines).prefix(64))
            let previous=badges[path] ?? ""
            if observed.contains(path),value != previous,!value.isEmpty,value != "0" {
                if let new=Int(value),let old=Int(previous){if new>old{attention.insert(path)}}
                else{attention.insert(path)}
            }
            observed.insert(path)
            badges[path]=value.isEmpty || value=="0" ? nil:value
        }
        return attention
    }
}
