protocol Writter {
    func write<S: TextOutputStream>(to output: inout S)
}
