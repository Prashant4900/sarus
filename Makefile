.PHONY: updateSarusCli
updateSarusCli:
	dart pub global deactivate sarus_cli
	dart pub global activate --source path packages/sarus_cli