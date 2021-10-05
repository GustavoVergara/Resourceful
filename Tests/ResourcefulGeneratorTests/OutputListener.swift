import Foundation

class OutputListener {
    /// consumes the messages on STDOUT
    let inputPipe = Pipe()

    /// outputs messages back to STDOUT
    let outputPipe = Pipe()

    /// Buffers strings written to stdout
    private(set) var contents = ""
    
    var onContentsChange: ((String) -> Void)?
    
    init() {
        // Set up a read handler which fires when data is written to our inputPipe
        inputPipe.fileHandleForReading.readabilityHandler = { [weak self] fileHandle in
            guard let self = self else { return }

            let data = fileHandle.availableData
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                self.contents += string
                self.onContentsChange?(self.contents)
            }

            // Write input back to stdout
            self.outputPipe.fileHandleForWriting.write(data)
        }
    }

    /// Sets up the "tee" of piped output, intercepting stdout then passing it through.
    func openConsolePipe() {
        // Copy STDOUT file descriptor to outputPipe for writing strings back to STDOUT
        dup2(FileHandle.standardOutput.fileDescriptor, outputPipe.fileHandleForWriting.fileDescriptor)

        // Intercept STDOUT with inputPipe
        dup2(inputPipe.fileHandleForWriting.fileDescriptor, FileHandle.standardOutput.fileDescriptor)
    }
    
    /// Tears down the "tee" of piped output.
    func closeConsolePipe() {
        // Restore stdout
        freopen("/dev/stdout", "a", stdout)

        [inputPipe.fileHandleForReading, outputPipe.fileHandleForWriting].forEach { file in
            file.closeFile()
        }
    }
}
