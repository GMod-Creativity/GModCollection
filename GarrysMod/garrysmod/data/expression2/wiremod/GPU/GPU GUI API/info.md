# Expression 2 - Default [e2] gpu gui api

## Details

### Author

- Author: Mat000

### Publication Info

- Title: Default [e2] gpu gui api
- Date (dd-mm-yyyy): 08-01-2011
- Source: https://web.archive.org/web/20150428124054/http://www.wiremod.com:80/forum/finished-contraptions/24271-e2-gpu-gui-api.html
- Source Accessed (dd-mm-yyyy): 13-08-2025

## Description

### Comment on 26-09-2011

This E2 does not work anymore, it's outdated because of the new ZGPU. You'll need to edit a bit the opcodes, registers and such to get it working on ZCPU2.  
Sure you can, I guess now with UDF's it'd be awesome. <!-- I don't know what admins will do to you though, for bumping this topic -->

### GPU GUI API

Hey everyone, I recently found out how to "inject" code to GPU and had idea to make some "library" in E2 to make really easy GUIs.  
API stand for Application Programming Interface, meaning you don't directly touch at GPU's memory, you use my "interface" to do so.  
You actually must use two E2s :  
Yours will be the application, and mine the library (you should not have to edit it).

What it gives : http://s2.noelshack.com/uploads/imag...tgrass0000.jpg  
On screenshot there's a contraption with Graphics Tablet, GPU and two E2s.

