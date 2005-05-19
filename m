From: aurelien@aurel32.net (=?iso-8859-15?Q?Aur=E9lien?= Jarno)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <20050119203306.GB19261@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501040208.12906.p.henning@fh-karlsruhe.de>
In-Reply-To: <200501040208.12906.p.henning@fh-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After some discussion on IRC with Jean Delvare, here is the final patch
for the 2.4 driver. The 2.6 patch has already been sent to Greg KH in 
an other mail.

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
+++ kernel/chips/ds1621.c	19 Jan 2005 20:22:41 -0000
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
@@ -205,7 +204,22 @@ int ds1621_detect(struct i2c_adapter *ad
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
+			goto exit_free;
+		temp = ds1621_read_value(new_client, 
+					 DS1621_REG_TEMP_MIN);
+		if (temp & 0x007f)
+			goto exit_free;
+			temp = ds1621_read_value(new_client, 
+					 DS1621_REG_TEMP_MAX);
+		if (temp & 0x007f)
+			goto exit_free;
 	}
