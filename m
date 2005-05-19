From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228100403.79a1a2c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I just ported monddc from 2.4 to 2.6 and I attached the source. It
> implemented a few DDC decodings but to implement them all you need to
> add about thirty attributes.

Ehe, I was thinking of doing the same. Just that the sysfs interface
change that I have been working on these days postponed it. My comments
on your code below.

> I'm trying to figure out if a generic DDC module can probe for older
> DDC monitors. The radeon framebuffer driver (2.6,
> drivers/video/aty/radeon_i2c.c) contains the following code for
> discovering old DDC chips. 
> 
> I see that I can replace the probe function in the monddc driver with
> this probe function. But I don't know enough about DDC and I2C to
> really under what it's trying to do to the I2C bus. Can this probe
> function be turned into a generic form where it uses something like
> i2c_smbus_xfer() instead of directly playing with the bus ioports?

In fact I don't think you can do anything at all at the chip driver
level. I guess that the strange procedure in radeonfb_i2c.c is there to
"activate" the DDC eeprom, i.e. make it appear on the bus. As long as
nothing appears on the bus, the chip driver's detect function won't be
called at all! This is due to the i2c subsystem architecture we have in
the Linux kernel. So you cannot hope to be able to reproduce the trick
in the chip driver. It belongs to the bus driver (unless we change the
architecture).

That said, there are not that many bus drivers for DDC. There must be 6
or 7. What's more, two of them (radeonfb and matroxfb) do need the DDC
information for themselves, so they *have* to do the trick themselves
anyway.

> Does anyone have one of these old monitors that needs this probe?

I don't think I do (anymore). The older monitor I have here does already
support DDC without the particular probe.

> I'd like to build one universal DDC module instead of reimplementing
> this in every video driver.

Noble intention, but sadly not achievable if I understand it correctly.

To your code now:

 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
+obj-$(CONFIG_SENSORS_DDCMON)	+= ddcmon.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o

Respect the alphabetical order please.

+    Copyright (c) 1998, 1999, 2000  Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>,
+    and Mark Studebaker <mdsxyz123@yahoo.com>

Which version of the driver have you been starting from? In the more
recent ones, my name should be there too. So I guess you have based your
work on an old version, which is no good :(

+#include <linux/module.h>
+#include <linux/version.h>

You don't need that one, do you?

+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c.h>

And including this one twice doesn't give you any extra points ;)

+#include <linux/i2c-sensor.h>
+#include <linux/init.h>

Oh, BTW, please see the other drivers (e.g. lm83) for the prefered
inclusion order.

+#define LM_VERSION "1.0"
+#define LM_DATE "2/26/04"

We don't want to use such defines in the 2.6 kernel versions of the i2c
drivers.

+/* DDCMON registers */
+#define DDCMON_REG_ID 0x08
+#define DDCMON_REG_SERIAL 0x0C

Please align the values, using tabs (tabstop=8).

+	unsigned long last_updated;	/* In jiffies */
+
+};

No empty line here.

+	.owner		= THIS_MODULE,
+	.name		= "monitor_ddc",

Correct name is "ddcmon". Quoting the porting guide (which BTW you did
not use?): "all lowercase, as simple as the driver name itself".

More general comments now:

1* Sysfs files should only contain one single value. Multivalue files
are not allowed.

2* You seem to export almost all values as hexadecimal. Decimal is
prefered.

3* Sysfs file names should be all lowercase (so "ID" is not OK). BTW,
the whole interface names choice should be discussed on this list. We
try to establish a common standard for all drivers. Since the ddcmon
driver isn't a hardware monitor driver, it's obviously less important,
but still worth discussing. For example, it would be better if the
eeprom, ddcmon and bt869 drivers were to use a common naming scheme.

If you're interested in having a ddcmon driver in Linux 2.6 soon and
want to help, here is the proposed plan:

1* List the values we want to export to sysfs. The latest lm_sensors
ddcmon driver should be used as the base. Discuss the names here.

2* Update your code so as to take my comments above into account, and
make it comply with the interface decided in step 1.

3* Test and send to Greg KH.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
