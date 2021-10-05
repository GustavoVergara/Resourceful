struct EnumWritter: Writter {
    var accessLevel: AccessLevel
    var name: String
    var propertyWritters: [Writter]
    
    func write<S: TextOutputStream>(to output: inout S) {
        output.write(
            """
            /// Generated `\(name)` enum
            \(accessLevel) enum \(name) {
            
            
            """
        )
        propertyWritters.forEach {
            let indentedWritter = IndetationWritter(spacesPerTab: 4, writter: $0)
            indentedWritter.write(to: &output)
            output.write("\n\n")
        }
        output.write("}\n")
    }
}
