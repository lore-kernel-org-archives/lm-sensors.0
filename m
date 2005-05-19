From: ondrej.cecak@centrum.cz (Ondrej Cecak)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: ne1619 (really solved)
Message-Id: <200307291959.07420.ondrej.cecak@centrum.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dne ?t 29. ?ervence 2003 14:57 jste napsal(a):
> > ACPI from current Marcelo's kernel (2.4.21) don't work, I'm curious to
> > new ACPI in kernel 2.4.x (maybe 22, but evidently 23) ...
>
> The ACPI support in 2.4.x is really thin so far, you really have to use
> the ACPI patch if you want real support:
> http://sourceforge.net/project/showfiles.php?group_id6832&release_id15
>34 That's what I use (well, the previous version actually) on my laptop.

OK, now I'am using apm with no problems. I give acpi some time ...

> > It works perfectly. Maybe I made mistake, becase ran gkrellm made Oops
> > ... I detected it after I mailed you.
>
> Oops are at kernel level, so if gkrellm made oops, it's likely to be
> because of one of our drivers... Let us know if it happens again.

now is everything all right. I can't reproduce it.

> > > The limits are still a bit too low, probably a common rounding
> > > issue, I'll take a look at it tomorrow (and probably ask you to test
> > > then, if you don't mind).
> >
> > with pleasure, but in Czech Republic is now 23:49 ;-))))
>
> Was the same here, Czech Republic and France are in the same time zone
>
> :)

I wasn't sure if you are really from France. Maybe you are with Linus Torvalds 
:o)

> OK, I updated the driver. I would like you to checkout from CVS this
> time (because more than just one file was changed). You don't have to
> checkout i2c (but you are welcome to do so if you wish, since some bugs
> were fixed since 2.8.0 was released). Don't forget to run "ldconfig"
> after installation of lm_sensors, since I bumped the library revision.
> Also, you will want to manually update the sensors.conf file (I added
> various comments to the adm1025 section).
>
> How to get CVS checkouts is described on our download page:
> http://secure.netroedge.com/~lm78/download.html#cvs
>
> If you can't use CVS for any reason, I can make a snapshot available to
> you as a simple tar.gz file.

It works perfectly. If you can see output, there is:

adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
+2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
VCore:     +1.46 V  (min =  +1.42 V, max =  +1.57 V)
+3.3V:     +3.33 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.03 V  (min =  +4.51 V, max =  +5.49 V)
+12V:      +0.00 V  (min = +10.81 V, max = +13.19 V)
VCC:       +3.27 V  (min =  +2.97 V, max =  +3.63 V)
SYS Temp:  +43.0?C  (min =   +5?C, max =  +65?C)
CPU Temp:  +43.0?C  (min =   +5?C, max =  +65?C)
vid:       +1.50 V

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (1)

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at efa0
Algorithm: Non-I2C SMBus adapter
Unknown EEPROM type (1)

> Thanks for testing! This is very very appreciated :)

you're welcome, but I have to thanks to all lm_sensors team - thanks a lot ...

-- 
Ondrej Cecak

