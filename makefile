
test:
	nvim --headless -c "PlenaryBustedDirectory tests/$(DIR) {minimal_init = 'tests/init.lua'}"

testfile:
	nvim --headless -c "PlenaryBustedFile tests/$(FILE) {minimal_init = 'tests/init.lua'}"

test-set:
	nvim --headless -c "PlenaryBustedDirectory tests/set {minimal_init = 'tests/init.lua'}"

test-completions:
	nvim --headless -c "PlenaryBustedDirectory tests/completions {minimal_init = 'tests/init.lua'}"

test-config:
	nvim --headless -c "PlenaryBustedDirectory tests/config {minimal_init = 'tests/init.lua'}"

test-source:
	nvim --headless -u tests/init.lua -c "PlenaryBustedDirectory tests/source {minimal_init = 'tests/init.lua', sequential = true}"

test-kitty:
	nvim --headless -c "PlenaryBustedDirectory tests/kitty {minimal_init = 'tests/init.lua'}"

test-os-window:
	nvim --headless -c "PlenaryBustedDirectory tests/os_window {minimal_init = 'tests/init.lua'}"

test-tab:
	nvim --headless -c "PlenaryBustedDirectory tests/tab {minimal_init = 'tests/init.lua'}"

test-window:
	nvim --headless -c "PlenaryBustedDirectory tests/window {minimal_init = 'tests/init.lua'}"

test-match:
	nvim --headless -c "PlenaryBustedDirectory tests/match {minimal_init = 'tests/init.lua', sequential = true}"

test-all:
	nvim --headless -c "PlenaryBustedDirectory tests {minimal_init = 'tests/init.lua', sequential = true}"
