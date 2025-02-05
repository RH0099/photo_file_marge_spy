#!/bin/bash

clear
echo -e "\e[1;34m======================================="
echo -e "\e[1;36m     Termux photo + info marge "
echo -e "\e[1;34m======================================="
echo -e "\e[0m"

# মেনু প্রদর্শন
echo -e "\e[1;33mWelcome to StegTool! Choose an option:"
echo -e "1. Hide a file inside an image"
echo -e "2. Extract a hidden file from an image"
echo -e "3. Exit"
echo -e "\e[0m"
echo -n "Please select an option (1/2/3): "

# অপশন ইনপুট
read option

# ফাইল লুকানোর জন্য অপশন 1
if [ "$option" -eq 1 ]; then
    echo -e "\n\e[1;32mYou chose to hide a file inside an image!\e[0m"
    echo -n "Enter the image file name (e.g., input.jpg): "
    read imgfile
    echo -n "Enter the file to hide (e.g., secret.txt): "
    read secretfile
    
    if [ -f "$imgfile" ] && [ -f "$secretfile" ]; then
        steghide embed -cf "$imgfile" -ef "$secretfile" > /dev/null 2>&1
        echo -e "\n\e[1;32mFile successfully hidden inside $imgfile!\e[0m"
    else
        echo -e "\n\e[1;31mError: One or both files do not exist. Please try again.\e[0m"
    fi

# ফাইল বের করার জন্য অপশন 2
elif [ "$option" -eq 2 ]; then
    echo -e "\n\e[1;32mYou chose to extract a hidden file from an image!\e[0m"
    echo -n "Enter the image file name (e.g., input.jpg): "
    read imgfile
    
    if [ -f "$imgfile" ]; then
        steghide extract -sf "$imgfile" > /dev/null 2>&1
        echo -e "\n\e[1;32mFile successfully extracted from $imgfile!\e[0m"
    else
        echo -e "\n\e[1;31mError: The image file does not exist. Please try again.\e[0m"
    fi

# অপশন 3: Exit
elif [ "$option" -eq 3 ]; then
    echo -e "\n\e[1;33mExiting StegTool. Goodbye!\e[0m"
    exit 0
else
    echo -e "\n\e[1;31mInvalid option selected. Please choose a valid option.\e[0m"
fi
