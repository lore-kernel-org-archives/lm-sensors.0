From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Rework client usage count, 3 of 3
Message-Id: <11365852552960@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Rework client usage count, 3 of 3

Do not limit the usage count of i2c clients to 1. In other words,
change the client usage count behavior from the old I2C_CLIENT_ALLOW_USE
to the old I2C_CLIENT_ALLOW_MULTIPLE_USE. The rationale is that no
driver actually needs the limiting behavior, and the unlimiting
behavior is slightly easier to implement.

Update the documentation to reflect this change.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit cf02df770228350254251fde520007a2709db785
tree ef10929d0160ebf27f29bac2a9e285b267a63331
parent cde7859bda0d1124392b44e50aa11df99707e1d9
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 21:03:41 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

 Documentation/i2c/porting-clients |    1 +
 drivers/i2c/i2c-core.c            |    5 -----
 include/linux/i2c.h               |    4 +---
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
index 64c610b..6b07f23 100644
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -92,6 +92,7 @@ Technical changes:
   Drop client->id.
   Drop any 24RF08 corruption prevention you find, as this is now done
   at the i2c-core level, and doing it twice voids it.
+  Don't add I2C_CLIENT_ALLOW_USE to client->flags, it's the default now.
 
 * [Init] Limits must not be set by the driver (can be done later in
   user-space). Chip should not be reset default (although a module
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d16b499..a1c5dff 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -497,14 +497,9 @@ int i2c_use_client(struct i2c_client *cl
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
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 8b4d469..85c517a 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -307,9 +307,7 @@ extern struct i2c_client *i2c_get_client
    extern struct i2c_client *i2c_get_client(int,int,struct i2c_client *);
    to make sure that client-struct is valid and that it is okay to access
    the i2c-client. 
-   returns -EACCES if client doesn't allow use (default)
-   returns -EBUSY if client doesn't allow multiple use (default) and 
-   usage_count >0 */
+   returns -ENODEV if client has gone in the meantime */
 extern int i2c_use_client(struct i2c_client *);
 extern int i2c_release_client(struct i2c_client *);
 


