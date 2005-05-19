From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH 2.6] Voltage conversions in via686a
Message-Id: <20040420192208.3c830b3c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I noticed that the voltage conversions in via686a have severe rounding
issues. And all in all they are artificially complex, and wrong.

One comment in the code itself confirm my suspicions:
// These get us close, but they don't completely agree with what my BIOS
// says- they are all a bit low.  But, it all we have to go on...

The following patch, slightly tested by me (my VIA686A chip is not used
for hardware monitoring), and then by Lennard Klein on a working chip,
fixes that. It should apply cleanly on top of 2.6.6-rc1.

Please apply,
thanks.


--- linux-2.6.5-mm3/drivers/i2c/chips/via686a.c.init	Mon Apr 12 11:02:54 2004
+++ linux-2.6.5-mm3/drivers/i2c/chips/via686a.c	Mon Apr 12 11:55:19 2004
@@ -123,49 +123,41 @@
  volts = (25*regVal+133)*factor
  regVal = (volts/factor-133)/25
  (These conversions were contributed by Jonathan Teh Soon Yew 
- <j.teh@iname.com>)
- 
- These get us close, but they don't completely agree with what my BIOS 
- says- they are all a bit low.  But, it all we have to go on... */
+ <j.teh@iname.com>) */
 static inline u8 IN_TO_REG(long val, int inNum)
 {
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of 
-	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the 
-	 /250 (which should really be /2500).
-	 At the end, we need to /100 because we *100 everything and we need
-	 to /10 because of the rounding thing, so we /1000.   */
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   Rounding is done (120500 is actually 133000 - 12500).
+	   Remember that val is expressed in 0.001V/bit, which is why we divide
+	   by an additional 10000 (100000 for +12V): 1000 for val and 10 (100)
+	   for the constants. */
 	if (inNum <= 1)
 		return (u8)
-		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 21024 - 120500) / 250000, 0, 255);
 	else if (inNum = 2)
 		return (u8)
-		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 15737 - 120500) / 250000, 0, 255);
 	else if (inNum = 3)
 		return (u8)
-		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000, 
-				  0, 255);
+		    SENSORS_LIMIT((val * 10108 - 120500) / 250000, 0, 255);
 	else
-		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
-					  / 1000, 0, 255);
+		return (u8)
+		    SENSORS_LIMIT((val * 41714 - 1205000) / 2500000, 0, 255);
 }
 
 static inline long IN_FROM_REG(u8 val, int inNum)
 {
-	/* to avoid floating point, we multiply everything by 100.
-	 val is guaranteed to be positive, so we can achieve the effect of
-	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
-	 We need to scale with *100 anyway, so no need to /100 at the end. */
+	/* To avoid floating point, we multiply constants by 10 (100 for +12V).
+	   We also multiply them by 1000 because we want 0.001V/bit for the
+	   output value. Rounding is done. */
 	if (inNum <= 1)
-		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 21024 / 2) / 21024);
 	else if (inNum = 2)
-		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 15737 / 2) / 15737);
 	else if (inNum = 3)
-		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
+		return (long) ((250000 * val + 1330000 + 10108 / 2) / 10108);
 	else
-		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
+		return (long) ((2500000 * val + 13300000 + 41714 / 2) / 41714);
 }
 
 /********* FAN RPM CONVERSIONS ********/
@@ -375,24 +367,24 @@
 /* 7 voltage sensors */
 static ssize_t show_in(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr));
 }
 
 static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr));
 }
 
 static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
 	struct via686a_data *data = via686a_update_device(dev);
-	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr));
 }
 
 static ssize_t set_in_min(struct device *dev, const char *buf, 
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_min[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MIN(nr), 
 			data->in_min[nr]);
@@ -402,7 +394,7 @@
 		size_t count, int nr) {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct via686a_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10)/10;
+	unsigned long val = simple_strtoul(buf, NULL, 10);
 	data->in_max[nr] = IN_TO_REG(val,nr);
 	via686a_write_value(client, VIA686A_REG_IN_MAX(nr), 
 			data->in_max[nr]);

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
