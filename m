From: g.vormayr@aon.at (Gernot Vormayr)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: decode-dimms.pl with kernel 2.6
Message-Id: <200405280322.16103.g.vormayr@aon.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi!

i'm using lm-sensors on my pc with a 2.6 kernel and it works great!
great work!

well i wanted to figure out which ram i have in my computer and found 
decode-dimms.pl... but this doesn't work with kernel 2.6 (it tries to reach 
the eeprom data of the spd in /proc - in kernel 2.6 this is in /sys) so i dl 
some jedec specifications and created my own program.
i'm not so good at perl - so i tried to create one with C
well it works fine for my DDR RAM and seems to display correct data.
it is able to display information about SDRAM and DDR SDRAM.
(information = nearly everything which is in the spd according to the JEDEC 
specs)

it's not very well formated at the moment and some comments wouldn't be bad 
too. if u want to use this peace of code then i would reformat the source and 
send this file to u. (and if u want reformat the output to a better form)

the source -> http://members.aon.at/vormayr/spd.c.bz2
it uses just linux standard libraries and headers
gcc spd.c

just call the program and it displays information about every spd found

gernot vormayr
