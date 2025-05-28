Author: shadowscion
Date: April 15, 2018
Title: <noTitle>

it's each type of tetris piece and all of their rotations
just thought it was cool that you could represent them with 16 bit numbers like that

User: Actually you need less than 16 bit, since tetris pieces are always 4 out of 16, so you can compress them really well, down to 11 bits (ceil(log2(bincoeff(16,4))))