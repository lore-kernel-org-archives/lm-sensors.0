From: mort@bork.org (Martin Hicks)
Date: Wed, 07 Dec 2005 21:09:19 +0000
Subject: [lm-sensors] lm75 on a ppc405
Message-Id: <20051207210919.GF3085@bork.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


hi,

I've got a board with an lm75 connected to the iic of a ppc405.
Inserting the i2c-ibm_iic and lm75 (and dependent) modules doesn't find
the device.  I poked around a bit and applying the following patch
seemed to make things better (against 2.6.11.x):

Index: kernel/drivers/i2c/chips/lm75.c
=================================RCS file: /opt/targa/src/e-dtu/kernel/drivers/i2c/chips/lm75.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 lm75.c
--- kernel/drivers/i2c/chips/lm75.c	13 May 2005 17:59:52 -0000	1.1.1.1
+++ kernel/drivers/i2c/chips/lm75.c	7 Dec 2005 20:28:13 -0000
@@ -104,8 +104,6 @@ static DEVICE_ATTR(temp1_input, S_IRUGO,
 
 static int lm75_attach_adapter(struct i2c_adapter *adapter)
 {
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
 	return i2c_detect(adapter, &addr_data, lm75_detect);
 }


This may be wrong, but why do we care if the *adapter* (i.e., the ppc's
iic) is a HWMON device?  We want the i2c adapters to scan their busses
for lm75 devices.

Any insight or is this a correct patch?  With this patch I see the lm75
at 0x48 and the temperature it reports is reasonable.

mh

-- 
Martin Hicks || mort at bork.org || PGP/GnuPG: 0x4C7F2BEE

