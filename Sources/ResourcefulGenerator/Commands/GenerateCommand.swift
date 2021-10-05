import ArgumentParser

public struct GenerateCommand: ParsableCommand {
    public static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: nil,
            abstract: "",
            discussion: "",
            version: ""
        )
    }
    
//    @Option
//    var
    
    public init() {
        
    }

    public func run() throws {
//        let imagesEnum = SyntaxFactory.makeImagesEnumDecl()
//        var output = ""
//        imagesEnum.write(to: &output)
        
//        var output = ""
//        let writterFactory = WritterFactory()
//        let enumWritter = writterFactory.makeImageEnum(accessLevel: .internal, imageNames: ["ImageA"])
//        enumWritter.write(to: &output)
        let file = ImagesFile(accessLevel: .internal, imageNames: ["ImageA"])
        
        print(file)
    }
}

public enum GenerateCommandError: Error {
//    case fileNotFound
}
