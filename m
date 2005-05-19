From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <Z8ORku99.1107424441.5406810.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rik,

> > Which version of "libsensors" (and lm_sensors) is this? "sensors -v" and
> > "ls -l /usr/lib/libsensor* /usr/local/lib/libsensor*" should tell. I
> > think that the error on VID is caused by an old version of the library.
> > For a 2.6.8 kernel, I think I remember you need at least lm_sensor 2.8.6
> > (libsensors 3.0.4). If Suse backported some patches to their kernel, you
> > might even need 2.8.8 (libsensors 3.0.6).
>
> Ahh... I think you've possibly just hit the nail squarely on the head --
> can you hear that?  That's the sound of me kicking myself, repeatedly.
> :-)
>
> wikkus@poochzilla:/etc> sensors -v
> sensors version 2.8.7 with libsensors version 2.8.7
>
> Sooo, I'm going to have to get down and dirty once more and do a little bit
> of compiling...

Well, for a 2.6.8 kernel, this should have worked. I have to suspect that
Suse backported some 2.6.9 i2c updates in their 2.6.8 kernel package.
Check for an lm_sensors package update. If they have none, you will have
to install your own from the sources, preferably after uninstalling the
Suse package so that the new sensors program doesn't accidentally link
with the old library.

> Good call, Jean. I checked what was being reported in the BIOS and was
> getting ~29?C for the CPU and typically 5 or so ?C less for the mobo.  I
> then went back into sensors.conf and tweaked a couple of things as
> suggested (temp1 to thermistor mode, temp2 to diode, ignore temp3) and got
> some more believable readings:
>
> M/B Temp:    +30?C  (high =    +0?C, hyst =    +0?C)   sensor = thermistor
> CPU Temp:  +25.0?C  (high =   +80?C, hyst =   +75?C)   sensor = PII/Celeron
> diode
>
> This is very positive stuff, although I think the labels for mobo and CPU
> need switching around.

I'm not sure. Typically, thermal diodes are built into CPUs, and
motherboard temperature uses a thermistor, just like you have for now.
Some hints to help you find out what is what exactly:
1* Typically, BIOSes present the values in the same order the sensors
program does.
2* Asus has some history of swapping temperature inputs on new board
(hardware) revision. This might add to confusion. Don't ask.
3* Don't expect the exact same CPU temperature values in BIOS and
sensors (see FAQ 4.12). Motherboad temperature should be the same though.
4* The best test is to heavy load the CPU (cpuburn or even "md5sum
/dev/zero" will do) and see which temperature increases more and
faster. That one is obviously the CPU's.

> Incidentally, I believe fan3 to be the PSU fan; still can't get anything
> from the CPU fan (it should be on fan0, as far as I can tell and is
> enabled with Asus' "Qcontrol" in BIOS), (...)

First, there is no fan0 - that would be fan1.

Try increasing fan2_div to 8 or more (see FAQ 4.1.1).

If the chip is programmed to control the fan speed through PWM, it can be
that the tachometer signal is then too low to be properly measured. If
this is the case, you might start seeing a correct value when the CPU
gets some load and the fan speed increases accordingly.

--
Jean Delvare
