# dotfiles
Bash scripts and other files backed up

Back Up .files in the User Directory With LInks

	cd ~
	mkdir dotfiles

Move files into `dotfiles`	

	mv .bashrc dotfiles/
	mv .bash_profile dotfiles/

Create a symlink to the files

	
	ln -s dotfiles/.bashrc .bashrc
	ln -s dotfiles/.bash_profile .bash_profile

References

* <https://stackoverflow.com/questions/20008354/version-controlling-bashrc-etc>
* [Configuring bash scriptingosx.com](https://scriptingosx.com/2017/05/configuring-bash-with-aliases-and-functions/)