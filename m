From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: DS1621 support for kernel 2.6 (new patch)
Message-Id: <20040310232748.0dc9dbea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040306213810.GA14805@pc.aurel32.private>
In-Reply-To: <20040306213810.GA14805@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

Sorry for the delay. See my comments inline.


+/* Supports DS1621. See doc/chips/ds1621 for details */

That comment doesn't make sense here, since doc/chips/ds1621 is not part
of the Linux 2.6 tree.

+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>

See lm83.c (for example) for the prefered include order). Also, standard
debugging stuff is missing here (see lm83.c too).

+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(ds1621);
+
+/* Many DS1621 constants specified below */
+
+/* Config register used for detection         */
+/*  7    6    5    4    3    2    1    0      */
+/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */

Please merge these comments into a single one.

+#define DS1621_REG_CONFIG_MASK 		0x0C
+#define DS1621_REG_CONFIG_VAL 		0x08
+#define DS1621_REG_CONFIG_POLARITY 	0x02
+#define DS1621_REG_CONFIG_1SHOT 	0x01
+#define DS1621_REG_CONFIG_DONE 		0x80

Please use tabs and *only* tabs for alignements. In your patch, all
constants seem to have a trailing white space before aligning tabs.

+#define TEMP_FROM_REG(val) ((((val & 0x7fff) >> 7) * 500) | \
+                            ((val & 0x8000)?-256:0))
+#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val<0 ? (0x200+((val)/500))<<7 : \
+                                          (((val) + 2) / 5) << 7),0,0xffff))

I think that the defines in lm75.h would do the same, more cleanly.

+#define ALARMS_FROM_REG(val) (!(!((val) & \
+                              (DS1621_ALARM_TEMP_HIGH | DS1621_ALARM_TEMP_LOW))))

The double negation makes this macro hardly readble. Care to
reformulate?

+#define ITEMP_FROM_REG(val) (((((val & 0x7fff) >> 8)) | \
+                            ((val & 0x8000)?-256:0)) * 100)

This one looks wrong. I'd say *1000, not *100. Anyway, this macro is
used only to feed data->temp_int, which is never used as far as I can
see. Looks like all this stuff is useless...Same for temp_counter and
temp_slope?

As a more general advice, I'd suggest that you simplify the driver as
much as possible. The DS1621 seems to be a really simple chip and I can
hardly believe that the driver would be so big.

For example, I wonder why the "continuous" parameter should be
configurable. All drivers work in continuous mode by default. Polarity
should be left unchanged. Chip should not need to be restarted. The "I
screw up the chip once" comment is a developper issue. Regular users
have no way (hopefully) to screw up anything, so this parameter is
likely to be useless.

I'll have to read the DS1621 (and possibly DS1625) datasheet to make
sure I understand correctly how the chip(s) work, but I expect us to be
able to simplify the driver much.

Thanks for you work. Please tell me how you do feel about my comments
and suggestion, so that we can go on with this port.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
