# Custom Script (post-networking and post-DietPi install)
# HOW TO USE:
# In dietpi.txt, find and set AUTO_SETUP_CUSTOM_SCRIPT_EXEC to https://raw.githubusercontent.com/luchihoratiu/parabol-lightweight/development/.dietpi/Automation_Custom_Script.sh

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
