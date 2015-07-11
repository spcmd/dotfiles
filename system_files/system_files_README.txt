# ==================================
# Setup system files:
# ==================================
# Do NOT use stow in this directory!
# Setup with the cp commands below!
# ==================================

# Setup root's minimal .vimrc
sudo cp ~/dotfiles/system_files/root-vimrc /root/.vimrc

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

