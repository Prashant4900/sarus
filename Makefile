.PHONY: updateSarusCli
updateSarusCli:
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path=packages/sarus_cli

.PHONY: generateBrick
generateBrick:
	mason bundle -s path /Users/prashantnigam/Desktop/sarus/bricks/module -o packages/sarus_cli/lib/templates/ -t dart
	mason bundle -s path /Users/prashantnigam/Desktop/sarus/bricks/sarus -o packages/sarus_cli/lib/templates/ -t dart