From: rem@planet-d.net (=?ISO-8859-1?Q?R=E9mi_H=E9rilier?=)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: strange crash
Message-Id: <3E525BED.8050600@planet-d.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello.

I wanted to test lm_sensors last day, but 4-5 hours later after reboot, 
I have had a big problem :
my system didn't want to allocate memory. But it's better to start with 
the beginning.

My system is a Athlon 1500+ on a Matsonic MS8137C (a KT266 mainboard), 
ie a VT8366
northbridge (in dmesg's output, bttv modules reports it's a VT8367) and 
a VT8233 southbridge.
I have 256 Mo of DDR266 SDRAM and ATA33/66 hard-disks and a cdwriter 
configured with
scsi emulation. I have a Pinnacle PCTV Rave (BT848) TV card (which uses 
i2c too).

I have installed the Slackware 9.0 beta from the 10 January 2003 a week 
ago. It contains a 2.4.19
kernel. My linux box was up 14 hours per day without any problems.

ACPI is enabled but apm too (to use "use real mode apm bios call to 
power off").
then acpi is not used.

Last sunday, I have would to test lm_sensors (2.7.0), I took a 2.4.20 
kernel from ftp.kernel.org
and its relative patches from lm_sensors homepage. I applied them with 
"patch -p1 < xxxxx.patch"
(it can be my first mistake because I have had hunk warning with 
2.4.20.i2c-2-patch but there were
no .rej file, I assumed there was no error).

I enabled directly in my kernel :
    - i2c support
    - i2c bit banging interfaces (I already need it for my TV card).
    - i2c device interface (always for my TV card)
    - i2c /proc interface

and as modules:
    - i2c-viapro (it includes KT266)
    - i2c-isa ( for IT87)
    - it87 (sensors-detect returns me "ITE IT8705F / IT8712F / SiS 950")

I personally have others modules (which are loaded in this order) for:
    - sound card and joystick:
        - gameport
        - es1370 (for a SB PCI 64) with as parameter : joystick=1
        - grip (for a gravis gamepad pro)
        - analog (for an old joystick)

    - TV card (to set extra parameters)
        - tuner (with "tuner=3")
        - tvaudio
        - bttv (with "card9 tuner=3 radio=0")

sensors modules were loaded after them, in this order (I don't think 
order affects anything but we never know :)
    - i2c-viapro
    - i2c-isa
    - it87

after compilation and reboot (with no warning or such messages), I have 
compiled and installed
lm_sensors programs. I launched sensors to see.

it87 "subsystem" reports me a negative temperature for temp2 whereas 
i2c-isa system report a positive
(and correct) temperature for temp2 (which seems to be my cpu 
temperature). after few minutes, temp3
reports me correct value for cpu temperature (sometimes, it was equal to 
temp1 for a quick time). Fan
rotation speed were correct in i2c-isa and 2 times slower in it87 output.

I have compiled and ran GKrellM to have these information on my screen 
and I start again working on my
programs (it is surely useless, but it's opengl work), maybe 2 or 3 hours.

At 20h, i go to eat and come back at 21h. Few time later, i would to 
open a xterm and nothing happens.
already launched program starts without any problems but never lanched 
programs "crash" (because I
had no error message like segfault). Nothing seems to be freezed.

I quit X and try to do something but always the same problem (and no 
possibility of calling 'sync'
on my disks). I could not do a 'su' or log me on other terminal. I 
decide then to reboot and my system
stops at "killall stage" and stayed freezed. during halt call, I have 
had a message saying "can't allocate
memory". After a hardware reboot, no more hard drive partition table (2 
hours later I again had them :-)

I know it could come from anything else, but it's the only thing I add 
to my kernel since one week.

I hope there are not too many fault :-/
You can naturally contact me if there is something you don't understand :-)

see you soon ;-)

Rem

