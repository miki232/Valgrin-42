# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    va-install.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mtoia <mtoia@student.42roma.it>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/05 18:49:01 by mtoia             #+#    #+#              #
#    Updated: 2022/11/06 16:36:50 by mtoia            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

dir=$(dirname -- "$0")
current_dir=$(pwd)

Black='\033[0;30m'
DarkGray='\033[1;30m'
Red='\033[0;31m'
LightRed='\033[1;31m'
Green='\033[0;32m'
LightGreen='\033[1;32m'
BrownOrange='\033[0;33m'
Yellow='\033[1;33m'
Blue='\033[0;34m'
LightBlue='\033[1;34m'
Purple='\033[0;35m'
LightPurple='\033[1;35m'
Cyan='\033[0;36m'
LightCyan='\033[1;36m'
LightGray='\033[0;37m'
White='\033[1;37m'
End='\033[0m'

echo "${Purple}Installing Brew and Valgrind"
echo "${LightBlue}First Installing Brew${End}"

curl -fsSL https://rawgit.com/kube/42homebrew/master/install.sh | zsh

if test "$?" -ne 0
then
    echo "${Red}ERROR INSTALLING BREW $res"
else
    echo "${Green}Brew Installed"
fi

echo "${Purple}Now Installing Valgrind${End}"

nodir="."

if [ "$dir" = "$nodir" ]
then
    va_path="sh ${current_dir}/valgrind.sh"
else
    va_path="sh ${dir}/valgrind.sh"
fi

if ! command -v brew &> /dev/null
then
    echo "${Purple}Opening a new Terminal for install valgrind${End}"
    sleep 1
    osascript -e "tell application \"Terminal\" to do script \"${va_path}\""
    exit
fi

echo "${Purple}\nWait${End}"

brew tap LouisBrunner/valgrind

brew install --HEAD LouisBrunner/valgrind/valgrind

if test "$?" -ne 0
then
    echo "${Red}ERROR INSTALLING VALGRIND"
    echo "${Red}Trying to resolve, maybe is Libtool"
    brew update
    brew install Libtool
    brew install --HEAD LouisBrunner/valgrind/valgrind
    if test "$?" -ne 0
    then
        echo "${Red}ERROR INSTALLING VALGRIND"
        echo "${Red}Veditela te, SUCA"  
    else
        echo "${Green}Valgrind Installed" 
    fi
else
    echo "${Green}Valgrind Installed"
fi
