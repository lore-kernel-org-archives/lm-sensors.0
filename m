From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: adm9240.c review
Message-Id: <20040812194946.721317b0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michiel,

Here are my comments about your Linux 2.6 port of the adm9420.c driver.

>     Copyright (c) 1999  Frodo Looijaard <frodol@dds.nl>
>     and Philip Edelbrock <phil@netroedge.com>
> 
>     Copyright (c) 2003 Michiel Rook <michiel@grendelproject.nl>    

Copyright is (C), not (c).

> /* Supports ADM9240, DS1780, and LM81. See doc/chips/adm9240 for details */

Drop the second part of the comment, since the mentioned file is not
part of the Linux kernel.

> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/proc_fs.h>
> #include <linux/ioport.h>
> #include <linux/sysctl.h>
> #include <linux/types.h>
> #include <linux/i2c.h>
> #include <linux/i2c-sensor.h>
> #include <linux/init.h>
> #include <asm/errno.h>
> #include <asm/io.h>

These are too many headers, you most certainly don't need all of them.
The follwing should be OK:
#include <linux/config.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/i2c-sensor.h>

> MODULE_LICENSE("GPL");

Please move this down to the bottom of the file (after the MODULE_AUTHOR
line).

> /* Many ADM9240 constants specified below */
> 
> #define ADM9240_REG_IN_MAX(nr) (0x2b + (nr) * 2)
> #define ADM9240_REG_IN_MIN(nr) (0x2c + (nr) * 2)
> #define ADM9240_REG_IN(nr) (0x20 + (nr))
> #define ADM9240_REG_FAN_MIN(nr) (ADM9240_REG_FAN1_MIN + nr)
> (...)

Please align all these defines using tabs.

> /* Scales for each voltage */
> int scales[6] = { 250, 270, 330, 500, 1200, 270 };
>    
> #define IN_TO_REG(val,nr) (SENSORS_LIMIT(((val) & 0xff),0,255))

This macro is broken. The "& ff" should be discarded.

> #define IN_FROM_REG(val,nr) (val * scales[nr] / 192)

Missing braces around "val".

> #define TEMP_FROM_REG(temp) \
>    ((temp)<256?((((temp)&0x1fe) >> 1) * 10)      + ((temp) & 1) * 5:  \
>                ((((temp)&0x1fe) >> 1) -255) * 10 - ((temp) & 1) * 5)  \

Could be simplified. "(A >> 1) * 10 + (A & 1) * 5" is nothing different
from "A * 5" as far as I can see.

> #define TEMP_LIMIT_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)

Shouldn't it be ">=0x80"?

> #define TEMP_LIMIT_TO_REG(val) SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
>                                                       ((val)+5)/10), \
>                                              0,255)

That one looks bogus. You cannot possibly set a negative limit, while
the test suggests it should be possible.

> /* Initial limits */
> #define ADM9240_INIT_IN_0 190
> #define ADM9240_INIT_IN_1 190
> #define ADM9240_INIT_IN_2 190
> #define ADM9240_INIT_IN_3 190
> #define ADM9240_INIT_IN_4 190
> #define ADM9240_INIT_IN_5 190
> (...)

Discard all of these constants, they aren't used anymore.

> static int adm9240_read_value(struct i2c_client *client, u8 register);
> static int adm9240_write_value(struct i2c_client *client, u8 register,
> 			       u8 value);

Rename "register" to "reg". "register" is a reserved keyword in C.

> static DEVICE_ATTR(temp1_hyst, S_IWUSR | S_IRUGO, show_temp_os_hyst, set_temp_os_hyst);

According to the sysfs interface standard, this file should be named
temp1_max_hyst.

> 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
> 	   at this moment; i2c_detect really won't call us. */
> #ifdef DEBUG
> 	if (i2c_is_isa_adapter(adapter)) {
> 		printk
> 		    ("adm9240.o: adm9240_detect called for an ISA bus adapter?!?\n");
> 		return 0;
> 	}
> #endif

You can discard this entirely, as it is redundant with the check right
below.

>       ERROR3:
>       ERROR1:
> 	kfree(new_client);
>       ERROR0:
> 	return err;

Drop label "ERROR3", since it is not used. Align other labels to the
left.

> static int adm9240_read_value(struct i2c_client *client, u8 reg)
> {
> 	return 0xFF & i2c_smbus_read_byte_data(client, reg);
> }

Discard that "0xFF &", it's dangerous.

> /* Called when we have found a new ADM9240. Sets limits, etc. */

Discard the second part of the comment, since we don't set limits
anymore.

> static void adm9240_init_client(struct i2c_client *client)
> {
> 	/* Reset */
> 	adm9240_write_value(client, ADM9240_REG_CONFIG, 0x80);
> 	
> 	/* Reset chassis intrusion pin */
> 	adm9240_write_value(client, ADM9240_REG_CONFIG, 0x40);
> 	
> 	/* Start monitoring */
> 	adm9240_write_value(client, ADM9240_REG_CONFIG, 0x01);
> }

These writes are kind of agressive. You don't want to unconditionally
reset the chip. I would remove the write. If you think it should be
kept, please make it a module parameter (named reset or init).
You should use read-modify-writes for the other ones, since you really
only want to change one bit each time. I also suspect that the last two
calls could be merged.

Additional comments:

1* The magnitudes for temperatures and voltages are not correct. As I
read your code, voltages are exported with 0.01V/bit, and temperatures
with 0.1dC/bit. Should be 0.001 for both (magnitude 3).

2* The vid value should be in a file named... well in1_ref or cpu0_vid,
we're discussing it at the moment. But not vid, for sure. The library
has "in1_ref" at the moment but it will most certainly be changed to
"cpu0_vid" in the few next days.

The rest looks acceptable to me at a quick glance. There are some things
that should be updated but the decision to change them occured after you
started your initial work, so I cannot blame you for not doing them, and
will take care of submitting a corrective patch at a later time.

Please submit a modified version of your ported driver taking all my
comments into account. The prefered form would be a patch against a
recent 2.6 kernel tree (2.6.8-rc4 would be fine), including changes to
drivers/i2c/chips/Makefile and drivers/i2c/chips/Kconfig.

What we really need you (Michiel and Bert) for is testing the new
driver. As I don't have any compatible chip for testing, I rely on you
to confirm that things work well. I'll rely on you too for my later
changes. Please test corner cases as well if possible (such as setting
unreasonable limits).

Phil, do you still have an ADM9240 chip available for testing?

There are a number of strange comments in both the driver and docs which
would need reviewing (such as fan clock divider presumably not working,
or voltage readings being broken).

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
