
test:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/$(DIR) {minimal_init = 'tests/minimal-init.vim'}"

testfile:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedFile tests/$(FILE)"

test-set:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/set"

test-completions:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/completions"

test-config:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/config"

test-source:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/source"

test-kitty:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/kitty"

test-os-window:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/os_window"

test-tab:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/tab"

test-window:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/window"

test-match:
	nvim --headless --noplugin -u tests/minimal-init.vim -c "PlenaryBustedDirectory tests/match"
