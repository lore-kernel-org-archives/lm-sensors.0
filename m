From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: checksum in (i2c) eeprom driver
Message-Id: <2MANKxF6.1103102266.7579820.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041215005741.GB5489@jupiter.solarsys.private>
References: <lNsWdTVB.1102596784.6279250.khali@localhost>
In-Reply-To: <lNsWdTVB.1102596784.6279250.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mhoffman@lightlink.com
Cc: LM Sensors <sensors@Stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>


On 2004-15-12, Mark M. Hoffman wrote:

> In as much as eeprom is a demonstration driver, with very little actual
> usefulness except as a test device for us sensors people... I think it
> could probably be removed from the kernel altogether if we create a user-
> space (w/ i2c-dev interface) replacement for it.

As I already objected on IRC, I wonder how you would make concurent
accesses safe in this case. Using (continuous) byte reads is not safe in
this context, while it is the more performant read method among those
widely available (byte data reads are 50% slower, and i2c block read is
usually not supported by SMBus Masters.)

Of course we have potentially similar issues with other tools using
i2c-dev such as sensors-detect and i2cdump, but these tools are not
meant for daily use. Especially the latter is for
investigation/debugging purposes only. The former will not attempt to
identify devices already in use by a kernel driver. If we start using
i2c-dev for non-debug stuff, then sensors-detect becomes unsafe.

Think of the following scenario:
You read and/or write EEPROMs using your proposed i2c-dev-based tool,
using continuous byte read/write. At the same time, someone on the same
machine runs sensors-detect. sensors-detect will scan these EEPROMs at
some point, changing their internal address pointer, and as a
consequence possibly trashing the data read or written by your EEPROM
manipulation tool.

You may argue that it is unlikely that someone will run sensors-detect at
the same time he/she reprograms EEPROMs, but 1* you don't really know
what people do and 2* since people can technically to it, it better be
safe and 3* sensors-detect is soon to be part of a hotplug solution for
I2C/SMBus devices so it might be run anytime.

Summary: your proposal doesn't sound safe at all as long as there is no
possibility for i2c-dev to "request" an address for exclusive use like
kernel drivers can do. Looking at i2c-dev.h I see no such function at
the moment. There is also a permission issue because you need to have
write access to /dev/i2c-* even to only read from a chip (eeprom in this
case). Giving write access to tehse devices to everyone is of course not
safe, so your solution would only work for root, right?

Also, having an in-kernel i2c driver allows us to cache the data for some
times, which not only improves performance (the same could be done in
user-space) but prevents non-root users from saturating the SMBus.

> If read/write support is needed, IMHO it should be implemented as a proper
> char device.  The sysfs interface of the current driver makes little sense.

I don't really understand why exactly the sysfs interface isn't
correct. It does the job as far as I can see. Also think of devices that
have both an EEPROM and other functions (I remember one RTC chip like
that). They fit fine in our sysfs design (eeprom file for eeprom access,
other files for the other functions). Having a separate char device
would make things more difficult to understand. Just a thought though, I
am not opposed to the idea of a char device. If there are benefits, that
is.

> OTOH, note that it would be possible to break RAM modules *permanently* by
> misusing such a device.  The eeprom itself would still work, but the SIMM
> or DIMM that it sits on would be effectively broken.  I don't personally
> consider that a good argument against an eeprom char device, but some do.

You can also trash all your data if you play with, say, /dev/hda, and
losing personal data may be worth than losing a memory module. The
can-make-the-module-useless issue is to be considered but certainly not
a valid reason to never, ever have write support for EEPROMs. Note that
with the current implementation we could easily have a module parameter
for explicitely enabling write support (that might not be the best
solution though).

About "trashed" memory modules, I now wonder... OK, the system will not
recognize the module anymore, but if there is anotgher working module in
the machine, I'd expect it to still boot, then the EEPROM should still
be visible on the I2C bus and could be reprogrammed, no? Or if the
system checks and stops booting on bad modules, maybe hotplugging it at
a later time would do it? I'm not willing to sacrifice a memory module
of mine just to do the test, but I wonder if either of these techniques
would work.

Back to the original topic... Your ideas about a new way to access the
EEPROMs is interesting but are hardly related to my original question of
whether I can remove the checksumming code from the existing driver or
not. I will continue to maintain this driver as long as no other
alternative is proposed, accepted, implemented and tested.

Thanks,
--
Jean Delvare
