From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 21:05:08 +0000
Subject: [lm-sensors] [PATCH 25/25] i2c: i2c_get_client is gone
Message-Id: <20051126210608.5a9bd8c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=i2c-core-get-client-is-gone.patch

The i2c_get_client function doesn't exist anymore, so we shouldn't
have a definition for it in i2c.h.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 include/linux/i2c.h |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

--- linux-2.6.15-rc2.orig/include/linux/i2c.h	2005-11-26 14:37:06.000000000 +0100
+++ linux-2.6.15-rc2/include/linux/i2c.h	2005-11-26 14:43:51.000000000 +0100
@@ -297,17 +297,8 @@
 extern int i2c_attach_client(struct i2c_client *);
 extern int i2c_detach_client(struct i2c_client *);
 
-/* New function: This is to get an i2c_client-struct for controlling the 
-   client either by using i2c_control-function or having the 
-   client-module export functions that can be used with the i2c_client
-   -struct. */
-extern struct i2c_client *i2c_get_client(int driver_id, int adapter_id, 
-					struct i2c_client *prev);
-
-/* Should be used with new function
-   extern struct i2c_client *i2c_get_client(int,int,struct i2c_client *);
-   to make sure that client-struct is valid and that it is okay to access
-   the i2c-client. 
+/* Should be used to make sure that client-struct is valid and that it
+   is okay to access the i2c-client.
    returns -ENODEV if client has gone in the meantime */
 extern int i2c_use_client(struct i2c_client *);
 extern int i2c_release_client(struct i2c_client *);

-- 
Jean Delvare
