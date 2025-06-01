# 🎨 Common ANSI Colors:
# \033[0m – Reset
# \033[1;31m – Bright Red
# \033[1;32m – Bright Green
# \033[1;33m – Bright Yellow
# \033[1;34m – Bright Blue
# \033[1;35m – Bright Magenta
# \033[1;36m – Bright Cyan

.PHONY: migrate
migrate:
	@echo "\033[1;34mRunning migrations...\033[0m"
	dart run stormberry migrate --db postgres --host localhost --port 5432 --username postgres --password admin --apply-changes --no-ssl
	@echo "\033[1;32m✅ Done.\033[0m"

.PHONY: dry-run
dry-run:
	@echo "\033[1;33mRunning migrations in dry run mode...\033[0m"
	dart run stormberry migrate --db postgres --host localhost --port 5432 --username postgres --password admin --dry-run --no-ssl
	@echo "\033[1;32m✅ Done.\033[0m"

.PHONY: dev
dev:
	@echo "\033[1;34mRunning the development server...\033[0m"
	dart run --enable-vm-service lib/main.dart
	@echo "\033[1;32m✅ Done.\033[0m"

.PHONY: run
run:
	@echo "\033[1;34mRunning the server...\033[0m"
	dart run bin/server.dart
	@echo "\033[1;32m✅ Done.\033[0m"

.PHONY: gen
gen:
	@echo "\033[1;34mGenerating code...\033[0m"
	dart run build_runner build --delete-conflicting-outputs
	@echo "\033[1;32m✅ Done.\033[0m"
	