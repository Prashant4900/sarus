.PHONY: sarus
sarus:
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path=packages/sarus_cli

.PHONY: bricks
bricks:
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/project -o packages/sarus_cli/lib/templates/ -t dart
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/module -o packages/sarus_cli/lib/templates/ -t dart
	cd packages/sarus_cli && dart format .

.PHONY: sarus-cli
sarus-cli:
	dart pub global deactivate sarus_cli
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path packages/sarus_cli --git-ref main

.PHONY: publish-sarus-cli
test:
	make sarus-cli
	dart pub publish

.PHONY: publish-sarus-cli-dry-run
publish-sarus-cli-dry-run:
	make sarus-cli
	dart pub publish --dry-run