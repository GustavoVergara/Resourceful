struct PropertyWritter: Writter {
    var accessLevel: AccessLevel
    var doc: String
    var name: String
    var valueWritter: Writter
    
    func write<S: TextOutputStream>(to output: inout S) {
        output.write("/// \(doc)\n")
        output.write("\(accessLevel.rawValue) static let \(name) = ")
        valueWritter.write(to: &output)
    }
}
