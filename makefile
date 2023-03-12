
test:
	nvim --headless -c "PlenaryBustedDirectory tests/$(DIR)"

testfile:
	nvim --headless -c "PlenaryBustedFile tests/$(FILE)"

test-set:
	nvim --headless -c "PlenaryBustedDirectory tests/set"

test-completions:
	nvim --headless -c "PlenaryBustedDirectory tests/completions"

test-config:
	nvim --headless -c "PlenaryBustedDirectory tests/config"

test-source:
	nvim --headless -c "PlenaryBustedDirectory tests/source"

test-kitty:
	nvim --headless -c "PlenaryBustedDirectory tests/kitty"

test-os-window:
	nvim --headless -c "PlenaryBustedDirectory tests/os_window"

test-tab:
	nvim --headless -c "PlenaryBustedDirectory tests/tab"

test-window:
	nvim --headless -c "PlenaryBustedDirectory tests/window"

test-match:
	nvim --headless -c "PlenaryBustedDirectory tests/match"
