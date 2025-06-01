.PHONY: sarus
sarus:
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path=packages/sarus_cli

.PHONY: bricks
bricks:
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/project -o packages/sarus_cli/lib/templates/ -t dart
	mason bundle -s path /Volumes/Personal/projects/sarus/bricks/module -o packages/sarus_cli/lib/templates/ -t dart

.PHONY: sarus-cli
sarus-cli:
	dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path packages/sarus_cli

.PHONY: bricks-git
bricks-git:
	find packages/sarus_cli/lib/templates/ -name '*_bundle.dart' -delete
	mason bundle --source git https://github.com/Prashant4900/sarus.git --git-ref main --git-path bricks/project --output-dir packages/sarus_cli/lib/templates --type dart
	mason bundle --source git https://github.com/Prashant4900/sarus.git --git-ref main --git-path bricks/module --output-dir packages/sarus_cli/lib/templates --type dart
