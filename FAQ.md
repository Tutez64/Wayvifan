# FAQ
## Why?

After switching from Xorg to Wayland (on june 2024), I discovered NVIDIA Settings were pretty much empty there. In fact, even controlling the speed of my GPU fans wasn't possible.
At first, I searched for an alternative. And there are a lot. But the first ten pieces of software and scripts I found all had something not so great about them, for example:

- not supporting Wayland and/or NVIDIA (quite deal-breaking in my case);
- being really too simple;
- forcing a fan curve. I don't like curves. Or at least, not in this context;
- being heavier than the sun and/or using Flatpak as the only alternative to building them directly from source.

At the end of the day, I could have gone with one of those. But programming is fun, so why not make my own one?

## What does Wayvifan do differently?

Since it is a script, many things! Including:

- not requiring Snap or Flatpak, nor building from source, nor finding if your distribution has it in their repository.
- being extremely lightweight at only a few kilobytes;
- being particularly portable, due to its weight and ease of use;
- not being dependent on Xorg, meaning it works on Wayland.

## What is it lacking?

Again, many things! Including:

- a GUI (graphical user interface). But I don't consider it being a problem, as it would remove a lot of the advantages and I don't see what it could really bring to the table;
- multiple GPUs support, not that it would make a huge difference;
- AMD and Intel support, I don't even have GPUs from them;
- automatic launch at boot. Although there are many ways to do it like with any other script, so feel free to.

## Are there new features planned?

I'm not really planning anything, but I have some things in mind:

- AMD and Intel support;
- automatic installation of `nvidia-settings` (WIP);
- support for non-GPU fans;
- support for logging to a file;
- support for arguments;
- for easier programming, a pseudo-GPU with unit tests.

## Why use Bourne shell instead of Bash?

That's a great question.\
I first started this script using Bash, but as I discovered more about Bash, Sh, Dash etc. I decided to go with the last two.\
The reasons are that they offer better compatibility, speed (at least Dash does), resources efficiency, and it's also more interesting and more rewarding as all the useful additions of Bash aren't present.\
We could argue about whether Bash (or Python, or any other language) would have been a better choice or not, but Sh does offer unique advantages, and learning it definitely is interesting!