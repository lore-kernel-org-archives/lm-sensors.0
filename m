From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031118221007.1b4807b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a problem with the w83781d module. It used to work just fine in
> version 2.6.1 on a 2.4.18 kernel, but just hangs the complete system
> with sensors 2.8.1 with a 2.4.21 kernel.

From what you say below, I don't think the w83781d module is the
problem. I'd rather say that the i2c-piix4 module is.

I'm not particularly experimented with bus drivers, but I'll try to
help.

> 5. Doing a 'modprobe i2c-piix4' generates the following kernel log
> messages:
>    i2c-core.o: i2c core module version 2.8.1 (20031005)
>    i2c-piix4.o version 2.8.1 (20031005)
>    Found ServerWorks OSB4 South Bridge device
>    dmi_scan.o version 2.8.1 (20031005)
>    dmi_scan.o: SM BIOS found
>    Worked around buggy BIOS (I2C)

That last message looks interesting. I would edit i2c-piix4.c in your
2.8.1 sources and disable that workaround. Could be that on your system,
the workaround does more harm than help. Or it might be worse, I dunno
;)

> 8. 'i2cdetect 0' generates (2.4.18 kernel with i2c-piix4 from 2.6.1
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX 03 XX XX XX XX XX XX XX XX 0c 0d 0e 0f
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX 2f
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX UU UU XX XX XX XX XX XX
> 50: XX XX XX XX 54 55 56 57 XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

What you have at 0x54-0x57 are likely to be eeproms. Usually they start
at 0x50, not 0x54. It happens that a special model of these eeproms,
starting at 0x54, are know to be possibly corrupted by older versions of
lm_sensors. So I recommend that you do *not* load the eeprom module with
your 2.6.1 module set. I might be paranoid - actually there are great
chances that what you have here are not the faulty eeproms, but who
knows. Version 2.8.1 should not have that problem.

You might have an additional monitoring chipset at 0x2f. Didn't
sensors-detect tell you what it is? You might send us the output of
"i2cdump 0 0x2f" (with version 2.6.1 of course) if you want us to take a
look.

Another thing you might want to try is an intermediate version such as
2.7.0. I don't have anything special in mind, but that might help us
narrowing the problem if we don't have any other ideas.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
