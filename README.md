# do-more-in.vim

Jump to the next or previous occurance of `<open_delimeter>...<close_delimeter>` when using *in* and *around* commands such as `ci"`.

For example, with this plugin, if `ci"` is used outside of a set of quotes it will:

1)	Attempt to jump forward in the line to find a quoted string to act upon
2)	Attempt to jump backward in the line to find a quoted string to act upon
3)	Find the next quoted string in the file and act upon that

# supported features
modes supported:

+ `change`
+ `delete`
+ `yank`
+ `visual`

delimeters supported:

+ `\``
+ `'`
+ `"`
+ `()`
+ `{}`
+ `[]`
