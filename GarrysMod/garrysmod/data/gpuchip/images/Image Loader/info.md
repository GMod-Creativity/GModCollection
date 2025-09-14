# Expression 2 - Extremely Fast Image Loader [HL-ZASM]

## Details

### Author

- Author: Drunkie

### Publication Info

- Title: Extremely Fast Image Loader [HL-ZASM]
- Date (dd-mm-yyyy): 09-03-2011
- Source: https://web.archive.org/web/20150427194916/http://www.wiremod.com/forum/cpu-gpu-hi-speed-discussion-help/25143-extremely-fast-image-loader-hl-zasm.html
- Source Accessed (dd-mm-yyyy): 24-08-2025

## Description

I present to you... The fastest image loader ever made in Gmod.

Many image loaders have been made. But none of them utilize the raw power of the GPU. Digital screens are slow, laggy devices. So I thought, why not use something that will get the job done efficiently? Behold, the new GPU with **blazing fast performance**. This baby loads a 256x256 image in under 30 seconds (At 50fps, varies by client) with absolutely no network choke or bottleneck on clients or server.

And wait till BP figures out how to over-clock this thing. Then we'll be talking.

### The process:

```plaintext
1. Visit my site, use the PHP interface to upload a PNG image.
2. Retrieve the link to the newly created text file (contains pixel data in base 16 (Hex))
3. Configure the E2 to set resolution size and Http link to text file with pixel data.
4. Let the E2 download the string, parse it, and writeArray() to GPU. (Takes less than 10 seconds)
5. Refresh the GPU so that it renders the image by looping through internal memory addresses.
6. ???
7. Profit!
```

### Features:

```plaintext
1. Once uploaded to GPU's internal memory, you can redraw as many times as you like without having to reupload the image over the network (like with the digital screen). Original image will always remain in memory.
2. Once upoaded, you can do any transformations to it (scale, rotate, translate) as many times as you like without losing the quality of the original image
3. Once finished drawing, image stays on screen and all rendering functions are halted to boost fps
4. Compressed hex format allows for faster parsing (Hex converted to base 10, bitwise operations performed on every pixel to extract R,G,B)
5. Draw speed can be modified to go faster or slower depending on client preferences
```

Thanks to Omicron for helping out with E2 optimizations. <!-- His server is at 71.183.233.66:27017. You can beta test HL-ZASM there; BP has uploaded a recent version there. -->
