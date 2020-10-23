# Lazy VIM

<img src="https://pbs.twimg.com/media/EktTEvQU8AITVjP?format=jpg&name=4096x4096" width="600px">

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

### (Optional for TinTin++) Configure ctags.d
```
cd ~/
mkdir ctags.d
cd ctags.d
ln -s ~/.vim/ctags.d/tt.ctags .
```
