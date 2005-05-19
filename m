From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH 2.6] I2C: Move functionality handling from i2c-core to i2c.h
Message-Id: <20050328203853.4bf25f79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

So far, the functionality handling of i2c adapters was done in i2c-core
by two exported functions: i2c_get_functionality and
i2c_check_functionality. I found that both functions could be reduced to
one line each, and propose that we turn them into inline function in the
i2c.h header file, much like other i2c helper functions (e.g.
i2c_get_clientdata, i2c_set_clientdata and i2c_clientname).

The conversion of i2c_get_functionality suppresses a legacy check which
shouldn't be needed anymore. Only one driver (s3c2410) was still relying
on it, and was fixed some days ago.

The conversion lets us get rid of two exports. Not only i2c-core gets
smaller (by 458 bytes), but the client drivers using these functions get
smaller too (typically by 48 bytes). And of course the new way is likely
to be faster too, even if it wasn't my primary objective.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm3/drivers/i2c/i2c-core.c.orig	2005-03-27 18:53:02.000000000 +0200
+++ linux-2.6.12-rc1-mm3/drivers/i2c/i2c-core.c	2005-03-28 20:23:03.000000000 +0200
@@ -1236,22 +1236,6 @@
 }
 
 
-/* You should always define `functionality'; the 'else' is just for
-   backward compatibility. */ 
-u32 i2c_get_functionality (struct i2c_adapter *adap)
-{
-	if (adap->algo->functionality)
-		return adap->algo->functionality(adap);
-	else
-		return 0xffffffff;
-}
-
-int i2c_check_functionality (struct i2c_adapter *adap, u32 func)
-{
-	u32 adap_func = i2c_get_functionality (adap);
-	return (func & adap_func) = func;
-}
-
 EXPORT_SYMBOL(i2c_add_adapter);
 EXPORT_SYMBOL(i2c_del_adapter);
 EXPORT_SYMBOL(i2c_add_driver);
@@ -1283,9 +1267,6 @@
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
 
-EXPORT_SYMBOL(i2c_get_functionality);
-EXPORT_SYMBOL(i2c_check_functionality);
-
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
--- linux-2.6.12-rc1-mm3/include/linux/i2c.h.orig	2005-03-26 07:00:21.000000000 +0100
+++ linux-2.6.12-rc1-mm3/include/linux/i2c.h	2005-03-28 20:23:03.000000000 +0200
@@ -368,10 +368,16 @@
 
 
 /* Return the functionality mask */
-extern u32 i2c_get_functionality (struct i2c_adapter *adap);
+static inline u32 i2c_get_functionality(struct i2c_adapter *adap)
+{
+	return adap->algo->functionality(adap);
+}
 
 /* Return 1 if adapter supports everything we need, 0 if not. */
-extern int i2c_check_functionality (struct i2c_adapter *adap, u32 func);
+static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
+{
+	return (func & i2c_get_functionality(adap)) = func;
+}
 
 /*
  * I2C Message - used for pure i2c transaction, also from /dev interface


-- 
Jean Delvare
