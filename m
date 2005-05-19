From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] it87 sensor type
Message-Id: <20040222113336.68d9de4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Here comes a patch by Takeru Komoriya which fixes the way the it87
driver handles temperature sensor types selection.

* Use the same values as the CVS driver and sensors program.
* Better comments.
* Get rid of the old setting method (already gone in CVS).
* Handle invalid values correctly.

I've reviewed Takeru's work and it looks very good. Please apply (should
apply cleanly on top of your current stack).

Thanks.


Takeru,

I left the latest version of your patch untouched except for a comment
that wasn't in sync with the code after your latest changes. Good work!

I also updated the sensors program and it87 documentation in CVS as
promised.

Thanks for the good work. You can go on with the next part of your
changes if you want (preferably the reset option).


--- linux/drivers/i2c/chips/it87.c.orig	2004-02-16 09:59:54.000000000 +0900
+++ linux/drivers/i2c/chips/it87.c	2004-02-18 07:49:34.014430913 +0900
@@ -7,5 +7,5 @@
               Sis950   A clone of the IT8705F
 
-    Copyright (c) 2001 Chris Gauthron <chrisg@0-in.com> 
+    Copyright (C) 2001 Chris Gauthron <chrisg@0-in.com> 
     Largely inspired by lm78.c of the same package
 
@@ -58,10 +58,4 @@
 static int update_vbat = 0;
 
-
-/* Enable Temp1 as thermal resistor */
-/* Enable Temp2 as thermal diode */
-/* Enable Temp3 as thermal resistor */
-static int temp_type = 0x2a;
-
 /* Many IT87 constants specified below */
 
@@ -423,8 +417,8 @@
 	it87_update_client(client);
 	if (data->sensor & (1 << nr))
-	    return sprintf(buf, "1\n");
+	    return sprintf(buf, "3\n");  /* thermal diode */
 	if (data->sensor & (8 << nr))
-	    return sprintf(buf, "2\n");
-	return sprintf(buf, "0\n");
+	    return sprintf(buf, "2\n");  /* thermistor */
+	return sprintf(buf, "0\n");      /* disabled */
 }
 static ssize_t set_sensor(struct device *dev, const char *buf, 
@@ -437,8 +431,11 @@
 	data->sensor &= ~(1 << nr);
 	data->sensor &= ~(8 << nr);
-	if (val = 1)
+	/* 3 = thermal diode; 2 = thermistor; 0 = disabled */
+	if (val = 3)
 	    data->sensor |= 1 << nr;
 	else if (val = 2)
 	    data->sensor |= 8 << nr;
+	else if (val != 0)
+	    return -1;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	return count;
@@ -889,5 +886,5 @@
 	/* Enable Temp1-Temp3 */
 	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= temp_type & 0x3f;
+	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 
@@ -968,4 +965,6 @@
 			(it87_read_value(client, IT87_REG_ALARM3) << 16);
 
+		data->sensor = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -990,6 +989,4 @@
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
-MODULE_PARM(temp_type, "i");
-MODULE_PARM_DESC(temp_type, "Temperature sensor type, normally leave unset");
 MODULE_LICENSE("GPL");
 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
