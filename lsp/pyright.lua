return {
    cmd = {"pyright-langserver", "--stdio"},
    filetypes = {"python"},
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
                diagnosticMode = "openFilesOnly",
                reportMissingTypeStubs = false,
                reportUnannotatedClassAttribute = false,
            }
        }
    }
}
