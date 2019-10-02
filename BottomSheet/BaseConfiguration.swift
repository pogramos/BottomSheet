protocol BaseConfiguration {
    func setup()
    func configViews()
    func configConstraints()
}

extension BaseConfiguration {
    func setup() {
        configViews()
        configConstraints()
    }
}
