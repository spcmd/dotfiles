# ==================================
# Setup system files:
# ==================================
# Do NOT use stow in this directory!
# Setup with the cp commands below!
# ==================================

# Setup root's minimal .vimrc
sudo cp ~/dotfiles/system_files/root-vimrc /root

# Setup root's bashrc
sudo cp ~/dotfiles/system_files/root-bashrc /root

# Setup hdparm
sudo cp ~/dotfiles/system_files/set-hdparm.service /etc/systemd/system
sudo systemctl enable set-hdparm.service
sudo cp ~/dotfiles/system_files/set-hdparm.sh /usr/lib/systemd/system-sleep

# Setup power button & lid
sudo mkdir /etc/systemd/logind.conf.d
sudo cp ~/dotfiles/system_files/power-button-and-lid.conf /etc/systemd/logind.conf.d

# Setup mount to /media
sudo mkdir /media
sudo cp ~/dotfiles/system_files/99-udisks2.rules /etc/udev/rules.d

# Setup /etc/issue
sudo cp issue /etc

# Set swapiness
sudo cp 99-sysctl.conf /etc/sysctl.d

# Disable cursor blink in TTY
sudo cp disable-cursor-blink-tty.conf /etc/tmpfiles.d

# Console keymap
sudo mkdir -p /usr/local/share/kbd/keymaps
sudo cp personal.map /usr/local/share/kbd/keymaps

# Console settings
sudo cp vconsole.conf /etc
