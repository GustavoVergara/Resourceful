struct ImageResourceWritter: Writter {
    var name: String
    
    func write<S: TextOutputStream>(to output: inout S) {
        output.write(#"Resourceful.ImageResource(name: "\#(name)", bundle: .main)"#)
    }
}
