# Load modular aliases
if [ -d ~/.bash_aliases.d ]; then
	for aliases in ~/.bash_aliases.d/*;do
		source $aliases
	done
fi
