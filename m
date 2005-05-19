From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] I2C: Move functionality handling from i2c-core to i2c.h
Message-Id: <11123858552208@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123858541382@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2340, 2005/04/01 11:49:04-08:00, khali@linux-fr.org

[PATCH] I2C: Move functionality handling from i2c-core to i2c.h

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

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/i2c-core.c |   19 -------------------
 include/linux/i2c.h    |   10 ++++++++--
 2 files changed, 8 insertions(+), 21 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2005-04-01 11:53:08 -08:00
+++ b/drivers/i2c/i2c-core.c	2005-04-01 11:53:08 -08:00
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
@@ -1282,9 +1266,6 @@
 EXPORT_SYMBOL(i2c_smbus_write_word_data);
 EXPORT_SYMBOL(i2c_smbus_write_block_data);
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data);
-
-EXPORT_SYMBOL(i2c_get_functionality);
-EXPORT_SYMBOL(i2c_check_functionality);
 
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-04-01 11:53:08 -08:00
+++ b/include/linux/i2c.h	2005-04-01 11:53:08 -08:00
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

