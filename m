From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030715193709.63e85632.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> Like I said, I used lm_sensors-2.7.0 pcf8574.c as a template. There it
> is still included :-)

Just checked and it isn't. You must have been using an old file, as you
said below.

> > 2* According to the datasheet, the SAA1064 has four possible I2C
> > addresses, ranging from 0x38 to 0x3b. So, you will want to replace:
> >
> > [...]
> >
> 
> Done.

You should modify your "detection" procedure in the same way. Actually,
I don't think you did it the right way at all. The "kind" parameter is
set according to the force options that are passed to the module as you
load it. kind < 0 means no force parameter was set (default). kind = 0
means force, but no particular chip, kind > 0 means force a given kind
of chip. Since there is only one chip in your driver, = 0 and > 0 are
all the same. What's more, you don't have to take the address into
account. You won't be called for an address you don't like unless the
force parameter is used. And if it is used, you have to trust it. So you
should have the following detection procedure:

kind < 0: set kind to saa1064, try to detect the chip (see below)
kind >= 0: set kind to saa1064, don't try to detect the chip

As you noticed, the saa1064 doesn't really want to be detected. However,
I still think there are things we can check:
1* The MSB of the control register has to be zero.
2* Registers 0x05 to 0x07 should be set to 0x00 (unless we can't read
from them).
3* Registers should cycle over 8-byte boundaries.

Unfortunately, this couldn't be confirmed by i2cdump. I'd like you to
insist, this would really help. Maybe the chip doesn't like the was
i2cdump reads it. You still could try adding these checks in your driver
code (for kind < 0) and see if the module still loads. Another
possibility is to add detection to sensors-detect (what I could do.)

> it's the first time I'm doing things in kernel space (and I'm having a
> good time *g*).

Same for me a few weeks ago. And it feels great actually, isn't it? :)

> Yup :-) Works very fine, here. On startup, everything lights up (maybe
> I should put "init" on, instead?), then I disable the testmode,
> everything gets dark, and I can program the digits...

No, keep it this way. Setting every led on is a good practice, it lets
the user check that no led is dead.

> Another small thing (@all *g*):
> Most of your modules lack the #ifdef MODULE...#endif construct usually
> embracing init_module and cleanup_module. That prevents most of these
> to run smoothly compiled into the kernel. Is this a bug or a feature?

Bug, definitely. I noticed this too, because I didn't do so in my own
driver... I'll check every driver tomorrow. Anyway, drivers that get
mkpatched must be OK, or I guess someone would have noticed, by the
time...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
