From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors program library problems (more info)
Message-Id: <1058803366.16893.15.camel@farrell.freemans.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1058790834.16392.3.camel@farrell.freemans.org>
In-Reply-To: <1058790834.16392.3.camel@farrell.freemans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thank you, thank you...so soo much!! wooho!

one question tho, but this has to do with reasonable voltage levels, and
termperatures, not lm_sensors/i2c...

in the past two years i have gone threw 2 amd cpu's...first i had a
boxed amd athlon 1.4ghz...using its amd-provided heatsink and fan. temps
measured fine afaik...and about a year later my pc started
freezing...repleaced the cpu and all was well again :) i replaced it
with a "bare" amd duron 1ghz cpu, (but re-used the hs/fan from the
1.4ghz cpu) as it was all i could afford at that time. that 1ghz cpu did
the same freezing thing a month ago... 7 months after i bought it. so i
found the recpit and exchaged for it another, as it was still under
warrenty. they didnt have anymore 1ghz cpu...so i got an amd athlon
thoroughbred 2000+ (1.667GHz!! :) thats what im using now. my stepfather
said it might be my power supply unit being somewhat faulty and possibly
causeing harm to the cpu (perhaps shocking it, or depriving it of
electricity??). but i would be somewhat surprised, as i have an Antec
powersupply--a well know, well respected case and power supply maker.
but i suppose every product has a few defectives sold.

this is why i badly wanted to get lm_sensors/i2c working...

now "sensors" shows me this:

[root@farrell root]# sensors -f
eeprom-i2c-0-50
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM SPD
Memory size (MB):       512
 
w83697hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore:     +1.60 V  (min =  +1.71 V, max =  +1.88 V)
+3.3V:     +3.29 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.91 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.01 V  (min = +10.79 V, max = +13.19 V)
-12V:     -12.29 V  (min = -13.21 V, max = -10.90 V)
-5V:       -5.20 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.53 V  (min =  +4.72 V, max =  +5.24 V)
VBat:      +3.12 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     6958 RPM  (min = 3000 RPM, div = 2)
fan2:     2766 RPM  (min = 3000 RPM, div = 2)
temp1:       +95?F  (limit = +140?F)                       sensor thermistor
          
temp2:     +94.1?F  (limit = +140?F, hysteresis = +122?F) sensor thermistor
         
alarms:
beep_enable:
          Sound alarm disabled
 
[root@farrell root]#

if the min/max value it shows are what the voltage show be between... it
would seem my VCore and +3.3volt are a little wrong. both a little too
low. do you know if the difference is big enough to cause problems?

lastly, but also important, the temperatures. "+95?F" why the "?", is
that an estimate... does it need to be calibrated? im not too worried
about it as i hear cpus should be able to handle 110F (44C) alright--but
of couse its not good to stress-test them! :) but i have a copper
heatsink with that nice loud 7000RPM fan on it...so i think i will be ok

anyway, i know that except for the temp's "?", none of this has to do
with your program, but i figured you guys would be the people to ask.
sorry if im jsut continuing to bother you guys.

i would like to thank you guys, you have been very helpful...not to
mention quick to respond! i REALLY appriciate it!

thanks again,

farrell f.

On Mon, 2003-07-21 at 06:10, Jean Delvare wrote:
> > after thinking a little, i thought perhaps it was a problem with my
> > PATH variable... so:
> > 
> > [upgrdman@farrell upgrdman]$ sensors
> > sensors: error while loading shared libraries: libsensors.so.2: cannot
> > open shared object file: No such file or directory
> > [upgrdman@farrell upgrdman]$ su -c updatedb
> > Password:
> > [upgrdman@farrell upgrdman]$ locate libsensors.so.2
> > /usr/local/lib/libsensors.so.2.0.0
> > /usr/local/lib/libsensors.so.2
> > /home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2.0.0
> > /home/upgrdman/lm_sensors-2.8.0/lib/libsensors.so.2
> > [upgrdman@farrell upgrdman]$ echo $PATH
> > /usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin
> > [upgrdman@farrell upgrdman]$ export PATH=$PATH:/usr/local/lib
> > [upgrdman@farrell upgrdman]$ echo $PATH
> > /usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/upgrdman/bin:/usr/l
> > ocal/lib[upgrdman@farrell upgrdman]$ sensors
> > sensors: error while loading shared libraries: libsensors.so.2: cannot
> > open shared object file: No such file or directory
> > (...)
> > still no success :(
> 
> You were close, but did something wrong. PATH is for binaries, not libs.
> (You should have noticed that all the other strings in PATH end with
> /bin, not /lib.)
> 
> The /usr/local/lib directory is probably not used by your system, we
> have to teach it it should ;) As root, edit /etc/ls.so.conf and add one
> line that says: "/usr/local/lib". Save, quit and run "ldconfig". Now
> sensors should work.
> 
> BTW, lm_sensors's "make install" should have detected this, and has
> probably warned you, and told you to just what I told you to do. Didn't
> you pay attention at that time?
