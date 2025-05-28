Author: gohidas (adosikas)
Date: June 6, 2019
Title: E2 AES-128

AES-128 encryption in E2, uses around 9k ops for an encryption with key generation. A bunch less if you have a static key that doesn't change every time
AES-256 and decryption is pretty much the same so shouldn't be too hard. AES-GCM is a bit harder.
But you can now do actually military grade and state-of-the-art encryption in E2 (apart from side channel attacks ie watching the power trace of the cpu or whatever spectre bullshit)