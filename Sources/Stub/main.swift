import Shared
import AppKit

guard let app = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "sexy.kofi.multi"),
      let bundle = Bundle(url: app) else {
    Program.error(code: 1, message: "Multi.app is missing — try installing it first.")
}

guard let runtime = bundle.url(forResource: "Runtime", withExtension: nil) else {
    Program.error(code: 2, message: "Multi.app is missing essential files — try re-installing it.")
}

let process = Process()
process.arguments = [ Bundle.main.resourcePath ].compactMap { $0 }

if #available(macOS 10.13, *) {
    process.executableURL = runtime
    try process.run()
} else {
    process.launchPath = runtime.path
    process.launch()
}

process.waitUntilExit()
