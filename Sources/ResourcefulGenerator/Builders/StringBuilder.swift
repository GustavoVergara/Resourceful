@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: CustomStringConvertible...) -> String {
        components.map { $0.description }.joined()
    }
    
    static func buildArray(_ components: [CustomStringConvertible]) -> String {
        components.map { $0.description }.joined()
    }
}

struct NewLine: CustomStringConvertible {
    var count: Int = 1
    
    var description: String { String(repeating: "\n", count: count) }
}

struct DocumentationComment: CustomStringConvertible {
    var text: String
    
    var description: String {
        "/// \(text)"
    }
}

struct ImagesFile: CustomStringConvertible {
    var accessLevel: AccessLevel
    var imageNames: [String]
    
    @StringBuilder
    var description: String {
        Import(module: "Resourceful")
        NewLine(count: 2)
        Enum(accessLevel: accessLevel,
             name: "Images",
             properties: imageNames.map {
                Property(accessLevel: accessLevel,
                         doc: "`\($0)` image resource",
                         name: $0.lowercasingFirst(),
                         value: ImageResource(name: $0))
             })
    }
}

struct ColorsFile: CustomStringConvertible {
    var accessLevel: AccessLevel
    var colorNames: [String]
    
    @StringBuilder
    var description: String {
        Import(module: "Resourceful")
        NewLine(count: 2)
        Enum(accessLevel: accessLevel,
             name: "Colors",
             properties: colorNames.map {
                Property(accessLevel: accessLevel,
                         doc: "`\($0)` color resource",
                         name: $0.lowercasingFirst(),
                         value: ColorResource(name: $0))
             })
    }
}

struct Import: CustomStringConvertible {
    var module: String
    
    var description: String {
        "import \(module)"
    }
}

struct File: CustomStringConvertible {
    var imports: [CustomStringConvertible]
    var body: CustomStringConvertible
    
    @StringBuilder
    var description: String {
        for `import` in imports {
            `import`
            NewLine()
        }
        body
    }
}

struct Enum: CustomStringConvertible {
    var accessLevel: AccessLevel
    var name: String
    var properties: [CustomStringConvertible]

    @StringBuilder
    var description: String {
        DocumentationComment(text: "Generated `\(name)` enum")
        NewLine()
        "\(accessLevel) enum \(name) {"
        NewLine(count: 2)
        for property in properties {
            Indented(string: property)
            NewLine(count: 2)
        }
        "}"
    }
}

struct Property: CustomStringConvertible {
    var accessLevel: AccessLevel
    var doc: String
    var name: String
    var value: CustomStringConvertible

    @StringBuilder
    var description: String {
        DocumentationComment(text: doc)
        NewLine()
        "\(accessLevel) static let \(name) = \(value)"
    }
}

struct ImageResource: CustomStringConvertible {
    var name: String
    
    var description: String {
        #"Resourceful.ImageResource(name: "\#(name)", bundle: .main)"#
    }
}

struct ColorResource: CustomStringConvertible {
    var name: String
    
    var description: String {
        #"Resourceful.ColorResource(name: "\#(name)", bundle: .main)"#
    }
}

struct Indented: CustomStringConvertible {
    var string: CustomStringConvertible
    var spacesPerTab = 4
    
    private var tab: String { String(repeating: " ", count: spacesPerTab) }

    var description: String {
        tab + string.description.flatMap { char -> [Character] in
            if char == "\n" {
                return "\n" + [Character](tab)
            } else {
                return [char]
            }
        }
    }
}
