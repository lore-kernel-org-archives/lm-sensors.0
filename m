From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:34 +0000
Subject: [lm-sensors] [PATCH] i2c: i2c_get_client is gone
Message-Id: <11365852541953@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: i2c_get_client is gone

The i2c_get_client function doesn't exist anymore, so we shouldn't
have a definition for it in i2c.h.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 482c788ded0aa9710722eaf9cf60886d3b923218
tree a66b5810e0db6061da847c1edd73f3e2fa0c5f32
parent 92b429461228f0f06a994dd3d4ccf1c9ff7596bd
author Jean Delvare <khali at linux-fr.org> Sat, 26 Nov 2005 21:06:08 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:22 -0800

 include/linux/i2c.h |   13 ++-----------
 1 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 85c517a..a9cea62 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -296,17 +296,8 @@ extern int i2c_del_driver(struct i2c_dri
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