The communication between Client and API is done with 2 gTables (their name are unique due to E2's entity id, so it allows several contraptions) :  
GUI table is used for use events, to clear screen, load a form, as Update table is used to update GUI's elements such as label texts, object's colors, lists elements, etc...

### Objects and syntax

In order to make a form you need to initialize an array with strings describing each "object" of the GUI.

- #### Here's the objects

    ```plaintext
    Every object have at least custom color option (alpha included).

    - Label : static text, optional font size and alignement and dynamic text of 64-char max.
    Custom members : Label (text showed on screen), Fontsize (optional), Fontalign (optional)
    - BigLabel : same as Label but with 4096 chars, useful for paragraphs.
    Custom members : Fontsize (optional), Fontalign (optional)
    Note that you can't directly put text while creating it, you must update it when loading is finished (for ops cost reasons)
    - Button : outlined rectangle, custom size, optional font size and alignement.
    Custom members : Label, Fontsize (optional), Fontalign (optional)
    - List : rectangle with items of 64-char maximum strings, and 64 elements max. It haves highlight of current element, dynamic update, aswell as custom color, etc...
    Custom members : Fontsize
    - Line : simple line.
    Custom members : StartX, StartY, EndX, EndY (disabled for grids, use coords)
    - Rect : simple rectangle.
    Custom members : StartX, StartY, EndX, EndY (disabled for grids, use coords)
    - Slider : rectange with a line, describing a value between min and max. Compatible with negative ranges.
    Custom members : From, To, Default (will be initialized to that value)
    Every GUI object have at least R, G, B, A, Parent, Row and Column members.
    ```

- #### Special objects

    ```plaintext
    - Grid : information holding start position, size, spacing and number of columns and rows. Used to locate any of the GUI objects, since you can't place them directly.
    Grids were made to easily make well-aligned objects. If you still want to create an object at specific position you just have to create a grid with one row, one column and no spacing.
    Members : StartX, StartY, EndX, EndY, SpacingX (optional), SpacingY (optional), Rows, Columns
    - BGColor.BGColor (optional) : used to specify once the background color. E2 always check for that object before doing object parsing.
    Members : R, G, B, A
    - Font.Font : You must use it once, unless you don't want any text. Used to specify font size and font id.
    Members : FontID, Fontsize
    - ScaleRotation.ScaleRotation (optional) : used to specify once the X and Y scale and the rotation of screen
    Members : Horizontal, Vertical, Rotation

    The syntax is : "ObjectType/ObjectName/Members"
    Members' syntax is : "Name:Value, Name2:Value2, Number:255, Label:Sample label"
    Note that special objects like Font.Font must have the same name as object type.

    Everywhere, objects will be named like "ObjectType.ObjectName". Parent member must be initialized to a grid name.
    Objects are drawn in list order (first to last).
    ```

### Triggers

This E2 was made in order to get rid of annoying checks like "if(inrange(X, 256, 384) & inrange(Y, 128, 256))".  
Your E2 will just have to check object's name, making it really easy to use.

You must wire a Graphic Tablet to the E2, aka X, Y and Use outputs.
When "Use" occurs, E2 will iterate trough each object until it founds the first object that fits in current coordinates. Only Buttons, Sliders and Lists are triggered.  
Sliders are triggered every tick until user release "Use" key (this allows dynamic changing like pitch of a song).

When an object is triggered, GUI["ClickEvent", string] is set to object's name, and you must reset it to a null string ("").  
A triggered Button means user pressed the Use key on it.  
When a Slider is released, GUI["SliderValue", number] holds the current value of position, wich is clamped between From and To members of the slider.  
When a Slider is moving, GUI["UseObject", number] is set to 1 until released.  
When a List is triggered, GUI["ClickListIndex", number] holds the new index of list. (between 1 and 64)

You can access to an object's data by using GUI["ObjectType.ObjectName.XXX", number] where XXX is either Index for lists or Value for sliders.

### Updates

Every GUI object can be updated with Update[] gTable :

- Color (once per tick, works for every object)

    ```plaintext
    Update["Color", vector4] = vec(255, 255, 255, 255)
    Update["ColorObject", string] = "Button.Play"
    ```

- Text (several per tick, works for Button, Label and BigLabel)

    ```plaintext
    Update["Texts", array] = array("Stop", "Currently playing...")
    Update["TextObjects", array] = array("Button.Play", "Label.Title")
    ```

- List (once per tick, works for List)

    ```plaintext
    Update["List", array] = array("Cuban Music", "Belgian Music", "Epic Sax Guy")
    Update["ListObject", string] = "List.Songs"
    ```

- Slider (several per tick, works for Slider)

    ```plaintext
    Update["Sliders", array] = array(1, 100)
    Update["SliderObjects", array] = array("Slider.Volume", "Slider.Pitch")
    ```

The reason I didn't make a global "Object" variable is because you would not be able to update a list, sliders, texts and a color in one tick only.
Update[] arrays are automatically cleaned up when updating.
You can also reload the form as many times as you want.

### Notes

The E2 will likely use 4% ops when idle, and generally goes up to 40-50% when loading a form (during three ticks only). GUI["Ops", number] is set every tick to ops().  
The sample code uses 50 ops when idle. You can probably break up the E2 if you make a form too big filled with lot of 64-length labels, or updating an entire 4096-length big label.

- #### Advantages

    Simple to use, clean code, no any manipulation of coordinates or GPU's internal memory and I think grids are really useful and efficient. I first made it as a challenge, and because it was fun to make some library for other E2s, but I think this one could be used by several people who just want to make a GUI without touching either at GPU's assembly langage or EGP's functions.

- #### Inconvenients

    The big problem is lag occured when spawning the E2 (Topic), so apparently this won't get fixed until someone wants to.

- #### Notes on optimization

    I tried to use data signals to make E2 ops-free, and better coding (dsSendDirect("UpdateText", GGA, array("Button.Play", "Stop"))), but it randomly went into infinite loops of data signals then broke up the E2.  
    I also tried to make better updating functions but finally my code got screwed up, thanks to adv. dupe for giving me old working code.

<!-- ### Example : GUI Music Player

To show every object, a Music Players seems to be a good choice :
http://s2.noelshack.com/uploads/imag...tgrass0001.jpg
http://s2.noelshack.com/uploads/imag...tgrass0002.jpg
http://s2.noelshack.com/uploads/imag...tgrass0003.jpg
http://s2.noelshack.com/uploads/imag...tgrass0004.jpg
http://s2.noelshack.com/uploads/imag...tgrass0005.jpg
http://s2.noelshack.com/uploads/imag...tgrass0006.jpg
http://s2.noelshack.com/uploads/imag...tgrass0007.jpg -->

### Final thoughts

The Music Player and GPU GUI API's codes are attached here. Feel free to improve the code, and for thoses who are interested on how it works, the code is well-intended and commented. When Starfall processor become a reality, I plan to port the code to make a real library with real functions.

Music player E2 : gga_music_player.txt  
GPU GUI API : gpu_gui_api.txt  
Music Player Adv. Dupe : music_player.txt

Thanks to : multi-dimensional tables, global tables, E2 and Black Phoenix for his GPU.

<!-- https://web.archive.org/web/20160703112606/https://www.youtube.com/watch?v=kXF3O3ofFl4 -->