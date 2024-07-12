# Wayvifan

It was originally made so I could, on **Way**land, control my N**VI**DIA GPU **fan**s.\
It is a lightweight and easy to use script. It works on Xorg, too.

## What does it do?

It automatically changes the speed of your NVIDIA GPU fan(s), depending on the GPU temperature.\
It is configurable and should be adapted to your environment.\
There is a system to limit useless and repeated changes.\
For now, that is all!

## What does it need?

It uses the `nvidia-settings` command.\
On Debian, this command comes from the `nvidia-settings` package. This may differ depending on your distribution.\
To launch it, you will also need root permission and a shell.\
And... that's all. In fact, you don't even need Bash! If you prefer to use Dash, or any other POSIX-compliant shell, it should work on it!

## How to use it?

1. The file can be downloaded [here](https://github.com/Tutez64/Wayvifan/releases/latest).
2. Open the file with your favorite text editor and configure it to your liking.
Explanations and present, and you only really need to modify a single line.
3. Open a terminal and go to where the file is located. Alternatively, use your file browser to go where the file is and open a terminal from there
4. Make the file executable with `chmod +x Wayvifan.sh`
5. Execute with `./Wayvifan.sh`. You may need to enter your password so the script gains the right to control your GPU fan(s).

## Should I use it?

I am, you can too.\
As it is still in a quite early stage, a lot could be added to make it more feature-rich and even easier to use.\
Still, it works and could be good enough for you already.

## I want to know more!

An [FAQ](FAQ.md) is available.