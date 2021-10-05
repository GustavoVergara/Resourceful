extension String {
    func lowercasingFirst() -> String {
        prefix(1).lowercased() + dropFirst()
    }
}
