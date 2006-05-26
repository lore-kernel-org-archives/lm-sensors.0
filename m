From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 May 2006 10:22:44 +0000
Subject: [lm-sensors] decode-dimms.pl with kernel 2.6
Message-Id: <20060526122244.64b4c048.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gernot,

A long, long time ago (May 2004), Gernot Vormayr wrote:
> i'm using lm-sensors on my pc with a 2.6 kernel and it works great!
> great work!
> 
> well i wanted to figure out which ram i have in my computer and found 
> decode-dimms.pl... but this doesn't work with kernel 2.6 (it tries to reach 
> the eeprom data of the spd in /proc - in kernel 2.6 this is in /sys) so i dl 
> some jedec specifications and created my own program.
> i'm not so good at perl - so i tried to create one with C
> well it works fine for my DDR RAM and seems to display correct data.
> it is able to display information about SDRAM and DDR SDRAM.
> (information = nearly everything which is in the spd according to the JEDEC 
> specs)

For your information, our script now supports Linux 2.6 (since July
2006, lm_sensors 2.9.2). We also have DDR SDRAM (and DDR2 SDRAM)
support in lm_sensors CVS. It doesn't decode everything for these
memory types, but the more important characteristics are there.

> it's not very well formated at the moment and some comments wouldn't be bad 
> too. if u want to use this peace of code then i would reformat the source and 
> send this file to u. (and if u want reformat the output to a better form)

Well I think we'll stick to our perl script, it's easier for us to
maintain and probably for people to test too. And it works fine now, so
why change it? ;)

-- 
Jean Delvare

