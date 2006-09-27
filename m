From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:02:01 +0000
Subject: [lm-sensors] [PATCH 30/30] i2c: Drop unimplemented slave functions
Message-Id: <11593190242523-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: Drop unimplemented slave functions

Drop the function declarations for slave mode support of i2c adapters.
This was never implemented, and by the time it is I bet we will want
something different anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 include/linux/i2c.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 23ad1ee..9b5d047 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -64,14 +64,6 @@ extern int i2c_master_recv(struct i2c_cl
  */
 extern int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num);
 
-/*
- * Some adapter types (i.e. PCF 8584 based ones) may support slave behaviuor. 
- * This is not tested/implemented yet and will change in the future.
- */
-extern int i2c_slave_send(struct i2c_client *,char*,int);
-extern int i2c_slave_recv(struct i2c_client *,char*,int);
-
-
 
 /* This is the very generalized SMBus access routine. You probably do not
    want to use this, though; one of the functions below may be much easier,
@@ -201,10 +193,6 @@ struct i2c_algorithm {
 	                   unsigned short flags, char read_write,
 	                   u8 command, int size, union i2c_smbus_data * data);
 
-	/* --- these optional/future use for some adapter types.*/
-	int (*slave_send)(struct i2c_adapter *,char*,int);
-	int (*slave_recv)(struct i2c_adapter *,char*,int);
-
 	/* --- ioctl like call to set div. parameters. */
 	int (*algo_control)(struct i2c_adapter *, unsigned int, unsigned long);
 
-- 
1.4.2.1


