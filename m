From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009
Message-Id: <20031104225918.36ff35ea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013205850.GA2164@frodo.local>
In-Reply-To: <20031013205850.GA2164@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> There are some interesting news:
> I can load i2c-i810 driver but only DDC (what's that?) can be
> initialized.

This is a protocol that allows one to retrieve a monitor's capabilities.
We have a module (ddcmon) that handles it rather well (if you have
lm_sensors 2.8.1) and a perl script that can convert this information
into something XFree86 can read in its configuration.

That said, I'm surprised. I'd have expected the Chrontel to be on that
(video) i2c bus, not on the other one.


> Your script detected a i2c-i801 which has some devices
> attached to its bus.
> 
> Output of sensors-detect looks like this below. I kicked out all lines
> which failed. Can you please help me interpret this? Does this mean,
> that there are 8 devices connected to this bus? 0x00, 0x08, 0x30, 0x44
> and 0x69 are unknown so one of thouse can be my video codec? How can I
> identify which device it is? I have a paper about chrontel 7009 chip
> with all register adresses but it don't seem to contain something like
> an identifier.
> 
> Client found at address 0x00

General call address. I don't know exactly how it works, but I can tell
for sure it's not a regular device.

> Client found at address 0x08

This address is called "SMB host" in my docs. Don't know what it means
either, but I'd guess it's not a regular device (and it's probably
linked with whatever appears at 0x00).

> Client found at address 0x2e
> Probing for `National Semiconductor LM80'... Success!
>     (confidence 3, driver `lm80')
> Client found at address 0x2f
> Probing for `National Semiconductor LM80'... Success!
>     (confidence 3, driver `lm80')

The LM80 is hard to detect, so it might not be LM80's. Load lm80, run
sensors (and sensors -s before that) and see if the values make sense.

> Client found at address 0x30

A shadow image of the EEPROM at 0x50, which you can safely ignore.

> Client found at address 0x44

Might be what you're after.

> Client found at address 0x50
> Probing for `Serial EEPROM'... Success!
>     (confidence 8, driver `eeprom')

EEPROM as found on your first memory module.

> Client found at address 0x69

Clock device, dangerous and uninteresting playing with. Forget about it.

Use i2cdump on the unknown address, this will help us identify the chip
there:
i2cdump 1 0x44 b
(assuming the i2c-i801 has bus id 1). You can also try the same on 0x2e
and 0x2f if the lm80 module did not give good results.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
