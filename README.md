# cmp_kitty

Kitty completion source for [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).

This extension extracts content from Kitty windows and makes it available in nvim-cmp completions.
A wide range of configuration options provide control over the types of information to extract,
as well as which tabs and windows contribute completions.

## Motivation / use case

When working on a project one often has several Kitty windows open containing different types of
information from different sources. For example, one tab might contain windows containing Neovim,
test output, and a command line, while another tab might contain other project-related content.

This extension pulls content from each of the tabs and windows and makes it available in Neovim
via completions, which provides a bit of integration between the different tools.

Example use cases:

1. While developing a Flask application, one often needs to reference view *endpoints*. While one
   could create a custom completion source containing endpoints for each project, this can be
achieved automatically with *cmp-kitty*; Simply create a new Kitty window, run `flask routes`, which
lists all project endpoints in that window. After jumping back to the original window all project
endpoints appear as completion candidates.

1. While working on front-end development one often has both HTML and javascript files open, with a
   javascript file referencing *ids*, *classes*, etc in the HTML. *cmp-kitty* automatically parses
this content from the HTML window and makes it available in the javascript window (and vice versa),
allowing auto-completion that automatically updates as the project develops.

1. One can access a specific filename in Neovim by jumping to a new Kitty window, cd'ing into
the directory containing the file, then running ls. After jumping back to Neovim the filename appears
in the completions.

## Requirements

