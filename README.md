# lazyVIM

![LazyVIM look&feel](https://pbs.twimg.com/media/EktTEvQU8AITVjP?format=jpg&name=4096x4096)

## How to use

### Basic

```
cd ~/
mv .vim .vimbak
git clone https://github.com/lazywalker/lazyvim.git .vim
ln -s .vim/vimrc .vimrc

vim +PlugClean +PlugUpdate +qa

```
### Install Universla-ctags for Tagbar

- macOS: 
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```
- Debian: 
```
sudo apt install universal-ctags
```

### Install SilveSearcher for CtrlSF

- macOS: 
```
brew install ag
```
- Debian: 
```
sudo apt install silversearcher-ag
```

### Install NodeJs for coc.vim
- macOS: 
```
brew install nodejs
```
- Debian: 
```
sudo apt install nodejs
```
