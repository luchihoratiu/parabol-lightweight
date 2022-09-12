## Original project's overview

[Parabol](https://www.parabol.co) is an open-source application for running
the agile meetings Team Retrospective, Sprint Poker™ and Team Check-in. You may try
a single-player demo of the latest implementation of Parabol (no login creation required) at: https://parabol.co/retro-demo
![Dashboard](./docs/images/d2.gif)
![Discuss](./docs/images/d1.gif)

Make sure to check the original project at https://github.com/ParabolInc/parabol for more information about them and their continous work.

## Parabol Lightweight overview
Yet another fork in the pool of forks, but this one aims to work well on a Raspberry Pi 4 and lose some (hopefully more in the future) weight.
[DietPi](https://github.com/MichaIng/DietPi) was my choice for OS to run and test on but anything (especially Debian based) should work (with enough patience and tinkering).

## Installation
```bash
# Install Node with nvm
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source /root/.bashrc
nvm install 16.14.0

# Install Yarn with yvm
curl -s https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.js | node
source /root/.yvm/yvm.sh
yvm install

# Install dependencies
apt-get install ca-certificates curl gnupg lsb-release make cmake gcc g++ -y
apt-get install libvips-dev --no-install-recommends -y

# Install docker and its dependencies
apt-get remove docker docker-engine docker.io containerd runc
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install git docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Clone this repository
git clone https://github.com/luchihoratiu/parabol-lightweight.git
cd parabol-lightweight

# Create .env settings (You shouldn't need to change anything but feel free)
cp .env.lightweight .env

# Prepare environment
# Expect many errors the first time but running all of them twice solves all the issues
# (Order of commands might be wrong but couldn't find the correct one yet)
yarn
yarn db:start
yarn install
yarn update-schema
yarn relay
yarn db:start
yarn db:migrate
yarn pg:migrate up
yarn db:migrate up
yarn pg:build
yarn build

# Start application
yarn start
```

## Optional
### Run it as a service
```bash
cd /etc/systemd/system
nano parabol.service

# Add following lines and adapt paths/user to match yours
[Unit]
Description=Parabol
 
[Service]
User=root
WorkingDirectory=/root/parabol-lightweight
ExecStart=/bin/bash -c 'source /root/.nvm/nvm.sh && source /root/.yvm/yvm.sh && cd /root/parabol-ligthweight && yarn db:start && yarn start'

[Install]
WantedBy=multi-user.target
```

Let systemctl know of your changes:
```bash
# Reload
systemctl daemon-reload

# Enable
systemctl enable parabol

# Start
systemctl start parabol

# Check status
systemctl status parabol
```

### Overclock CPU
# WARNING - Use at your own risk
```bash
echo "over_voltage=11" >> /boot/config.txt
echo "arm_freq=2300" >> /boot/config.txt
echo "arm_freq_min=2300" >> /boot/config.txt
echo "current_limit_override=1" >> /boot/config.txt
echo "force_turbo=1" >> /boot/config.txt
```
# WARNING - Use at your own risk

#### Useful links:
Check https://dietpi.com/docs/usage/#how-to-do-an-automatic-base-installation-at-first-boot for how to use files from `.dietpi` folder.
