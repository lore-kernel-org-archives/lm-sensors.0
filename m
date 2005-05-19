From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [PATCH] i2c driver changes for 2.5.68
Message-Id: <10512287472218@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1051228746126@kroah.com>
References: <10512287461373@kroah.com>
In-Reply-To: <10512287461373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1179.3.9, 2003/04/24 11:14:26-07:00, greg@kroah.com

[PATCH] i2c: removed unneeded typedef from i2c-sensor.h


 drivers/i2c/i2c-sensor.c   |    4 ++--
 include/linux/i2c-sensor.h |    7 ++-----
 2 files changed, 4 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:46:20 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Apr 24 16:46:20 2003
@@ -35,8 +35,8 @@
 
 /* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
 int i2c_detect(struct i2c_adapter *adapter,
-		   struct i2c_address_data *address_data,
-		   i2c_found_addr_proc * found_proc)
+	       struct i2c_address_data *address_data,
+	       int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr, i, found, j, err;
 	struct i2c_force_data *this_force;
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h	Thu Apr 24 16:46:20 2003
+++ b/include/linux/i2c-sensor.h	Thu Apr 24 16:46:20 2003
@@ -315,16 +315,13 @@
                                                  {NULL}}; \
   SENSORS_INSMOD
 
-typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
-				    int addr, int kind);
-
 /* Detect function. It iterates over all possible addresses itself. For
    SMBus addresses, it will only call found_proc if some client is connected
    to the SMBus (unless a 'force' matched); for ISA detections, this is not
    done. */
 extern int i2c_detect(struct i2c_adapter *adapter,
-			  struct i2c_address_data *address_data,
-			  i2c_found_addr_proc * found_proc);
+		      struct i2c_address_data *address_data,
+		      int (*found_proc) (struct i2c_adapter *, int, int));
 
 
 /* This macro is used to scale user-input to sensible values in almost all

