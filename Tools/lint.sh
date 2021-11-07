# Setup
echo execute SwiftLint
cd Tools
cp $SRCROOT/.swiftlint.yml ./
SDKROOT=(xcrun --sdk macosx --show-sdk-path)

swift run -c release swiftlint

# Teardown
rm .swiftlint.yml
