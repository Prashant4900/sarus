.PHONY: sarus
sarus:
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path=packages/sarus_cli

.PHONY: bricks
bricks:
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/project -o packages/sarus_cli/lib/templates/ -t dart
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/module -o packages/sarus_cli/lib/templates/ -t dart