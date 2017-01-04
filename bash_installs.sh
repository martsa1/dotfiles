
# Trash-CLI provides CLI wrappers around FreeDesktop's Trash system
command -v trash >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Coudn't find trash, do you wish to install it?"
  read -p "Install Trash (y/n)? " continueOrNot
  if [ $continueOrNot == "y" -o $continueOrNot == "Y" ]; then
    echo -e "\nSetting up Trash"
    sudo -H pip install trash-cli
  fi
fi

# Git, 'nuff said.'
command -v git >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Couldn't find git, do you wish to install it?"
  read -p "Install Git (y/n)? " continueOrNot
  if [$continueOrNot == "y" -o $continueOrNot == "Y"]; then
    sudo apt-get install git
  fi
fi

# Autojump lets us move quickly between well used files
command -v autojump >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Couldn't find autojump, do you wish to install it?"
  read -p "Install autojump (y/n)? " continueOrNot
  if [$continueOrNot == "y" -o $continueOrNot == "Y"]; then
    sudo apt-get install autojump
  fi
fi

# Python3, we always want this!
command -v python3 >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Couldn't find Python 3, do you wish to install it?"
  read -p "Install Python 3 (y/n)? " continueOrNot
  if [$continueOrNot == "y" -o $continueOrNot == "Y"]; then
    sudo apt-get install python3 python3-dev
    sudo pip3 install virtualenvwrapper
  fi
fi
