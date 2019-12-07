==============================
 INDEX OF README FOR MASE:BC2
==============================
A. INSTALLATION
B. F.A.Q.
C. KNOWN BUGS
D. SOURCE CODE
E. CHANGELOG
F. CREDITS



=================
 A. INSTALLATION
=================

1. Requirements:
----------------
Windows: ensure that you have the Microsoft Visual C++ 2010 SP1 Redistributable Package installed (download link: http://www.microsoft.com/en-us/download/details.aspx?id=8328)
Linux: additional requirements may vary on the distribution you are using so I can't give any general advice here (worked out of the box on Ubuntu 12.04.5 32-bit)

Also I only support legit Client files that are patched up to the latest patch R11 (download link: http://www.gamefront.com/files/20808336/Battlefield__Bad_Company_2_Client_Patch_R11), anything below, modified or "cracked" is unsupported
Regarding the Server files, the only ones that got tested were the R25, R30, R32 and R34 versions (unmodified), anything other may work but is unsupported
Any existing modifications to the client/server (like the Nexus hook) are also not supported and will probably not work.


2. Setup of the emulator:
-------------------------
Setup is pretty straightforward, ensure that the required ports are open (see F.A.Q.), write the IP (or hostname) of the PC where the emulator will be hosted in the config.ini to the key 'emulator_ip' (overwrite "REPLACE_ME") and save it

Windows: Start the mase_bc2.exe, now Clients and Servers should be able to connect
Linux: 
a) If you are in a desktop environment:
Simply double clicking the "mase_bc2" would launch the emulator in background so you can't really see whats happening
To "properly" launch the emulator, start up a terminal and do b)

b) If you are in the console/terminal:
Change the current directory to the one where the file "mase_bc2" is located (which should be in the "linux" folder), then launch the emulator with "./mase_bc2"
If you launch the emulator from somewhere else, it assumes that all the required files are in the directory where you are now (and if they don't exist, it'll try to create them there), so make sure you are in the right directory

If the emulator fails to start for some reason it should give some kind of error message which you can either send to me or (preferably) try to solve it yourself since they are in most cases pretty self-explanatory
Should you get something like "Access to a socket failed due to restricted access rights" ensure that the required ports are open and try to set 'http_enabled' to 'false' in the config.ini if it isn't already
Should you get something like "Error: resolve: No such file or directory" ensure that the hostname you specified in the config.ini is correct and reachable


3. Setup for connecting Clients/Servers:
----------------------------------------
There are 2 different methods you can choose from to set them up:

a) Using the dinput8.dll hook which comes with this emulator:
Simply put the "bfbc2.ini" and "dinput8.dll" files from the 'dll' folder in the root directory of the Client/Server (where the executable is located) and replace "REPLACE_ME" in the bfbc2.ini where the host key is to the IP of the PC where the emulator is hosted

