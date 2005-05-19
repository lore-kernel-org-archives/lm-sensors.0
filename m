From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] Remove asb100 support from w83781d
Message-Id: <20040223223028.5726f3c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Now that we have a separate asb100 driver, we can remove the (bad)
support of it from the w83781d driver. Following patch does this. I've
already cleaned this up in our CVS repository.

Please apply,
Thanks.

--- linux-2.6.3-g1/drivers/i2c/chips/w83781d.c.orig	2004-02-23 10:13:41.000000000 +0100
+++ linux-2.6.3-g1/drivers/i2c/chips/w83781d.c	2004-02-23 10:44:19.000000000 +0100
@@ -25,8 +25,7 @@
 
     Chip	#vin	#fanin	#pwm	#temp	wchipid	vendid	i2c	ISA
     as99127f	7	3	1?	3	0x31	0x12c3	yes	no
-    as99127f rev.2 (type_name = 1299127f)	0x31	0x5ca3	yes	no
-    asb100 "bach" (type_name = as99127f)	0x31	0x0694	yes	no
+    as99127f rev.2 (type_name = as99127f)	0x31	0x5ca3	yes	no
     w83781d	7	3	0	3	0x10-1	0x5ca3	yes	yes
     w83627hf	9	3	2	3	0x21	0x5ca3	yes	yes(LPC)
     w83627thf	9	3	2	3	0x90	0x5ca3	no	yes(LPC)
@@ -1194,10 +1193,8 @@
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		/* Check for Winbond or Asus ID if in bank 0 */
 		if ((!(val1 & 0x07)) &&
-		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3)
-		      && (val2 != 0x94))
-		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)
-			 && (val2 != 0x06)))) {
+		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
+		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1226,7 +1223,7 @@
 		val2 = w83781d_read_value(new_client, W83781D_REG_CHIPMAN);
 		if (val2 = 0x5c)
 			vendid = winbond;
-		else if ((val2 = 0x12) || (val2 = 0x06))
+		else if (val2 = 0x12)
 			vendid = asus;
 		else {
 			err = -ENODEV;


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