- [Neovim](https://github.com/neovim/neovim/)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [Kitty](https://github.com/kovidgoyal/kitty)

### Kitty configuration

This extension requires configuring Kitty to enable remote control. Refer to the
[Kitty documentation](https://sw.kovidgoyal.net/kitty/remote-control) for detailed information
about how to do this.

In short, set the *allow_remote_control* line of your *kitty.conf* file to one of:

    allow_remote_control socket-only
    allow_remote_control socket
    allow_remote_control yes

Next, follow [the instructions](https://sw.kovidgoyal.net/kitty/conf/#opt-kitty.listen_on) for setting
the socket that Kitty uses for communication.

Once configured you can test the Kitty configuration from the command line by opening a separate
terminal and executing a command such as:

    kitty @ ls

which returns a JSON response when Kitty has been configured correctly.

After configuring Kitty, then install this extension.

## Installation and setup

Use your package manager of choice. For example [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use {
  'garyhurtz/cmp_kitty',
    config = function()
        require('cmp_kitty'):setup()
    end
}

```

then

```lua
require('cmp').setup({
  sources = {
    { name = 'kitty'
        option = {
            -- this is where any configuration should be inserted
        }
    }
  }
})
```


If you use [lazy.nvim](https://github.com/folke/lazy.nvim) the setup would be something like this:

```lua
require("lazy").setup({
    {
        "hrsh7th/nvim-cmp",
        opts = {
            completion = {
                ...
            },
            sources = {
                ...
                {
                    name = "kitty",
                    option = {
                        -- this is where any configuration should be inserted
                    },
                },
            },
        },
    },
    {
        "garyhurtz/cmp_kitty",
        dependencies = {
            { "hrsh7th/nvim-cmp" },
        },
        init = function()
            require('cmp_kitty'):setup()
        end
    },
})
```

To check your installation you can test communication between *cmp_kitty* and Kitty itself with the command:

    :CmpKittyLs

This should open a new buffer and insert the contents of Kitty's JSON response, as it did from the
command line.

See below for more information about this command.

## Configuration

Configuration uses nvim-cmp's standard *option* table, as shown below. By default all tabs and windows contribute
completions, and completions include most types of available information. Configure which information to
include using the *match_* configuration options, below. You can find the bodies of the default functions
in their respective sections of the documentation.

```lua
option = {

    -- cmp configuration
    trigger_characters = {},
    trigger_characters_ft = {},
    keyword_pattern = [[\w\+]],

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
    match_dot_case = true,
    match_words_with_punctuation = true,

    --- numbers
    match_integers = true,
    match_floats = true,
    match_hex_strings = true,
    match_binary_strings = true,

    --- computing
    match_emails = true,
    match_ip_addrs = true,
    match_uuids = true,
    match_aws_unique_id = false,

    --- paths
    match_urls = { "https?" },
    match_directories = true,
    match_files = true,
    match_files_by_suffix = {},
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

    strict_matching = true,

    -- Timing configuration
    window_polling_period = 100, -- in msec
    completion_min_update_period = 5, -- in seconds
    completion_item_lifetime = 60, -- in seconds
}

```

## Content parsing configuration

This plugin supports parsing various types of information from Kitty window content:

### Words

- match_alphanumerics [default: true]

Match text consisting of only letters and digits, with at least one letter and one digit.

- match_words [default: true]

Match anything consisting of only letters, case-insensitive.

- match_upper_case [default: false]
- match_lower_case [default: false]
- match_capitalized [default: false]

Match text that consists of either all upper-case, all lower-case letters, or a single upper-case
letter followed by lower-case letters, respectively.

These are *false* by default since they return subsets of *match_word*, which is *true* by default.
To enable case-sensitive word matching, set *match_words* to *false* then set one or more of these to *true*.

- match_camel_case [default: true]

Match camel-case words, which are groups of two or more words with word boundaries designated by a
single capital letter, rather than a space. For example, ThisIsCamelCase, and thisIsCamelCase. As
shown in the examples, variations with either upper-case and lower-case first-letters are both
supported.

- match_kebab_case [default: true]

Match kebab-case words, which are groups of two or more case-insensitive words with word boundaries
designated by a single hyphen, rather than a space. For example, this-is-kebab-case.

- match_snake_case [default: true]

Match snake-case words, which are groups of two or more case-insensitive words with word boundaries
designated by a single underscore, rather than a space. For example, this_is_snake_case.

- match_dot_case [default: true]

Match dot-case words, which are groups of two or more case-insensitive words with word boundaries
designated by a single dot, rather than a space. For example, this.is.dot.case.

- match_words_with_punctuation [default: true]

Like *match_words*, but matches words followed by a single punctuation character, then returns the
word without the punctuation.

### Numbers

- match_integers [default: true]

Match groups of text consisting of only digits, optionally with a leading + or -.

- match_floats [default: true]

Match groups of text that contain only digits, followed by a dot, followed by more digits,
optionally with a leading + or -.

- match_hex_strings [default: true]

Match text consisting of only hexadecimal characters, optionally with a leading 0x or # prefix.

- match_binary_strings [default: true]

Match text consisting of only 4 or more zeros and ones.

### Computing

- match_emails [default: true]

Match text that appears to be an email address.

- match_ip_addrs [default: true]

Match text that appears to be an IP address.

- match_uuids [default: true]

Match text that appears to be a UUID, optionally wrapped in brackets.

- match_aws_unique_id default: false

Match text that appears to be an AWS Unique ID (Access Key ID, etc).

This is opt-in (defaults *false*) due to potential security implications.

### Paths

- match_urls [default: {"https?"}]

Match text that appears to be a URL using one of the specified schemes. Specify other schemes
by adding them to the *match_urls* configuration table. Note that schemes specified in
configuration replace the default rather than add to it.

- match_directories [default: true]

Match text that appears to be a directory.

- match_files [default: true]

Match text that appears to be a file, possibly within one or more directories.

- match_hidden_files [default: true]

Match text that appears to be a hidden-file, possibly within one or more directories.

- match_files_by_suffix [default: {}]

A complementary and more liberal method of identifying files. By default this doesn't match any
files. Add one or more suffixes to this table to identify file types that should match liberally.
Specify suffixes without the leading dot, using either strings or patterns.

## Window matching configuration

Window-matching configuration provides control over which tabs and windows contribute completion
candidates. Matching follows the
[Kitty hierarchy](https://sw.kovidgoyal.net/kitty/overview/#tabs-and-windows): OS-windows contain
one or more tabs, which each contain one or more windows, which each contain content. Following
this hierarchy, *cmp_kitty* evaluates OS-windows first, followed by any tabs contained within
matching OS-windows, then windows contained within matching tabs.

Configuration items for tab and window matching logic use the *include_* and *exclude_* prefixes,
specifying which tabs and windows to include and exclude, respectively. The high-level matching
logic is as follows:

    match = any(*include_*) and not any(*exclude_*)

In other words, evaluate each tab and window according to each of the *include_* configuration items.
If any *include_* item returns True then include that window or tab *unless* any of the
*exclude_* configuration items also returns True. In that case, ignore content from that window or tab.
As such, *exclude_* configuration items take precedence over *include_* items.

The details of the various configuration items follows.

### include_active, include_inactive, include_focused, and include_unfocused

These evaluate OS-windows, tabs, and windows according to their states. By default each of
*include_active*, *include_inactive*, *include_focused*, and *include_unfocused* are *true*.
Set one or more of these to *false* to exclude content from tabs and windows in that state.

The [Kitty docs](https://sw.kovidgoyal.net/kitty/remote-control) define when tabs and windows are
either active or focused:

> Active tabs are the tabs that are active in their parent OS window. There is only one focused tab
> and it is the tab to which keyboard events are delivered. If no tab is focused, the last focused
> tab is matched
>
> Active windows are the windows that are active in their parent tab. There is only one focused
> window and it is the window to which keyboard events are delivered. If no window is focused,
> the last focused window is matched.

### include_title and exclude_title

These evaluate tabs and windows according to their titles. By default, *cmp-kitty* always includes
content from tabs and windows titled *"cmp-include"*, and always excludes content from tabs and
windows titled *cmp-exclude*, regardless of state.

The [Kitty docs](https://sw.kovidgoyal.net/kitty/remote-control/) detail how to set tab and window
titles using scripts. This plugin includes a command that sets a window title to *cmp-exclude*:

    :CmpKittyExcludeWindow

See the Commands section below for more details.

The default function bodies are:

```lua
include_title = function(title)
    return title == "cmp-include"
end

exclude_title = function(title)
    return title == "cmp-exclude"
end,
```

Implement custom logic by replacing one or both of these functions with a custom function
that implements the desired logic. These functions should accept a single argument, the title of
the tab or window, and return *true* for tabs and windows to include and *false* for those to exclude.

### include_cwd and exclude_cwd

These evaluate windows based on their current working directory. This can be useful if, for example,
you want to omit content from an entire project.

The default function bodies disable this feature:

```lua
include_cwd = function(path)
    return false
end

exclude_cwd = function(path)
    return false
end,
```

To enable this feature, replace one or both functions with functions that implement the desired
logic. These functions should accept a single argument, a string containing the path of the current
working directory, then return *true* to include the window or *false* to exclude it.

### include_env and exclude_env

These evaluate windows based on their environment variables.

The default function bodies include windows that contain an environment variable called
"CMP_INCLUDE" and exclude windows containing an environment variable called "CMP_EXCLUDE":

```lua
include_env = function(env)
    return vim.tbl_contains(vim.tbl_keys(env), "CMP_INCLUDE")
end

exclude_env = function(env)
    return vim.tbl_contains(vim.tbl_keys(env), "CMP_EXCLUDE")
end,
```

To implement custom logic, replace one or both of these functions with a custom function. This
function should accept a table containing each window's environment variables, then return *true*
to include the window, or *false* to exclude it.

### include_foreground_process and exclude_foreground_process

These evaluate windows based on the processes running within them. The default function bodies
provide templates for implementing custom logic, but otherwise disable this feature:

```lua
include_foreground_process = function(process)
    local match_cmd = function(cmd)
        -- match the command here
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
    local match_cmd = function(cmd)
        -- match the command here
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

Kitty returns the processes running within each window as a list of one or more tables. The
default implementations loop over this list, passing each table to the *match_cmd* function.
Each table contains the following information:

```lua
{
    cmd={string},
    pid=int,
    cwd=string
}
```

Implement custom logic by replacing *match_cmd* with a function that accepts these tables as input,
then returns *true* for windows to include, or *false* for windows to exclude. A window
contributes completions if *match_cmd* returns *true* for any table in the list.

Be sure to examine the *foreground_processes* section of the output of the *:CmpKittyLs* command
to gain a better understanding of the inputs that these functions receive.

### Extent

Kitty provides the ability to specify how much window content to include when collecting completion
candidates. The options are:

* *all* - the default, include all window content including the scroll-back
* *screen* - include only the currently visible content
* *selection* - include only content the contained within the current selection

See the [kitty docs](https://sw.kovidgoyal.net/kitty/remote-control/#kitty-get-text) for
more information.

### Strict matching

nvim-cmp configuration provides control over the completions it suggests from each source, typically
using fuzzy-matching. If *cmp_kitty* returns too many completions, set *strict_matching* to *true*
to restrict the completions that *cmp_kitty* returns to only those that match the current input.

## Timing configuration

A brief description of the plugin architecture can be helpful to understanding the timing configuration.
*cmp_kitty* stores completion candidates in a cache, which provides a quick response when nvim-cmp
requests completions. In parallel, *cmp_kitty* starts an "update cycle" in the background, collecting
candidates from each window and adding them to the cache so that they become available as nvim-cmp
requests them.

The update cycle proceeds in several steps. In the first step *cmp_kitty* evaluates each tab and window
according to the current configuration to determine which windows should contribute completions.
In the second step, *cmp_kitty* processes one window every *window_polling_period* msec, in order to
spread out the work of querying Kitty and parsing content, then adds any completion candidates to the
cache. Reduce the polling period for more aggressive timing, or increase it as needed on slower machines.
In the third step of the update cycle *cmp_kitty* evaluates each item in the cache and removes those
that have been in the cache for longer than the *completion_item_lifetime*.

Finally, the *min_update_restart_period* defines the minimum number of seconds that *cmp_kitty* should
wait between update cycles. If nvim-cmp requests completions during this period it receives items from
the cache, as usual, but *cmp_kitty* won't start a new update cycle until the first time nvim-cmp
requests completions after this period expires.

## Commands

### :CmpKittyLs

Open a buffer containing the output of Kitty's *ls* command. This is useful when customizing matching
logic. Details about the information contained in the response are available in the
[kitty docs](https://sw.kovidgoyal.net/kitty/remote-control/#kitty-ls).

### :CmpKittyIncludeWindow

Display choices then change the title of the selected window to "cmp-include". Note that this command
only works if *include_title* remains in the default setting.

### :CmpKittyExcludeWindow

Display choices then change the title of the selected window to "cmp-exclude". Note that this command
only works if *exclude_title* remains in the default setting. Note that completions from an excluded
window will persist for *completion_item_lifetime*, as described in the *Timing configuration*
section.
