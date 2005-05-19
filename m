From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: SMBus I801: Can't open /dev/i2c-2
Message-Id: <1079354589.4055a4ddf1b0d@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079342270.1650.182683010@webmail.messagingengine.com>
In-Reply-To: <1079342270.1650.182683010@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting James A Hunsaker IV <james-hunsaker@uiowa.edu>:

> I'm emailing this because the support systems gives *no*
> acknowledgement that it received it.

In fact I don't see any ticket from you in our base, so it must have
failed for some reason (thus the lack of acknowledgement). Not a big
problem though; this list is a correct place to ask for support too.

> Next adapter: SMBus I801 adapter at 0540 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Can't open /dev/i2c-2
> 
> I searched but cannot find why i2c-2 does not exist (despite
> sensors-detect expecting it to).

I guess that you have i2c-0 and i2c-1, and your distribution assumes it
should be enough for most people, but it isn't for you.

There is a script coming with lm_sensors that will create these device
files: prog/mkdev/mkdev.sh.

Or you can just create the missing device file:
mknod -m 600 /dev/i2c-2 c 89 2

> PS Why does it say "confidence 1, driver `eeprom'" and then not
> include "modprobe eeprom" in the script?  When I modprobe it, I do
> get valid entries when running "sensors".

Because the ddcmon is prefered (confidence 8) over the eeprom driver for
this kind of eeproms (EDID eeproms present in your monitor, providing
timing information to the video adapter).

It is correct that the eeprom driver can be used too, with the
prog/eeprom/decode-edid.pl script. But using the ddcmon driver together
with the sensors program is usually easier and provides information you
are more likely to be interested in (the eeprom+script combo is meant
to add extra video modes to your XFree86 configuration file, not to
provide user-friendly information).

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
