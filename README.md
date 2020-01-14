# dotfiles
Bash scripts and other files backed up from the user director (~/)

## Setup Mac

1. Install [Homebrew](https://brew.sh) for installing commandline software

2. Install [rbenv](https://github.com/rbenv/rbenv) (Ruby Environment) for installing newer versions of Ruby locally/globally

		brew install rbenv

3. Install Xcode Command line tools (included with Homebrew)

		xcode-select --install


## Configure Local Machine

1. Download from Github

		cd ~
		git clone https://github.com/PaulSolt/dotfiles.git

2. Setup Symlinks

	**zsh**

		ln -s dotfiles/.zshrc .zshrc

	**bash**
	
		ln -s dotfiles/.bashrc .bashrc
		ln -s dotfiles/.bash_profile .bash_profile

3. Reload bash profile

	**zsh**

		source ~/.zshrc

	**bash**

		source ~/.bash_profile

4. Test a command (pwdf - print front most finder directory path)

		pwdf

## One Time Setup

Using version control makes this easier to download and setup

	cd ~
	mkdir dotfiles

Move files into `dotfiles`	


	mv .zshrc dotfiles/

	mv .bashrc dotfiles/
	mv .bash_profile dotfiles/

Create a symlink to the files

	ln -s ~/dotfiles/.zshrc .zshrc

	ln -s ~/dotfiles/.bashrc .bashrc
	ln -s ~/dotfiles/.bash_profile .bash_profile

## References

* <https://stackoverflow.com/questions/20008354/version-controlling-bashrc-etc>
* [Configuring bash scriptingosx.com](https://scriptingosx.com/2017/05/configuring-bash-with-aliases-and-functions/)
