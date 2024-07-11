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
