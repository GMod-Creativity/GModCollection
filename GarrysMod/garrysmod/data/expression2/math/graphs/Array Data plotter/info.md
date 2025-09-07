# Expression 2 - Array Data plotter v1

## Details

### Author

- Author: Tolyzor
- Steam Profile: https://steamcommunity.com/profiles/76561197980070446
- Youtube: https://www.youtube.com/user/Heatseeker1
- Github: https://github.com/Tolyzor

### Publication Info

- Title: Re: EGP Graphing Calculator
- Date (dd-mm-yyyy): 10-09-2011
- Source: https://web.archive.org/web/20111225192520/http://www.wiremod.com/forum/expression-2-discussion-help/27380-egp-graphing-calculator.html#post244659
- Source Accessed (dd-mm-yyyy): 11-08-2025

## Description

To reduce lag, use egpPolyOutline. To draw a line with it, route the first and last vertices along on of the axis lines, and draw a line the same colour as the background over the connecting vertex. This also allows you to increase the detail of the line immensely. (your issue may be down to the egpLimit being used up by all those lines; egpPoly counts as just 1 object)

For example, this plots 2d data using egpPolyOutline:
(it also has auto axis scaling and modular size scaling controls that might be useful to you)
