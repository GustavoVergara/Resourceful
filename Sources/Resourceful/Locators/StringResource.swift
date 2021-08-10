import Foundation

public struct StringResource: Hashable {
    public var key: String
    public var tableName: String?
    public var bundle: Bundle
    
    public init(key: String, tableName: String? = nil, bundle: Bundle) {
        self.key = key
        self.tableName = tableName
        self.bundle = bundle
    }
    
    public func callAsFunction(_ args: CVarArg...) -> String {
        String(
            format: NSLocalizedString(key, tableName: tableName, bundle: bundle, comment: ""),
            arguments: args
        )
    }
}

