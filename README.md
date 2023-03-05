# cmp_kitty

Kitty completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

This extension pulls text from your Kitty windows and makes it available as a completion source.

## Requirements

- [Neovim](https://github.com/neovim/neovim/)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [kitty](https://github.com/kovidgoyal/kitty)

### Kitty Configuration

This extension requires that Kitty is configured to allow remote control. Refer to the
[Kitty documentation](https://sw.kovidgoyal.net/kitty/remote-control) for detailed information
about how this can be done.

To quickly get started you can start Kitty with the *allow_remote_control* flag

    kitty -o allow_remote_control=yes

or set *allow_remote_control* in your *kitty.conf* file to *yes*, but consider a more restrictive
setting such as limiting access to [sockets](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.listen_on)
and/or requiring a [password](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.remote_control_password).

Once configured you can test the Kitty configuration using the command line by opening a separate
terminal and executing a command such as:

    kitty @ ls

if *allow_remote_control* is *yes*, or

    kitty @ --to <your configured socket> ls

if you have configured Kitty for socket communication.

Once you have confirmed that Kitty is configured properly, then install and configure this
extension.

## Installation

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'garyhurtz/cmp_kitty'
}
```

## Setup

```lua
require('cmp').setup({
  sources = {
    { name = 'kitty' }
  }
})
```

## Configuration

Configuration follows nvim-cmp's standard *options* table. An example is shown below, which includes
all options with their default values.

By default all tabs and windows are matched and parsed, and all target information is returned. This should
be what most people want, but if you would like to remove some types of information that gets inserted
into your completions you can set the associated *match_* configuration option to false.

A simplified version of plugin configuration is below, where function
bodies have been removed and added to their respective sections of the documentation:

```lua
require('cmp').setup({
    sources = {
        {   name = 'kitty',
            option = {

                -- cmp configuration
                label = '[kitty]',
                trigger_characters = {},
                trigger_characters_ft = {},
                keyword_pattern = [[\w\+]],

                -- socket configuration
                listen_on = nil,

                -- what information to collect

                --- words
                match_words = true,
                match_upper_case = false,
                match_lower_case = false,
                match_capitalized = false,
                match_alphanumerics = true,
                match_camel_case = true,
                match_kebab_case = true,
                match_snake_case = true,

                --- numbers
                match_integers = true,
                match_floats = true,
                match_hex_strings = true,
                match_binary_strings = true,

                --- computing
                match_emails = true,
                match_ip_addrs = true,
                match_uuids = true,

                --- paths
                match_urls = true,
                match_directories = true,
                match_files = true,
                match_hidden_files = true,

                -- window matching configuration
                os_window = {

                    include_focused = true,
                    include_unfocused = true,

                    include_active = true,
                    include_inactive = true,

                    tab = {

                        include_active = true,
                        include_inactive = true,

                        include_title = function,
                        exclude_title = function,

                        window = {

                            include_focused = true,
                            include_unfocused = true,

                            include_active = true,
                            include_inactive = true,

                            include_title = function,
                            exclude_title = function,

                            include_cwd = function,
                            exclude_cwd = function,

                            include_env = function,
                            exclude_env = function,

                            include_foreground_process = function,
                            exclude_foreground_process = function,
                        },
                    },
                },

                extent = "all",

                -- Timing configuration
                window_polling_period = 2, -- in sec
                completion_min_polling_period = 10, -- in polling periods
                completion_item_lifetime = 60, -- in secs

            }
        }
    }
})
```

### Socket configuration

Refer to the [Kitty documentation](https://sw.kovidgoyal.net/kitty/remote-control/#remote-control-via-a-socket)
for information about configuring sockets.

#### listen_on

If you have configured Kitty to listen on a socket, then set this to tell Kitty where to listen
for remote control commands. This should be set to what you used for <your configured socket> in
the Kitty Configuration section above. For example, if you are using a unix socket you might use:

    unix:@kitty

See the [kitty docs](https://sw.kovidgoyal.net/kitty/remote-control) for more information.

You can test communication between cmp_kitty and Kitty itself with the command:

    :CmpKittyLs

See below for more information about this command.

## Content parsing configuration

The plugin currently supports parsing various types of information from Kitty window content:

### Words

- match_alphanumerics [default: true]

Match text that contains only letters and digits, with at least one letter and one digit.

- match_words [default: true]

Match anything that contains only letters, case-insensitive.

- match_upper_case [default: false]
- match_lower_case [default: false]
- match_capitalized [default: false]

Match the subsets of words that contain either all upper-case, all lower-case letters, or a single
upper-case letter followed by lower-case letters, respectively.

These default to false as they are subsets of *match_word*, which defaults true. For case-sensitive
word matching, set *match_words* to false then set one or more of these to true.

- match_camel_case [default: true]

Match camel-case words, which are a groups of two or more words where the separation
between them is designated with a single capital letter, rather than a space. For example,
ThisIsCamelCase, and thisIsCamelCase.

As shown in the examples, variations where the first letter of the phrase is upper-case and lower-case are
both supported.

- match_kebab_case

Match kebab-case words, which are a groups of two or more case-insensitive words where the separation
between them is designated with a single hyphen letter, rather than a space. For example, this-is-kebab-case.

- match_snake_case

Match snake-case words, which are a groups of two or more case-insensitive words where the separation
between them is designated with a single underscore, rather than a space. For example, this_is_snake_case.

### Numbers

- match_integers

Match groups of text that contain only digits. An optional leading + or - is allowed.

- match_floats

Match groups of text that contain only digits, followed by a dot, followed by more digits. An
optional leading + or - is allowed.

- match_hex_strings

Match text that appears to be a hexadecimal string. Optional prefixes 0x and # are also supported.

- match_binary_strings

Match text that consists of only 4 or more zeros and ones.

### Computing

- match_emails

Match text that appears to be an email address.

- match_ip_addrs

Match strings that appear to be IP addresses.

- match_uuids

Match strings that appear to be UUIDs.

### Paths

- match_urls

Match strings that appear to be URLs.

- match_directories

Match strings that appear to be directories.

- match_files

Match strings that appear to be files, possibly contained within one or more directories.

- match_hidden_files

Match strings that appear to be hidden files, possibly contained within one or more directories.

## Window matching configuration

In some cases it might be helpful to always include or exclude specific tabs and windows when
generating completions.

The high-level matching logic follows the same hierarchy as
[Kitty](https://sw.kovidgoyal.net/kitty/overview/#tabs-and-windows): OS-windows contain one or more
tabs, which each contain one or more windows, which each contain content, Following this hierarchy,
OS-windows are evaluated first, then any tabs contained within matching OS-windows are evaluated,
then windows contained within matching tabs are evaluated. Finally, the text content within matching
windows is retrieved and parsed.

The matching logic configuration items are prefixed with either *include_* or *exclude_*, each
controlling which tabs and windows to include and exclude, respectively. The high-level matching
logic is as follows:

    match = any(*include_*) and not any(*exclude_*)

that is, each tab and window is evaluated against each of the *include_* configuration items.
If any *include_* item returns True, then that window or tab is included *unless* any of the
*exclude_* configuration items also returns True. In that case, the window or tab is omitted.
As such, *exclude_* configuration items take precedence over *include_* items.

The details of the various configuration items follows.

### include_active, include_inactive, include_focused, and include_unfocused

OS-windows, tabs, and windows may each be filtered according to their state. By setting
*include_active*, *include_inactive*, *include_focused*, and/or *include_unfocused* to *true* or
*false* you can specify whether you want to include content from windows with one or both states.

Which tabs and windows are active and focused is defined in the
[Kitty docs](https://sw.kovidgoyal.net/kitty/remote-control):

> Active tabs are the tabs that are active in their parent OS window. There is only one focused tab
> and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused
> tab is matched
>
> Active windows are the windows that are active in their parent tab. There is only one focused
> window and it is the window to which keyboard events are delivered. If no window is focused,
> the last focused window is matched.

By default, tabs and windows of all states are included.

### include_title and exclude_title

Tabs and windows each have titles, which can be used to provide stateless control over which
tabs and/or windows to include and exclude. By default, cmp-kitty will include content from any tab
or window titled *"cmp-include"*, regardless of whether it is matched according to its active or
focus state.

For example, suppose you have a window that contains test output that is injecting a bunch of noise
into your completions. In that case, you can quickly omit completion items generated by that window
or tab by simply changing the title to *"cmp-exclude"*.

This plugin even provides a command to handle that for you:

    :CmpKittyExcludeWindow

See the Commands section below for more details.

The defaults are defined as follows:

```lua
include_title = function(title)
    return title == "cmp-include"
end

exclude_title = function(title)
    return title == "cmp-exclude"
end,
```

You can implement custom logic by replacing one or both of these functions with a custom function
that implements your desired logic. These functions should accept a single argument, the title of
the tab or window, then return true for titles that should be included or excluded.

### include_cwd and exclude_cwd

You can specifically include or exclude content from windows based on its current working directory.
This can be useful if, for example, you want to omit content from an entire project.

The defaults are defined to disable this feature:

```lua
include_cwd = function(path)
    return false
end

exclude_cwd = function(path)
    return false
end,
```

Enable this feature by replacing one or both functions with custom functions that accept a single argument,
a string containing the path of the current working directory, and should return true if the path
matches, and false if it doesn't.

### include_env and exclude_env

Windows can also be include or excluded based on their environment variables.

By default you can include or exclude a window by adding "CMP_INCLUDE" and/or "CMP_EXCLUDE"
environment variables and setting them to any value, which is implemented as follows:

```lua
include_env = function(env)
    return vim.tbl_contains(vim.tbl_keys(env), "CMP_INCLUDE")
end

exclude_env = function(env)
    return vim.tbl_contains(vim.tbl_keys(env), "CMP_EXCLUDE")
end,
```

You can implement different logic by replacing one or both of these functions with alternatives that
implement your desired logic. The functions will receive a table containing the environment
variables for each window, then should return true or false.

### include_foreground_process and exclude_foreground_process

Windows can also be included or excluded based upon which process is currently running. This feature
is disabled by default, but can be enabled by replacing the defaults with custom functions.

The defaults are implemented as follows:

```lua
include_foreground_process = function(process)
    -- match the command name
    local match_cmd = function(cmd)
        return false
    end

    for _, cmd in ipairs(process.cmdline) do
        if match_cmd(cmd) == true then
            return true
        end
    end

    return false
end

exclude_foreground_process = function(process)
    -- match the command name
    local match_cmd = function(cmd)
        return false
    end

    for _, cmd in ipairs(process.cmdline) do
        if match_cmd(cmd) == true then
            return true
        end
    end

    return false
end,
```

These functions are a bit more complicated than needed to simply return false, but are intended
to provide a template for implementing custom logic.

Each function will be passed one or more tables containing information about each process:

```lua
{
    cmd={string},
    pid=int,
    cwd=string
}
```

then should return true or false. If the function returns true for any of the tables, it is
considered a match. The default assumes that the process will be matched based on the command that
is running, but the pid and cwd can also be used.

Be sure to check the *foreground_processes* section of the output of the *:CmpKittyLs* command
to gain a better understanding of the inputs your functions will receive.

### Extent

Kitty not only provides information that can determine which windows to match, but also how much of
the window content to match.

Options are:

*all* - (default) include all window content, including scrollback
*screen* - include only content that is currently visible in the window
*selection* - include only content that is contained within a selection

See the [kitty docs](https://sw.kovidgoyal.net/kitty/remote-control/#kitty-get-text) for
more information.

## Timing Configuration

A brief description of the plugin architecture will be helpful to understanding the timing
configuration. In order to minimize lag when typing, completion candidates are held in a cache
that "sits between" the plugin and nvim-cmp. When completions are required, nvim-cmp collects
whatever candidates are currently in the cache, filters them, and returns them to you.

The "update cycle" runs in the background, collecting candidates from each window and adding
them to the cache, as well as removing expired items from the cache.

An update cycle begins by matching each tab and window according to the current configuration to
determine which Kitty windows will be parsed. Once the windows to be processed during the
update cycle have been determined, one window is processed every *window_polling_period*, with
any completion candidates added to the cache. If there are N matching windows, the update cycle
lasts N * *window_polling_period* seconds, or equivalently each window's content is parsed every
N * *window_polling_period* seconds. As such, setting *window_polling_period* to a smaller value
will make new content available in completions more quickly, at the cost of your computer doing a
bit more work.

At the end of the update cycle any expired candidates are pruned from the cache. Candidates expire
if they have been in the cache for longer than the *completion_item_lifetime*.

Finally, the next update cycle is scheduled. In most cases the next update cycle begins one
*window_polling_period* after the previous update cycle ended. However, in cases where are just a few
windows this would result in the same content being parsed over and over, which may not be necessary.
To avoid this, the *min_update_restart_period* sets the minimum number of polling periods to wait
before the next update cycle can start. This is specified as a number of polling periods, so this
is effectively the minimum number of windows to consider when scheduling the next update cycle.
To disable this feature and increase the frequency of updates when small number of windows exist, you
can set the *min_update_restart_period* to 1.

## Commands

### :CmpKittyLs

Open a buffer containing the output of Kitty's *ls* command. This is useful when customizing matching
logic. Details about the information contained in the response can be found in the
[kitty docs](https://sw.kovidgoyal.net/kitty/remote-control/#kitty-ls).

### :CmpKittyIncludeWindow

Display choices then change the selected window's title to "cmp-include". Note that this command only
works if *include_title* remains in the default setting.

### :CmpKittyExcludeWindow

Display choices then change the selected window's title to "cmp-exclude". Note that this command
only works if *exclude_title* remains in the default setting.
