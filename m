From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <1101807766.3215.103.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Very few drivers seem to support the I2C_FUNC_I2C functionality, is
there a reason for that?

I have an I2C bus on my platform constructed from a couple of GPIO lines
using the i2c-algo-bit driver. The device on the bus is a DS1307 I2C RTC
and the driver for that currently checks for
	I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_WRITE_BYTE
however the datasheet suggests it is a simple i2c device with none of
this smbus stuff, Russell King queried this here
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id 21/1

If I change it to a check for I2C_FUNC_I2C and change the algo-bit
driver to declare I2C_FUNC_I2C then the driver continues to work fine. 

The ds1307 is described here:
http://www.maxim-ic.com/quick_view2.cfm?qv_pk&88

Given the above, is the following patch appropriate, or is there
something about the relationship between i2c and smbus that I don't
understand.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6/drivers/i2c/algos/i2c-algo-bit.c
=================================--- 2.6.orig/drivers/i2c/algos/i2c-algo-bit.c	2004-10-20 10:43:57.000000000 +0100
+++ 2.6/drivers/i2c/algos/i2c-algo-bit.c	2004-11-30 09:26:26.706069433 +0000
@@ -511,8 +511,8 @@
 
 static u32 bit_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
