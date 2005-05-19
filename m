From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: module reference counting
Message-Id: <20040616051054.GC2556@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

I've been studying the i2c-core in CVS and 2.4.26 to try to understand
the module reference counting mechanism.

One thing I'm not sure about is this patch from your web page.  Why did
you strike the MOD_xxx_USE_COUNT calls there?  They look necessary to
keep the module loaded while there's a live kernel thread.

It's very possible I'm missing something though.

--- linux-2.4.25-orig/drivers/media/video/msp3400.c	Sat Nov 15 17:24:54 2003
+++ linux-2.4.25-i2c/drivers/media/video/msp3400.c	Sat Nov 15 18:46:46 2003
@@ -1243,6 +1243,7 @@
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
 static struct i2c_driver driver = {
+        .owner          = THIS_MODULE,
         .name           = "i2c msp3400 driver",
         .id             = I2C_DRIVERID_MSP3400,
         .flags          = I2C_DF_NOTIFY,
@@ -1346,7 +1347,6 @@
 	printk("\n");
 
 	/* startup control thread */
-	MOD_INC_USE_COUNT;
 	msp->notify = &sem;
 	rc = kernel_thread(msp->simple ? msp3410d_thread : msp3400c_thread,
 			   (void *)c, 0);
@@ -1399,7 +1399,7 @@
 	i2c_detach_client(client);
 	kfree(msp);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
+
 	return 0;
 }

Regards,
 
-- 
Mark M. Hoffman
mhoffman@lightlink.com
