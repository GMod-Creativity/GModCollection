- Author: THE MINGEBAGS ARE COMIN
- Steam Profile: https://steamcommunity.com/profiles/76561198061916037

- Title: [E2] Anti workshop dupesteal
- Date (dd-mm-yyyy): 02-01-2015
- Source: https://web.archive.org/web/20150315025918/http://www.wiremod.com:80/forum/finished-contraptions/33872-e2-anti-workshop-dupesteal.html
- Source Accessed (dd-mm-yyyy): 09-08-2025

## [E2] Anti workshop dupesteal

If you've ever browsed the workshop dupes, you know it's a mess. The dupes are either stolen or useless one-entity dupes such as weapons from an addon you probably don't even have. This E2 aims to eliminate the stolen wiremod dupes by preventing skids from taking the credit for your work. Important note:
This only works with servers that have wiremod

It's only useful for protecting wire dupes.

Usage:
1. Create your wiremod dupe
2. Paste the E2 on it
3. Upload it to the workshop

After the E2 is placed, whoever uses it gets a message (customizable).
When someone re-uploads it to the workshop and someone falls for it, they get a message that the dupe they tried to place is stolen and they should contact the original author (automatically inserted).
If the original author places his dupe, the E2 will selfdestruct, allowing them to make edits and upload an improved version.

The reason this works is when the E2 is reset (that includes remoteSetCode), it's no longer considered dupe. So by using this trick, I was able to make it detect how many times it has been duped and make it self-destruct on the 2nd dupe.
