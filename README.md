# Shelf 
Shelf is a simple ZSH utility which can be used to bookmark and access directly any file
using mnemonics.

## Installation
Just source ``shelf.zsh`` 
``` zsh 
source /path/to/shelf.zsh
```
and include ``_shelf`` in your ``$fpath``. 
 
### Using Plugin Managers
Here it this: 
```
ecmma/shelf
```
You should know where it goes! In case you don't, 
refer to [getantibody](https://getantibody.github.io/) 
or your preferred [plugin manager](https://github.com/unixorn/awesome-zsh-plugins#installation) documentation.

## Usage 
``` zsh 
usage: shelf [command] <?arg(s)>
	remove 	<id> Remove a previously added mark
	open 	<id> Open a previously added mark
	add 	<id> <file> Add a new mark with <id> to <file>
	list 	List all marks

```

Mark your file with ``shelf``: 
``` zsh
shelf add myfile /long/path/to/file.pdf
```

Your file will be saved and you'll be able to open it using ``shelf`` from anywhere: 
```zsh 
shelf open myfile 
```


## Requirements
For Linux-based distros, a resource opener such as [xdg-open](https://wiki.archlinux.org/index.php/default_applications#xdg-open)
or [mimeo](https://wiki.archlinux.org/index.php/default_applications#mimeo) is required (well, to open the file!) 
For macOS, the ``open`` command should be enough. 
