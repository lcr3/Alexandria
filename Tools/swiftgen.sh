         echo execute SwiftGen
cd Tools
SDKROOT=(xcrun --sdk macosx --show-sdk-path)

swift run -c release swiftgen
