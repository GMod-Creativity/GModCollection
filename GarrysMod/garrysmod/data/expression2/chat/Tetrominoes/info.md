# Expression 2 - Tetrominoes

## Details

### Author

- Author: Shadowscion
- Steam Profile: https://steamcommunity.com/profiles/76561198001319717
- Github: https://github.com/shadowscion
- YouTube: https://www.youtube.com/@shadowscion

### Publication Info

- Date (dd-mm-yyyy): 15-08-2018
- Title: Tetrominoes
- Source: Wiremod Discord: Contraptions Archived
- Source Accessed (dd-mm-yyyy): 07-08-2025

## Description

**shadowscion:**  
it's each type of tetris piece and all of their rotations

just thought it was cool that you could represent them with 16 bit numbers like that

i gave up on making holo tetris though

it's so much easier with a render context rather than having to keep track of everything

**gohidas:**  
Actually you need less than 16 bit, since tetris pieces are always 4 out of 16, so you can compress them really well, down to 11 bits (ceil(log2(bincoeff(16,4))))
