#!/bin/bash

# Colors
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

# Setup variables
re='^[0-9]+$'
i=0
commands=("./bin/ceph -s"
          "./bin/ceph osd primary-affinity 2 0"
          "./bin/ceph pg dump pgs_brief"
          "./bin/ceph osd pool ls detail"
          "./bin/ceph osd getmap -o om"
          "./bin/osdmaptool om --upmap out.txt"
          "./bin/osdmaptool om --vstart --read out.txt --read-pool default.rgw.control"
          "cat out.txt"
          "source out.txt"
          "./bin/ceph osd pool ls detail")

descriptions=("Check ceph status"
              "Change primary affinity on one of the OSDs."
              "Check that no primary PGs are on osd.2"
              "Check pool details for current read balancer scores. We’ll try to improve the score of pool 6, or “default.rgw.control”"
              "Get latest copy of your OSD map."
              "Run the upmap balancer first to make sure writes are balanced. In this case, the upmap balancer was unable to optimize further."
              "Run the read balancer, focusing on “default.rgw.control”:"
              "We can check to see what the balancer suggests in the “out.txt” file:"
              "We can apply the file to a live system if we choose:"
              "Notice how the score has improved to 1.03 for “default.rgw.control”, which previously had a score of 1.41:")


echo "Press 'q' to exit"
echo "Cycle through numbers 0-9 for the demo..."
printf "\n"

while [ true ] ;
do
    read -n 1 k <&1
    clear
    if [[ $k = q ]] ; then
        printf "\n"
        echo "Quitting from the program"
        break
    elif [[ $k = 2 ]] ; then
        echo -e ${RED} $k. ${descriptions[2]} ${NOCOLOR}
        printf "\n"
        echo -e ${LIGHTGREEN}"$" ${commands[2]} '| grep "6\."' ${NOCOLOR}
        printf "\n"
        ${commands[$k]} 2>&1 | grep -v experimental | grep "6\."
        printf "\n\n"
    elif [[ $k =~ $re ]] ; then
        echo -e ${RED} $k. ${descriptions[$k]} ${NOCOLOR}
        printf "\n"
        echo -e ${LIGHTGREEN}"$" ${commands[$k]} ${NOCOLOR}
        printf "\n"
        ${commands[$k]} 2>&1 | grep -v experimental
        printf "\n\n"
    else
        echo "Incorrect input; enter a number between 0-7"
        printf "\n\n"
    fi
done
