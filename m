From: hgchew@gunnet.org (Chew Hong Gunn)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040130004132.GA8321@evilmoon.gunnet.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the changes and comments.

> * Can you confirm that you do have a GL518SM chipset for testing and
> use? Please also tell us which release it is. This is an old chip and I
> am surprised that someone still uses it. I think we should only port to
> Linux 2.6 drivers that people need. We better don't work for nobody, and
> also don't clutter the kernel tree with useless code.
Yes, I have the gl518sm chip, rev 00.  It is on a board with the Intel 
LX chipset for the PII, so there should still be people using it.  It
works fine as a file server/internet gateway.

> * Can you confirm that the 2.4 driver works OK for you? Just to make
> sure that the code we are starting from is working.
Yes, the 2.4 driver works OK.

> * Your new driver defines two different names for the two different
> releases of the chip. This breaks compatibility with libsensors, and
> would better be fixed (I will do too).
Ok.  It was there to differentiate the two revisions.


> * The "iteration" code increases the driver code size by one third (not
> one fifth as I initially announced). One more reason to get rid of it (I
> already did it, to say the truth).
I agree that it is not necessary and should be removed from the kernel 
even if it does work.


I have tested rc1 with and without DEBUG on the rev00 chip, and the
iteration code works fine (if it were to remain).

I have tested rc2 and there are no problems with it.  I did however
make two minor changes to it:
* added swap_bytes function declaration (unless you deleted it intentionally)
* removed voltage_in[0-2] = 0 for rev00 chips
  these are initialised to 0 on init, so there should be no need
  to set them at each update.

Regards,
Hong-Gunn
-------------- next part --------------
--- gl518sm.c.rc2	2004-01-30 10:48:40.441390788 +1030
+++ gl518sm.c	2004-01-30 10:49:56.889479181 +1030
@@ -145,6 +145,7 @@
 static int gl518_read_value(struct i2c_client *client, u8 reg);
 static int gl518_write_value(struct i2c_client *client, u8 reg, u16 value);
 static void gl518_update_client(struct i2c_client *client);
+static inline u16 swap_bytes(u16 val);
 
 /* This is the driver that will be inserted */
 static struct i2c_driver gl518_driver = {
@@ -553,11 +554,7 @@
 		val = gl518_read_value(client, GL518_REG_CONF);
 		data->beep_enable = (val >> 2) & 1;
 
-		if (data->type = gl518sm_r00) {
-			data->voltage_in[0] = 0;
-			data->voltage_in[1] = 0;
-			data->voltage_in[2] = 0;
-		} else {
+		if (data->type != gl518sm_r00) {
 			data->voltage_in[0]  			    gl518_read_value(client, GL518_REG_VDD);
 			data->voltage_in[1] 
