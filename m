From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:28:59 +0000
Subject: [lm-sensors] [PATCH 09/25] i2c:Drop i2c_driver.flags, 3 of 3
Message-Id: <20051126203001.2b911d0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-client-use-03-allow-multiple-use.patch

Do not limit the usage count of i2c clients to 1. In other words,
change the client usage count behavior from the old I2C_CLIENT_ALLOW_USE
to the old I2C_CLIENT_ALLOW_MULTIPLE_USE. The rationale is that no
driver actually needs the limiting behavior, and the unlimiting
behavior is slightly easier to implement.

Update the documentation to reflect this change.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/i2c/porting-clients |    1 +
 drivers/i2c/i2c-core.c            |    5 -----
 include/linux/i2c.h               |    4 +---
 3 files changed, 2 insertions(+), 8 deletions(-)

--- linux-2.6.15-rc2.orig/Documentation/i2c/porting-clients	2005-11-26 14:15:06.000000000 +0100
+++ linux-2.6.15-rc2/Documentation/i2c/porting-clients	2005-11-26 14:34:31.000000000 +0100
@@ -92,6 +92,7 @@
   Drop client->id.
   Drop any 24RF08 corruption prevention you find, as this is now done
   at the i2c-core level, and doing it twice voids it.
+  Don't add I2C_CLIENT_ALLOW_USE to client->flags, it's the default now.
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module
--- linux-2.6.15-rc2.orig/drivers/i2c/i2c-core.c	2005-11-26 14:21:37.000000000 +0100
+++ linux-2.6.15-rc2/drivers/i2c/i2c-core.c	2005-11-26 14:27:12.000000000 +0100
@@ -497,14 +497,9 @@
 	if (ret)
 		return ret;
 
-	if (client->usage_count > 0)
-		goto busy;
 	client->usage_count++;
 
 	return 0;
- busy:
-	i2c_dec_use_client(client);
-	return -EBUSY;
 }
 
 int i2c_release_client(struct i2c_client *client)
--- linux-2.6.15-rc2.orig/include/linux/i2c.h	2005-11-26 14:34:31.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/i2c.h	2005-11-26 14:37:06.000000000 +0100
@@ -308,9 +308,7 @@
    extern struct i2c_client *i2c_get_client(int,int,struct i2c_client *);
    to make sure that client-struct is valid and that it is okay to access
    the i2c-client. 
-   returns -EACCES if client doesn't allow use (default)
-   returns -EBUSY if client doesn't allow multiple use (default) and 
-   usage_count >0 */
+   returns -ENODEV if client has gone in the meantime */
 extern int i2c_use_client(struct i2c_client *);
 extern int i2c_release_client(struct i2c_client *);
 

-- 
Jean Delvare