b) Manually modifying the binaries and redirect the IP's over the hosts file:
First remove the SLL verification of the executable by using the lame patcher tool (http://aluigi.altervista.org/mytoolz/lpatch.zip) with the fesl patch (http://aluigi.altervista.org/patches/fesl.lpatch)
Then append these lines to your hosts file of the System, usually loacated in "C:\Windows\System32\drivers\etc\" for Windows:
 # redirect client ip's
 xxx bfbc2-pc.fesl.ea.com
 xxx bfbc2-pc.theater.ea.com
 # redirect server ip's
 xxx bfbc2-pc-server.fesl.ea.com
 xxx bfbc2-pc-server.theater.ea.com
 # optional
 xxx easo.ea.com

Where 'xxx' stands for the IP of the PC that hosts the emulator.


4. Connect to the Emulator:
---------------------------
If you did all the above steps correctly, the Server should be able to connect flawlessly once you start its executable and should show up in the Client's server list after a few seconds
In the Client you should be able to login and create an account (nothing shorter than 3 characters and longer than 32 for user name or 16 characters for persona name)



=====================================
 B. F.A.Q. (only for latest version)
=====================================

[Q] The Client still wants me to enter a serial number, what should I do?
[A] That means you are still connected to EA and not the emulator so you probably did something wrong when installing the hook
If you are using my hook, check if you pasted the dinput8.dll in the correct directory (the same where the BFBC2Game.exe is), if the key "host" in the bfbc2.ini has a correct IP and connect_to_retail is set to 0

[Q] What ports do I need to enable on my firewall/router for the emulator to work?
[A] You will need to open the TCP ports 18390, 18399, 19021 and 19026 (optionally 9946 but not required)

[Q] How do I unlock everything for my persona?
[A] Simply create your account/persona, logout and replace the newly created .cfg file of your persona in the database folder of the emulator with the "stats_unlocked" file in the templates folder of the emulator
This will unlock everything for that persona except SPECACT player models, the M1 Garand and the Vietnam expansion. To unlock those too you have to close the emulator and set "all_are_veteran", "vietnam_for_all" and "specact_for_all" to "true" in the config.ini (only global unlock possible for those)

[Q] How do I unlock everything for everyone?
[A] Set "all_stats_unlocked" to "true" in the config.ini and all newly created personas will have every weapon unlocked except SPECACT player models, the M1 Garand and the Vietnam expansion.
To unlock those too you have to close the emulator and set "all_are_veteran", "vietnam_for_all" and "specact_for_all" to "true" in the config.ini (only global unlock possible for those)

[Q] How do I enable "Remember Password"/"Auto-Login" in the client for my account?
[A] "Remember Password" works out of the box (except in the "Create Account" window, its just useless there), just enter a valid account name and password, select the "Remember Password" box, click "Login" and login with a persona (you must fully login, otherwise it won't be saved)
"Auto-Login" requires you to first login with the "Remember Password" box checked BUT NOT the "Auto-Login" box selected. When you are logged in, log out do the login again BUT this time SELECT the "Auto-Login" box
Once you are logged in and want to quit the game, DO NOT hit the "Logout" button (otherwise the Client won't save the setting), just click directly on "Exit Game" (the whole "Auto-Login" process happens strictly within the Client so no chance for a patch or a fix unless DICE does it)

[Q] The Server still connects to EA (and not to the emulator) even though I properly set up the dinput8.dll hook of yours, whats the problem?
[A] First check if you pasted the dinput8.dll in the correct directory (the same where the Frost.Game.Main_Win32_Final.exe is), if the key "host" in the bfbc2.ini has a correct IP and connect_to_retail is set to 0
Then make sure that the server is started without parameters like "-feslhost xxx" or "-theaterhost xxx", those will overwrite the IP of the hook! These parameters could be included in some .bat file you are using to launch the server or in the Win32Game.cfg of the server directory, 
just remove them if they are there

[Q] How do I enable logging for the game server/emulator?
[A] For the game server you simply have to start it up with the parameter "-plasmaServerLog 1"
For the emulator you have to set "log_create = true" and "file_log_level = 3" (optionally "display_database_table_info = true") in the config.ini of the emulator
When you are done with logging close the game server/emulator and you will find a new .log file in their directories which you can investigate or send to me

[Q] The Client won't let me create a new User/Persona, what is the problem?
[A] Be sure to use a user name (and password!) that consists of at least 3 characters and that there are no special characters in the name (including space)
Also the User name shouldn't be longer than 32 characters and the Persona name not longer than 16 characters

[Q] What IP do I need to set for the 'emulator_ip'/'host' in the config.ini/bfbc2.ini?
[A] The network IP of the server where you want your emulator to run, for example you want to run it on your PC which has the IP 192.168.0.3 in the LAN network, 
you put it in the option for the emulator (config.ini) and others will be able to connect
As for the connecting clients (bfbc2.ini) you have to put in again the IP where the emulator runs, for the above example this would be again 192.168.0.3 (note that the clients must be in the same network and that every client who wants to connect to the emulator must have this IP)

[Q] Will the emulator automatically apply the options if they are changed in the config.ini or do I have to restart the emulator for that?
[A] Unfortunately you'll have to restart the emulator for that, dynamic changes were never planned and could be difficult to implement

[Q] How do I transfer users/personas from a previous version or the windows/linux version of mase_bc2?
[A] The files are compatible since the first public release of the beta so you just have to copy&paste the "database" folder from the old emulator directory to the new one
If you want to move the users/personas from Windows to Linux or vice versa you just have to resave all the files in the "database" folder with the proper line endings ("carriage return+line feed" for Windows, "line feed" for Linux)

[Q] What do the different colors in the console mean (assuming they are enabled)?
[A] They stand for the different types of connections and places where the message came from so you can easily differentiate between them,
red background means it's a warning or an error (but thats included in the message anyway for the logfile), here is the complete list for reference:
Grey:		Debug (this means it's something local, mostly config, file creation/deletion and initialization stuff)
White:		Database stuff (information about what happens in the database)
Green:		Game Servers (theaterhost)
Turquoise:	Game Servers (feslhost)
Pink:		Game Client (theaterhost)
Yellow: 	Game Client (feslhost)
Aqua:		HTTP requests (coming only from the Game Client)
Ocher:		Game Client (miscellaneous stuff from the Game Client)
Red: 		Some unknown stuff, this should actually never occur in normal use (the font is black here if it is displayed as a warning)

[Q] The there are too many messages appearing in the window, can I somehow reduce this but still know whats going on?
[A] You can limit the character length of one message by setting the according option in the config.ini and/or you can change the message levels,
I recommend the warning levels to be set to 2 and generally the file notifications and warnings one level higher as the console,
all lower level messages are included in the higher levels so you don't need to worry about missing something,
generally the warning/notification levels are set up like this:
0 = basically only initialization message is shown
1 = mostly only messages about connecting clients and servers are displayed, I recommend to use this for normal use if you dont try to debug anything
2 = all the moreless important packets are displayed, in and outgoing so this is a good thing if you only want to check traffic
3 = basically all database and http related things are displayed here, this is best for debugging

[Q] Why is http disabled in the config.ini and bfbc2.ini and what advantage does it have to enable it?
[A] On some systems the access to the http socket is not possible (at least not without changing some other settings) so the emulator might not intialize correctly (or at all) with http enabled
You can try out if it works on your system though, simply set "http_enabled" to "true" in the config.ini and start the emulator, if no warnings appear you are fine
If you are able to run the emulator with http enabled all Clients that are connection to the emulator can enable their "RerouteHttp" option in the bfbc2cfg.ini (on Servers this is not used)
Doing so might lead to faster login times and a custom main menu message (totally worth it :p ) which is located in ".\mase_bc2\templates\game"
However if you don't have http enabled on the emulator but on the connecting Client you will probably experience an extremely long login time so I don't recommend to do this



===============
 C. KNOWN BUGS
===============

[B] Friend system does not work
[A] This hasn't been implemented (and probably never will be from me because it's not worth spending time on)

[B] Server queuing does not work
[A] This hasn't been implemented (properly) since the required packets could not be logged

[B] Global ranks does not work
[A] Same thing as Friend system

[B] Punkbuster enabled server doesn't show up as enabled in the server list (not really a bug since its intended)
[A] I permanently disabled Punkbuster to show up in the list, otherwise players who have Punkbuster disabled wouldn't be able to join ranked servers

[B] Unable to use character 'x' in user/persona name but it works on EA's server
[A] I did specify some forbidden characters to avoid problems with the file saving

[B] I still get connected to EA in the Client and the Hook recognizes the Client as a Server (check with setting "show_console=1" in the bfbc2.ini and look at the output in the cmd window)
[A] That might be the case for Steam or Origin versions, you can override automatic detection by setting "executable_type=client" or "executable_type=0" in the bfbc2.ini, then it should work (assuming you really have the latest version)



================
 E. SOURCE CODE
================

Requirements:
-------------
- Visual Studio 2010 or higher (Windows), gcc 4.7 or higher (Linux)
- Boost C++ libraries v1.54.0 (you might have build them with the parameter "cxxflags=-std=gnu++11" in Linux to avoid some linking issues with boost::filesystem)
- OpenSSL v1.0.1j
(newer versions might work too but the ones listed here were used to build the latest version of the emulator)

Usage:
------
- Project files are included with the source files in the "src" folder 
- [Windows] mase_bc2.sln/.vcxproj/.vcxproj.filters for VS2010
- [Linux] mase_bc2.cbp for C::B (should also be possible to generate a makefile from it)
- To be able to properly build it you'll need to change the Include and Linker directories in the project settings first, replace all occurrences of "$(BOOST_1_54_DIR)" and "$(OPEN_SSL_DIR)" with the locations where you installed these libraries

Final Notes:
------------
I have written ~95% of the code myself (regarding the source files that I included here, code from the external libraries doesn't count of course), the rest I either copied 1:1 or just slightly modified it for my needs.
The according code sections in the files are:
- base64 de/encryption (in Base64.cpp/h, credits for the original author are included in the .cpp file)
- Packet de/encryption and SSL certificate information (in SSL_cert.h and TcpConnections(SSL).cpp), I originally took it from the v10.0 emulator source from Domo/Freaky123 but I it seems they took it from aluigi's EAList tool (http://aluigi.altervista.org/papers/ealist.zip), so I guess credits go to him?
- Http server code, mostly taken from the boost::asio example page (http://www.boost.org/doc/libs/1_54_0/doc/html/boost_asio/examples/cpp11_examples.html), only dumped it down and slightly modified it for my needs

Also I would like to mention that when I wrote this project, I was rather new to coding bigger stuff in general (though it certainly was a great experience for me) and I would probably do quite a few things differently nowadays if I had the time and motivation to do it.
So if you consider any of the code that I have written as bad/terrible regarding performance/structure/functioning then feel free to change anything you want or if thats too much work for you, just don't use the entire emulator and look for a different solution (I'm not forcing you to use it).
With that being said though, if you do change something in the code and release it somewhere, I would very much appreciate it if you would at least credit me for my work :)

Last but not least, you may be wondering why I didn't include the source code for the hook.
The answer is simply because I don't think anything new would come out of it, the already implemented features should be more than enough to play around with and as far as I can tell there should be no bugs left (that could be fixed in the hook).
But if you are concerned about there being some "malicious" code in it, I can only assure you that the code is free from such things.
And if you don't believe me feel free not to use it, the hook is just meant as a bonus anyway and you can always do the required modifications yourself to redirect the game client/server to the emulator (as described in section A, point 3, b)



==============
 D. CHANGELOG
==============

### Beta 0.9

[ADD] source code for the emulator which you can find in the 'src' directory, I probably won't continue working on it so feel free to mess around with it
[ADD] missing signal handler for Linux version (forgot to add it when I went through porting the required code)
[ADD] ranking_min_players, unlimited_ammo and health_mode options to the hook
[FIXED] problem with the signal handler for Windows version (would not exit on first Ctrl+C and crash on doing it a second time)
[CHANGED] from OpenSSL 1.0.1e to 1.0.1j (too lazy to update boost libraries as well)
[CHANGED] logbuffer size to 8192 (which basically means bigger packets will be cut off in the log but I decided its better than having a giant buffer for just a few messages to be displayed entirely)
[REMOVED] automatic creation of a default bfbc2/config.ini for the hook/emulator if if there is no file with such a name in the same directory (not sure why I thought this was a good idea in the first place, its just taking up space in the compiled library/executable)


### Beta 0.8

[ADD] Linux 32-bit version (can't guarantee that it works as good as the Windows version though)
[ADD] some code improvements in the hook and support for another version of the client than the patched retail (see Known Bugs if it still doesn't work)
[ADD] simple IP filter to differentiate between public and private IP's and pass them properly in the packets
[ADD] theoretical support for specifying hostnames instead of IP's in the config.ini (practically no testing was done)
[ADD] Display the number of current connections in the window title (Windows only since there is no similar solution possible in Linux)
[FIXED] socket on misc_port not working correctly
[REMOVED] Server limit and Client limit (though I can't tell at which point the emulator might get unstable since no testing has been done in that direction so if you are planning to connect a lot of Clients/Servers to the emulator you do this at your own risk)
[REMOVED] Age restriction in the Client when creating a new account


### Beta 0.7

[ADD] "Remember Password" and "Auto Login" features (see F.A.Q. for more details)
[ADD] automatic creation of a default bfbc2.ini for the hook if there is no file with such a name in the same directory
[ADD] "all_stats_unlocked" in the config.ini which (if enabled) toggles to a stats_unlocked template file that has the necessary values to unlock every weapon for a newly created persona (this replaces the previous global_template feature)
[FIXED] ports in "ECHO" packet being constant
[FIXED] some wrong content in the "NuLookupUserInfo" packet when the user was not found
[FIXED] Client login problems that some users experienced who previously played on Nexus's server
[FIXED] a major bug in the Stats system which would cause the emulator to stop displaying any messages and ultimatively not to respond to incoming connections any more
[FIXED] a bug in the config reading of the hook which would lead to incorrect values for the hook to use
[CHANGED] from OpenSSL 1.0.1c to 1.0.1e, from boost version 1.51 to 1.54 and replaced some standard library functions with the ones from boost
[CHANGED] some keynames in the config.ini, removed a few unimportant keys and made sure the emulator wont start up until the IP is set
[CHANGED] the filename "bfbc2cfg.ini" to just "bfbc2.ini" (the old file is obsolete and can be deleted if you use the newer hook) and made sure the user will be notified if no IP is set (users can still use the old hook if they prefer it for some reason)


### Beta 0.6

[ADD] customizable TOS which is stored in ".\templates\termsOfService" (original TOS is in termsOfService_orig, to use it replace the files)
[ADD] dinput8.dll for the Client and Servers which makes the hosts and lpatch modifications obsolete, 
this file is NOT required by the emulator and must be put into the client/server root directory to make use of it,
root directory is where the "BFBC2Game.exe"/"Frost.Game.Main_Win32_Final.exe" is located, see F.A.Q. section for more info
[ADD] check if the required subdirectories of the emulator ('database' and 'templates') are present
[ADD] check if the user who wants to delete a persona really is the owner of that persona
[FIXED] a possible ID mess up when removing personas
[FIXED] Server disconnect when something was written in chat with "ProfanityFilter enabled"
[FIXED] issue where the emulator would think the name length was out of boundaries if special characters were used and the name length was within the boundaries
[CHANGED] database saving method, temporary files will not be deleted if something goes wrong when loading/saving and now the .lst files are constantly updated (instead of .tmp)
[CHANGED] the UpdateStats method, not found values will no longer be written to "ignoredKeys" file (since they are all only used for webstats), 
perhaps they will be included in the stats template in future versions (if there is demand for it)
[CHANGED] config.ini options, added "window_buffer_size" which sets a fixed maximum for lines displayed in the console (dynamic is still possible), 
removed "theater_server_ip" and "theater_server_ip" since "emulator_ip" can easily be used instead and if misc_port is set to 0 the whole socket will be disabled
[CHANGED] Punkbuster filter settings, the emulator will never flag as "Punkbuster enabled" even if it is enabled, furthermore the according filter on the Client will be ignored,
this is done because the dinput8.dll will permanently disable Punkbuster on the Client and on the Server anyway so there is no sense in supporting it
[RELEASE] all versions from here on will be publicly released on private-servers.info and youtube.com


### Beta 0.5
	
[ADD] http protocol support for the emulator (plus an "http_enabled" option to turn the socket on/off)
[ADD] missing packet responds for bfbc2.gos, easo.ea.com and an additional connection
[ADD] "misc_port", "http_enabled" and "http_updater_respond" options to config.ini, check the comments of the options for more info about them
[ADD] "game", "version" and "installerConfig" files to templates folder, they are only accessed during http requests
[FIXED] a crash that could occur when a persona was created
[FIXED] once again possible memory leaks, improved critical sections and performance in some parts
[CHANGED] database saving method, now changes of personas/users are automatically updated in external temporary files which replace the original files on quit, 
previously changes were only applied on the original files on quit, however changes to these files while the emulator is running are not applied (and should not be done)
[CHANGED] user/persona name length boundaries to (min=3 and max=32)/(min=3 and max=20)
[CHANGED] maximum allowed client connections to 64
[RELEASE] Closed Beta release on private-servers.info


### Beta 0.4

[ADD] "Play Now" feature (it says "Connection lost" when there are no servers found but thats not the case and can be ignored)
[ADD] "display_database_table_info" option to config.ini which makes it easier to read database related stuff (use this only for debugging purposes)
[FIXED] some possible memory leaks and improved a few code sections
[FIXED] a weird bug where the client would endlessly request GetRankedStatsForOwners packets (for some reason I didn't notice that before)
[FIXED] warning message that would occur when a special UpdateStats packet from the server is being received
[FIXED] crash that would occur when the emulator tries to send something to the database after being connected 8+ hours without traffic
[FIXED] problem with some special characters in server names/descriptions, now all the characters that work on EA should also work here
[CHANGED] the database, completely removed everything MySQL related and replaced it with a self-written piece of code, 
this might not be more efficient for big datasets but should be for small ones (also this fixed the above mentioned database related bugs),
note that when database entries are displayed on the console they are not affected by "message_cut_off_length"
[CHANGED] the server limit from 2 to 4
[RELEASE] Closed Beta release on private-servers.info

### Beta 0.3

[ADD] account registration for new users is now entirely possible from the client (like it's normally done, except serial request)
[ADD] credits for the emulator (they are displayed instead of EA's license agreement when a user wants to create an account :p )
[ADD] automatic creation of the MySQL database if the specified database name is not found (the specified user must have the necessary rights to do this!)
[ADD] server queues where a client would be put in a queue when the server is full, however this feature is EXPERMIENTAL, I couldn't test it yet
[ADD] options "emulator_ip", "use_global_server_version" and "enable_server_filters" to the config.ini
[ADD] server filtering when a client searches for servers (all options should be working as intended)
[ADD] connection count limit for clients and server for security reasons, 
if testing goes well and people don't bitch too much about it then I will increase this limit in future versions
[FIXED] connection/packet problems when two clients would join the same server almost at the same time (finally!), now the emulator should be able to handle this stuff,
I couldn't try that with more people though (limited resources) but it should also work
[FIXED] not setting servers/clients to 'online=0' in the database that were still connected when quitting the emulator (this is a hacked fix, I hope to do it properly later...)
[CHANGED] MySQL database structure, also renamed many columns to give them a more suitable name
[RELEASE] Closed Beta release on private-servers.info


### Beta 0.2

[ADD] automatic base64 de/encoding of packets that are larger than the maximum packet data, the encoded data gets partitioned and can be safely sent/recieved, 
this was previously done manually (and the stats got collected a little faster that way) but since some packets are variable in size it's better this way
[ADD] Stats updating, this is still WIP though (and it requires the client to be connected to a ranked server)
[ADD] Dogtags saving in persona specific '.dog' files, this is also WIP
[ADD] "countryList" file in "templates" folder where all the available countries are specified when one wants to create a new account,
structure is like this: 'ISO_Code'='Country Name'
[ADD] "ignoredKeys" file in "templates" folder where all the keys get stored that are not client relevant (these are only useful for webstats)
[ADD] '[connection]' section to config.ini where one can specify the ports on which the emulator is listening for incoming connections and the according ip's that are being sent
[ADD] '[emulator]' section to config.ini where one can specify options that affect all clients that are connecting to the masterserver
[ADD] KICK packet when client leaves a server (the process seemed to work fine without that but it appears always in the official backend logs...)
[ADD] various safety checks when a client logs in and proper responses for each one (does the account exist, is the password correct, is nobody logged in with that account, etc),
this will also prevent that users can login with the server accounts (this is not even done on EA's server o.O), there are also checks when creating a persona
[FIXED] and improved the the server status update packets, players on the server are now shown correctly when players join or leave the game
[FIXED] a rare packet counter mixup that would occur when a client joins a server (and would deny him to join)


### Beta 0.1

[STATUS] rewrote the source code from scratch, only the SSL certificate, packet header encoding/decoding and base64 code remain untouched,
Packet class has a much better performance, Stats are more reliable and the overall stability has much improved (especially when (multiple) Clients are joining a Server)
[ADD] Ping and Memcheck mechanism for both Clients and Servers and for each of their connections (Theater and Plasma, Memcheck only for Plasma)
[ADD] colors to the console to differentiate between client and servers and plasma and theater of each one (see F.A.Q section for color reference)
[FIXED] some important packets that had the wrong content in it and sometimes caused unexpected results (crashes, disconnections, etc)
[FIXED] the log file writing, now it is not only much more reliable but also it should be guaranteed that everything gets written into the file before a quit/crash
[FIXED] the structure of the data that gets sent to the client/(game)server, it is now exactly like EA's packet structure
[CHANGED] the speration of theater and plasma in two different executables, now everything is in one executable,
this might not be a good way to deal with many Client and Server connections but is certainly easier to use for LAN games (which I am aiming for with this project)
[CHANGED] the number version of a connecting server is now a fixed version and not the real one (this ensures that every connected server is visible for all clients)
[CHANGED] the location of the "templates.txt" stats file into an own "templates" folder (renamed to "stats")
[CHANGED] the config.ini (adjusted to the rewritten source) and redid the whole reading/saving code for it as well (more reliable now)
[CHANGED] the GUI, mouse icon, exectuable icon and the Listbox for message logging are removed (that was just fancy stuff), everything is now displayed in console only


### Alpha 0.0.9

[ADD] Database update of the user/server whether he is online or not (if a server is not online he doesn't get listed in the server list)
[ADD] Specact and Vietnam DLC entitlements for all users, 
one can now view and play with Specact weapons in main menu and change to vietnam mode to join a server which runs in vietnam mode
[ADD] automatic creation of a default theater/plasma config.ini if it cannot be found (only MySQL information has to be manually inserted)
[FIXED] Stats are being sent correctly to the game server, they are not updated when a client leaves though


### Alpha 0.0.8

[ADD] successful connection from client to server!! It's even stable until client disconnects or map is changed (client remains connected to server though),
stats are not loaded yet to server so the stats are temporarily saved on server (you start from zero everytime), works yet only on localhost though
[ADD] a few events of the server are now updated (in database and therefore also on client) when anything changes (server on/offline, player joined/disconnected)
[FIXED] Server listing bug that wouldn't show any servers when user searches a second time and would also cause connection problems
[FIXED] again a problem where the emulator would answer to the wrong packets
[FIXED] a MySQL query crash that would come up when the server is not listed in database - he is now correctly added
[CHANGED] some packet responds of theater and plasma to work better and respond more appropriate
[RELEASE] Public release on thedefaced.net/private-servers.info, both Source Code and compiled binaries


### Alpha 0.0.7

[FIXED] Stats getting, the client now successfully gets all the stats from the emulator! :D
[FIXED] a bug where the emulator would answer to the wrong packets if he sends linked packets
[CHANGED] to a new base64 de-/encryption method, old one included strange newlines in the data that made it difficult to calculate size of encoded data
[CHANGED] again the Stats collecting method, it's now almost instant (on a decent PC) ;)
[CHANGED] Stats persona stats storing method while client is connected, 
they should be loaded now for every new client that connects and not eventually overwrite old ones (still need to try though)


### Alpha 0.0.6

[FIXED] small bug that wouldn't return the right stats value from the persona stats file
[FIXED] automatic timeout of connected client after some time  (disconnected due lack of activity)
[FIXED] a few console log bugs
[FIXED] Stats decoding method, now all of the recieving data is decoded properly
[CHANGED] Stats collecting method, it is now a lot more efficient
[CHANGED] Stats getting and saving method from the persona file, it hopefully works better and faster now


### Alpha 0.0.5

[ADD] Error messages for various events where the emulator would have crashed before without any indication what happened
[ADD] Font quality option "font_quality", look in the FAQ for the different options
[ADD] Option "message_cut_off_length" to absolutely set the message length to be displayed in the console, put -1 for no limit and 0 for empty lines,
useful for very long strings that would cause a nasty flickering (and perhaps perfomance issues?)
[ADD] an "About" MessageBox :p
[FIXED] Some eventual memory allocation problems
[CHANGED] restructured the packet recieving code of Plasma, it checks now first for packet type then TXN (if it exists)


### Alpha 0.0.4

[ADD] Option "file_create" for not creating a logfile
[ADD] Option "message_limit_length" to limit length of debug messages, put 0 for no limit (not recommended, messages over limit might not show up),
recommandable values are between 1000 and 3500 for default font (Tahoma, 14)
[FIXED] Heavy CPU usage of Theater after Server login
[FIXED] Annoying random crash on startup of Plasma (hopefully)
[FIXED] Some Bugs that came up with the GUI
[CHANGED] format of the debug output strings to fit for the listbox window (also server orientated)


### Alpha 0.0.3

[ADD] Icon (modified original :p ) and Bfbc2 cursor
[ADD] Font options "font_name", "font_size", "font_italic", "font_underlined", "font_striked" in config (only ANSI_CHARSET fonts are allowed)
[ADD] Changelog and version numbering
[FIXED] Small bugfixes here and there
[FIXED] Heavy CPU usage in idle - Windows handles this for us now
[CHANGED] Console window to a GUI window (style is server orientated ;) )
[CHANGED] removed unnecessary column in the database that was used by the emulator


### Alpha 0.0.2

[ADD] Game Server can connect to Emulator
[ADD] Multiple users can connect to Emulator
[ADD] Server is shown in Client server list (when Server is listed as online in database)
[ADD] Server details are also showing up in server list (though not every detail yet)


### Alpha 0.0.1

[ADD] Persona adding/removing
[FIXED] Login moreless (no Stats loading yet)
[FIXED] a few other client sided events
[STATUS] running again
[CHANGED] Switched to a local file saving for stats of the Personas
[RELEASE] inofficial release on battlefieldemulator.net


### Pre-Alpha 10.0

[STATUS] Not running but Base code is available (CPacket/CSocket/Threads/etc)
[RELEASE] Public release on sourceforge.net (by Freaky123 and Domo)



============
 E. CREDITS
============
Developers (Emulator+Hook):
- Triver

Packet Logging and Server stuff:
- Triver
- Rodney (after Alpha 0.8)
- bcool (up to Alpha 0.8)

Beta Testers:
- Rodney
- Jack
- Michl2007
- Happy Chicken

Special Thanks:
- Domo and Freaky123 (for sharing the Server Files and the v10.0 source code)
- Aluigi (for the tools that made it possible to view and record the BF:BC2 network traffic)
- DICE (for making the game)
