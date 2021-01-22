# Shelf 
Shelf is a simple ZSH utility, which can be used to bookmark and access directly any file, 
associating mnemonics to them. 

## Installation
Just copy ``shelf.zsh`` somewhere in your ``$PATH`` and include ``_shelf`` in your 
``$fpath``. 

## Usage 
``` zsh 
usage: shelf [command] <?arg(s)>
	remove 	<id> Remove a previously added bmark
	open 	<id> Open a previously added bmark
	add 	<id> <file> Add a new bmark with <id> to <file>
	list 	List all bmarks

```
