- Author: FlakAttack
- Date: 08-15-2014
- Title: E2 Hologram Copier

## E2 Hologram Copier

A friend of mine requested a hands-on way to make easy holos for decorative pieces on his vehicles. The UI and chat driven systems are nice but were taking too long for his needs. Basically the chip makes a collection of all the entities parented to it, along with their location, angle, color, and material. It then prints out a full program into console that can be dropped onto the original E2 which recreates the parented props as holos and parents them to the chip.

Instructions:
Paste this chip on the vehicle and place all the props you want as holos where you want them. Constraint and parent all these props to this chip. Type "/print holos" (no quotes) in chat. This will output a complete program into console. Copy from "@name Holos" to the last curly brace "}" and paste this code over the existing E2. Then just remove the props and enjoy the holos!

Known problems:

-If the code that prints out is missing things you parented you may have to reset the chip. Just use the E2 tool (left-click) on the chip again to reset it. This happens a lot whenever getConstraints is involved.
