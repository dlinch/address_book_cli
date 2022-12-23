# Address Book CLI

## Goal

I have never written a CLI before, so I wanted some practice. I remember a friend using the OptionsParser library a long time ago, so I found an excuse to use it. I had a little fun passing procs around, as closures are also something I've been thinking about lately.

I drew inspiration when my wife asked me for family members' addresses and I realized I kept looking them up in random text messages from across the years and I realized there had to be a better way.

### Implementation

The CLI runs by simply calling `bin/cli` with various options. This is nothing fancy, just some built in shell magic. Placing the magic shell comment sets the environment to ruby so the system knows how to execute it. I know all iOS systems have a version of ruby installed, but this may not work in all systems.

OptionsParser pulls in various options, which I'll detail more below, and uses them to check against a JSON file to return addresses. I do some mild validation, and I left room for more validaiton if I felt like it. Right now it checks that you pass either name or address, but not both.

### Options

- `-a --address [ADDRESS]` Pulls in an address to check against the file
- `-n --name [NAME]` Pulls in a name to check against the file
- `-r --regexp` Makes the search fuzzy using regex rather than an exact match lookup
- `-h --help` Prints out these options
