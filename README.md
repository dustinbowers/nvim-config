# neovim configs

### Requirements

- neovim >= 0.8
- npm


### Basic install

```bash
git clone https://github.com/dustinbowers/nvim-config.git ~/.config/nvim
cd ~/.config/nvim
npm install
```

Mason *should* auto-install plugins when `nvim` is launched, but if it doesn't then use:
```
:MasonInstall
```

---

### Upgrading Neovim

#### For ARM64 (Ubuntu):

```bash
cd /tmp
wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz
tar -zxf nvim-linux-arm64.tar.gz
sudo mv nvim-linux-arm64 /opt/nvim
sudo ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

# this is necessary on ubuntu to stop `nvim` from defaulting to /usr/bin/nvim
sudo update-alternatives --install /usr/bin/nvim nvim /usr/local/bin/nvim 110
```

