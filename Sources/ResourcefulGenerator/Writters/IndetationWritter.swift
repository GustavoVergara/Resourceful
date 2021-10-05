struct IndetationWritter: Writter {
    var spacesPerTab = 4
    var writter: Writter
    
    private var tab: String { String(repeating: " ", count: spacesPerTab) }
    
    func write<S: TextOutputStream>(to output: inout S) {
        var textToBeIndented = ""
        writter.write(to: &textToBeIndented)
        let chars = textToBeIndented.flatMap { char -> [Character] in
            if char == "\n" {
                return "\n" + [Character](tab)
            } else {
                return [char]
            }
        }
        output.write(tab + String(chars))
    }
}
