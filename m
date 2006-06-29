From: dynmail1@gassner-waagen.at (Michael Burian)
Date: Thu, 29 Jun 2006 09:43:14 +0000
Subject: [lm-sensors] RTC + DS1337
Message-Id: <44A3A0B2.7080705@gassner-waagen.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A37C0E.3090604@laposte.net>
In-Reply-To: <44A37C0E.3090604@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Matthieu TORRES wrote:
>=20
> - the option "Enhanced Real Time Clock Support" (config RTC)  does not=20
> provide generic access to a RTC chip via /dev/rtc as I belevied. The=20
> access to the chip in driver/char/rtc.c are made with CMOS_READ() and=20
> CMOS_WRITE(),  defined in Linux/include/asm-arm/mc146818rtc.h. It is a=20
> combination of outb_p() and inb_p() : no chance to access my I2C chip=20
> that way...
> So I added ioct() support in /drivers/i2c/chips/ds1337.c.
>=20

I remember having fixed that the same way some time ago - but people
told me that I shouldn't add that code to ds1337.c and to look for a
"generic way" instead.

As I haven't found a better way yet, I decided to write some glue code
(drivers/char/ds1337glue.c) till the issue can be resolved.

http://www.kernel.org/git/?p=3Dlinux/kernel/git/mburian/linux-2.6-ep93xx.gi=
t;a=3Dblob;h=C7d168b7ea488676106a363311dc6119e61519a2;hb=E16e2f3f0a126eccf4=
7d4d338b3b1a9281b7cd87;f=3Ddrivers/char/ds1337glue.c

I doubt that this will be acceptable for mainline, so I'm still waiting
for somebody (Jean?) to show me the "one true way" to get /dev/rtc
access for that chip.

> - the driver (/drivers/i2c/chips/ds1337.c) has two problems (I'm not=20
> sure it is bugs, but at least on my system it does not work).
> First, ds1337_detect() reads some values in the chip registers that are=20
> assumed to be wrong, but in my chip they do exist (I swear I have a=20
> DS1339). I commented out these checks.
> Then, the part that enables the RTC after first power up in=20
> ds1337_init_client() fails to write a status bit in the chip, so we fall =

> into the same reset code (that writes zeros in the RTC regs) after each=20
> reboot.
> I corrected this and that's OK for me.
>=20
> I can post code if it is usefull for someone.

I've already sent a patch that should fix this in February :(
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015369.html

I'm sending a "re-diffed against 2.6.17" version of that patch that,
please review and test.

To Matthieu: If your fix looks completely different, is better, ... or
you'd just like to discuss it, please show us your version.

I can live with whatever i2c folks here prefer, as long as it fixes the
problem.

This patch no longer overwrites the the complete RTC in case it detects
inconsistencies - instead it does just what's absolutely necessary to
enable userspace to fix the problem.


--- linux-2.6.17.old/drivers/i2c/chips/ds1337.c 2006-06-18
03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/i2c/chips/ds1337.c     2006-06-29
10:49:48.000000000 +0200
@@ -337,38 +337,36 @@ exit:

 static void ds1337_init_client(struct i2c_client *client)
 {
+       s32 val;
        u8 status, control;

        /* On some boards, the RTC isn't configured by boot firmware.
         * Handle that case by starting/configuring the RTC now.
         */
-       status =3D i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
        control =3D i2c_smbus_read_byte_data(client, DS1337_REG_CONTROL);
-
-       if ((status & 0x80) || (control & 0x80)) {
+       if (control & 0x80) {
                /* RTC not running */
-               u8 buf[16];
-               struct i2c_msg msg[1];
-
                dev_dbg(&client->dev, "%s: RTC not running!\n",
__FUNCTION__);
+               /* reset EOSC to start RTC */
+               i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
+                               control & 0x7f);
+       }

-               /* Initialize all, including STATUS and CONTROL to zero */
-               memset(buf, 0, sizeof(buf));
-               msg[0].addr =3D client->addr;
-               msg[0].flags =3D 0;
-               msg[0].len =3D sizeof(buf);
-               msg[0].buf =3D &buf[0];
-
-               i2c_transfer(client->adapter, msg, 1);
-       } else {
-               /* Running: ensure that device is set in 24-hour mode */
-               s32 val;
-
-               val =3D i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
-               if ((val >=3D 0) && (val & (1 << 6)))
-                       i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
-                                                 val & 0x3f);
+       /* Check if the oscillator was stopped due to power failure, ... */
+       status =3D i2c_smbus_read_byte_data(client, DS1337_REG_STATUS);
+       if (status & 0x80) {
+               dev_dbg(&client->dev, "%s: oscillator was stopped, RTC data"
+                               " unreliable!\n", __FUNCTION__);
+               /* reset OSF */
+               i2c_smbus_write_byte_data(client, DS1337_REG_STATUS,
+                               status & 0x7f);
        }
+
+       /* Ensure that device is set in 24-hour mode */
+       val =3D i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
+       if ((val >=3D 0) && (val & (1 << 6)))
+               i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
+                                         val & 0x3f);
 }

 static int ds1337_detach_client(struct i2c_client *client)


