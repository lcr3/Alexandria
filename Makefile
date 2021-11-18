generate-swiftgen:
	sh Tools/swiftgen.sh

.PHONY: generate-licenses
generate-licenses:
	swift run --package-path Tools license-plist --output-path ./Settings.bundle/
