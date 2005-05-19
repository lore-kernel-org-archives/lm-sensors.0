From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: [PATCH 2.6] I2C: lm87 driver ported to Linux 2.6
Message-Id: <9a9RaVcp.1098260789.8813930.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041007230420.448a438f.khali@linux-fr.org>
In-Reply-To: <20041007230420.448a438f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 19/10/2004, Jeff Oliver wrote:

>Do you guys want drivers for other i2c devices?  I have a driver that I
>was working on for Phillips PCA9555 i2c to gpio device.  So you think it
>would be something people would be interested in?

What kind of driver is it? The PCA9555 could possibly be used for SMBus
multiplexing, which we are precisely discussing these days. Or maybe
your driver simply offers a user-space interface to the GPIO pins?

>Also, I dont think that the version of the i2c eeprom driver had the
>code to allow writing to the eeprom.  I added to code for writing to the
>driver for my purposes.  Would anyone like that code?

The lack of write support is mainly a choice made a long time ago.
Messing with a memory module EEPROM can make it useless, and we didn't
want people to do that. What do you need this for? At any rate, I think
it would be safer if the write support wasn't usable by default. It
could be a module parameter, or an additional file in sysfs (e.g.
readonly, default to 1). Yet another approach would be to to try to
identify the kind of eeprom we are dealing with, and to disallow write
access in any case if the EEPROM is a memory module one.

Anyway, as Greg said, a loot at your code will still be interesting;
we'll see where we want to go then.


Thanks,
Jean
