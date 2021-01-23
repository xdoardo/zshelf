# Shelf 
Shelf is a simple ZSH utility which can be used to bookmark and access directly any file, 
associating mnemonics to them. 

## Installation
Just copy ``shelf.zsh`` somewhere in your ``$PATH`` and include ``_shelf`` in your 
``$fpath``. 

## Usage 
``` zsh 
usage: shelf [command] <?arg(s)>
	remove 	<id> Remove a previously added mark
	open 	<id> Open a previously added mark
	add 	<id> <file> Add a new mark with <id> to <file>
	list 	List all marks

```

## Requirements
For Linux-based distros, a resource opener such as [xdg-open](https://wiki.archlinux.org/index.php/default_applications#xdg-open)
or [mimeo](https://wiki.archlinux.org/index.php/default_applications#mimeo) is required (well, to open the file!) 
For macOS, the ``open`` command should be enough. 
