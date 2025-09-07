# Expression 2 - CommandLib

## Details

### Author

- Author: Filipe

### Publication Info

- Title: Re: Official WIP Thread - What are you working on?
- Date (dd-mm-yyyy): 04-02-2012
- Source: https://web.archive.org/web/20121113114618/http://www.wiremod.com/forum/finished-contraptions/28120-official-wip-thread-what-you-working-2.html
- Source Accessed (dd-mm-yyyy): 23-08-2025

## Description

Not a WAYWO, it's actually finished

I don't know if I'm using the local keyword correctly, haven't looked into the documentation yet, but here's hoping.

Usage:

```
    Command = readCommand("my_command 'arg1' arg2 'arg3 with spaces',10,20,30, 'escaped\' quote character'")
```

Return value:

```
    :table->
    command:string = "my_command",
    args:table->
        1:string = "arg1",
        2:string = "arg2",
        3:string = "arg3 with spaces",
        4:string = "10",
        5:string = "20",
        6:string = "30",
        7:string = "escaped quote character"
```

Barely tested at all, pretty fast and bare-bones, should be useful if you're making extensive use of chat commands, enjoy.
