From: aurelien@aurel32.net (=?iso-8859-15?Q?Aur=E9lien?= Jarno)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <20050119180245.GA17163@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501040208.12906.p.henning@fh-karlsruhe.de>
In-Reply-To: <200501040208.12906.p.henning@fh-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 19, 2005 at 05:27:53PM +0100, Aur?lien Jarno wrote:
 
> I have looked to the datasheet to find a way to detect the DS1621 chip. 
> Here is my proposal:
> 
> 1) Verify that the 7 lowest bits of the TL register are 0. This is 
> basically what you proposed. It is specified in the datasheet that's 
> these bit are always 0, and I doubt it will change in the future 
> (because in that case a lot of existing design won't work anymore).
> 
> 2) Verify that bit 4 of the config register is 0. It means that the chip 
> is not currently writing to its EEPROM, or that no EEPROM write has been 
> requested in the last 10ms. I think we could safely say that it is 
> always the case with the kernel driver.
> 
> 3) Issue a "stop conversion T" (= sending 0x22 to the chip), and verify 
> that the bit 7 of the config register is set to 1 (no conversion in 
> progress).
The 3) doesn't work, because the bit is actually "conversion done", so
on power-up this bit is set to 0. Anyway, starting a conversion toggle
this bit to 0 during 500ms to 1s so if we read it shortly after sending
such a command, it should be 0.

I have attached a patch for the 2.6 kernel as well for lm_sensors CVS. I
have tested the 2.6 module, and it works as expected. For the 2.4
module I only built it as I don't have a 2.4 kernel. Note that I also
improved the detection routine by backporting the 1) from the 2.6
kernel.

If everybody agrees, I'll send the 2.6 patch to Greg.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: kernel/chips/ds1621.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/ds1621.c,v
retrieving revision 1.16
diff -u -1 -b -p -r1.16 ds1621.c
--- kernel/chips/ds1621.c	4 Dec 2004 21:18:34 -0000	1.16
+++ kernel/chips/ds1621.c	19 Jan 2005 17:58:36 -0000
@@ -45,5 +45,4 @@ SENSORS_INSMOD_1(ds1621);
 /*  7    6    5    4    3    2    1    0      */
-/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */
-#define DS1621_REG_CONFIG_MASK 0x0C
-#define DS1621_REG_CONFIG_VAL 0x08
+/* |Done|THF |TLF |NVB | X  | X  |POL |1SHOT| */
+#define DS1621_REG_CONFIG_NVB 0x10
 #define DS1621_REG_CONFIG_POLARITY 0x02
@@ -167,3 +166,3 @@ int ds1621_detect(struct i2c_adapter *ad
 {
-	int i, conf;
+	int i, conf, temp;
 	struct i2c_client *new_client;
@@ -205,7 +204,33 @@ int ds1621_detect(struct i2c_adapter *ad
 	if (kind < 0) {
+		/* The NVB bit should be low if no EEPROM write has been
+		   requested during the latest 10ms, which is highly
+		   improbable in our case. */
 		conf = i2c_smbus_read_byte_data(new_client,
 						DS1621_REG_CONF);
-		if ((conf & DS1621_REG_CONFIG_MASK)
-		    != DS1621_REG_CONFIG_VAL)
+		if (conf & DS1621_REG_CONFIG_NVB)
 			goto ERROR1;
+		/* The 7 lowest bits of a temperature should always be 0. */
+		temp = ds1621_read_value(new_client, 
+					 DS1621_REG_TEMP);
+		if (temp & 0x007f)
+			goto ERROR1;
+		temp = ds1621_read_value(new_client, 
+					 DS1621_REG_TEMP_OVER);
+		if (temp & 0x007f)
+			goto ERROR1;
+			temp = ds1621_read_value(new_client, 
+					 DS1621_REG_TEMP_HYST);
+		if (temp & 0x007f)
+			goto ERROR1;
+		/* Start conversion. DONE should go to low. */
+		i2c_smbus_write_byte(new_client, 
+				     DS1621_COM_START);
+		conf = i2c_smbus_read_byte_data(new_client,
+						DS1621_REG_CONF);
+		if (conf & DS1621_REG_CONFIG_DONE)
+			goto ERROR1;
+		/* Stop conversion. */
+		i2c_smbus_write_byte(new_client, 
+				     DS1621_COM_STOP);
+	
 	}
-------------- next part --------------
diff -urN linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c	2005-01-19 18:39:23.000000000 +0100
@@ -42,9 +42,8 @@
 /* Many DS1621 constants specified below */
 /* Config register used for detection         */
 /*  7    6    5    4    3    2    1    0      */
-/* |Done|THF |TLF |NVB | 1  | 0  |POL |1SHOT| */
-#define DS1621_REG_CONFIG_MASK		0x0C
-#define DS1621_REG_CONFIG_VAL		0x08
+/* |Done|THF |TLF |NVB | X  | X  |POL |1SHOT| */
+#define DS1621_REG_CONFIG_NVB		0x10
 #define DS1621_REG_CONFIG_POLARITY	0x02
 #define DS1621_REG_CONFIG_1SHOT		0x01
 #define DS1621_REG_CONFIG_DONE		0x80
@@ -55,6 +54,7 @@
 #define DS1621_REG_TEMP_MAX		0xA2 /* word, RW */
 #define DS1621_REG_CONF			0xAC /* byte, RW */
 #define DS1621_COM_START		0xEE /* no data */
+#define DS1621_COM_STOP			0x22 /* no data */
 
 /* The DS1621 configuration register */
 #define DS1621_ALARM_TEMP_HIGH		0x40
@@ -212,9 +212,13 @@
 
 	/* Now, we do the remaining detection. It is lousy. */
 	if (kind < 0) {
+		/* The NVB bit should be low if no EEPROM write has been 
+		   requested during the latest 10ms, which is highly 
+		   improbable in our case. */
 		conf = ds1621_read_value(new_client, DS1621_REG_CONF);
-		if ((conf & DS1621_REG_CONFIG_MASK) != DS1621_REG_CONFIG_VAL)
+		if (conf & DS1621_REG_CONFIG_NVB)
 			goto exit_free;
+		/* The 7 lowest bits of a temperature should always be 0. */
 		temp = ds1621_read_value(new_client, DS1621_REG_TEMP);
 		if (temp & 0x007f)
 			goto exit_free;
@@ -224,6 +228,13 @@
 		temp = ds1621_read_value(new_client, DS1621_REG_TEMP_MAX);
 		if (temp & 0x007f)
 			goto exit_free;
+		/* Start conversion. DONE should go to low. */
+		i2c_smbus_write_byte(new_client, DS1621_COM_START);
+		conf = ds1621_read_value(new_client, DS1621_REG_CONF);
+		if (conf & DS1621_REG_CONFIG_DONE)
+			goto exit_free;
+		/* Stop conversion. */
+		i2c_smbus_write_byte(new_client, DS1621_COM_STOP);
 	}
 
 	/* Determine the chip type - only one kind supported! */
