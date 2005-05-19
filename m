From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] Port of w83627hf to kernel 2.6
Message-Id: <20040218042450.GD21829@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
In-Reply-To: <000801c3f596$0f1ffd00$0300a8c0@berninoti>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bernhard:

* Bernhard C. Schrenk <clemy@clemy.org> [2004-02-17 21:38:53 +0100]:
> I have ported the w83627hf module to the 2.6 kernel. I hope it's useful for
> you. The patch is against linux kernel 2.6.3-rc4. I have tested it with a
> w83627thf chip on an Asus P4P800 motherboard.

Great, this is something I wanted to do but I've been wicked busy...

The 2.4 driver in CVS was updated to include support for w83637hf.  You
should consider including that.  You should consider the other changes
from r1.12 to r1.13 as well (pwm, etc).

> #define TEMP_MIN (-1280)
> #define TEMP_MAX ( 1270)
> 
> /* TEMP: 1/10 degrees C (-128C to +127C)
> REG: 1C/bit, two's complement */
> static u8 TEMP_TO_REG(int temp)
> {
>         int ntemp = SENSORS_LIMIT(temp, TEMP_MIN, TEMP_MAX);
>         ntemp += (ntemp<0 ? -5 : 5);
>         return (u8)(ntemp / 10);
> }
                                                                                
The 1/10 degrees C representation makes no sense for a 2.6 driver.
Let's try to keep all the conversions in one place.  Take a  look
at the 2.6 version of asb100.c for a better example.

> /* TEMP: 0.1C/bit (-55C to +125C)
>    REG: (0.5C/bit, two's complement) << 7 */
> static inline u16 LM75_TEMP_TO_REG(int temp)

Definitely don't do this.  The correct definition is in lm75.h.
Again, an example is asb100.c.

> /* There are some complications in a module like this. First off, W83781D chips

Can you please just strike this whole comment... it's obviously
cut and paste from another driver and doesn't even make much
sense for this one... all w836xxxx are accessed by ISA only!
I'll yank it out of our CVS too.

There are many lines which are more than 80 columns, please fix.

> sysfs_fan_offset(1);
> sysfs_fan_min_offset(1);

These macro invocations which define functions should not get 
semicolons at the end...

> #define device_create_file_vid(client) \
> device_create_file(&client->dev, &dev_attr_vid);

.. neither should these.  I know it's pedantic, and most of the
other 2.6 drivers violate it too.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
