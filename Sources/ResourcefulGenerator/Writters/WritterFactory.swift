struct WritterFactory {
    func makeEnum(accessLevel: AccessLevel, name: String, propertyWritters: [Writter]) -> Writter {
        EnumWritter(
            accessLevel: accessLevel,
            name: name,
            propertyWritters: propertyWritters
        )
    }
    
    func makeImageEnum(accessLevel: AccessLevel, imageNames: [String]) -> Writter {
        makeEnum(
            accessLevel: accessLevel,
            name: "Images",
            propertyWritters: imageNames.map {
                makeImageResourceProperty(accessLevel: accessLevel, imageName: $0)
            }
        )
    }
    
    func makeImageResourceProperty(accessLevel: AccessLevel, imageName: String) -> Writter {
        PropertyWritter(
            accessLevel: accessLevel,
            doc: "`\(imageName)` image resource",
            name: imageName.lowercasingFirst(),
            valueWritter: ImageResourceWritter(name: imageName)
        )
    }
    
//    func makeColorEnum(accessLevel: AccessLevel, colorNames: [String]) -> Writter {
//        makeEnum(
//            accessLevel: accessLevel,
//            name: enumName,
//            propertyWritters: colorNames.map {
//                makeImageResourceProperty(accessLevel: accessLevel, imageName: $0)
//            }
//        )
//    }
}
