From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:22 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (03/11)
Message-Id: <11259567683113@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567691080@kroah.com>
In-Reply-To: <11259567691080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (03/11)

We now have two identical structures, i2c_address_data in i2c-sensor.h
and i2c_client_address_data in i2c.h. We can kill one of them, I choose
to keep the one in i2c.h as it makes more sense (this structure is not
specific to sensors.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b78ec31582c60578ee1d3bb470791d6dde96ccf7
tree fa36aebdd3235c5cce1f70bac34066c4eeb5108b
parent ef8dec5d8b3e96e359f377f35cd8caff42fe6d58
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 21:36:24 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:19 -0700

 drivers/i2c/i2c-sensor-detect.c |    2 +-
 include/linux/i2c-sensor.h      |   30 +++---------------------------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c
+++ b/drivers/i2c/i2c-sensor-detect.c
@@ -28,7 +28,7 @@ static unsigned short empty[] = {I2C_CLI
 
 /* Won't work for 10-bit addresses! */
 int i2c_detect(struct i2c_adapter *adapter,
-	       struct i2c_address_data *address_data,
+	       struct i2c_client_address_data *address_data,
 	       int (*found_proc) (struct i2c_adapter *, int, int))
 {
 	int addr, i, found, j, err;
diff --git a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h
+++ b/include/linux/i2c-sensor.h
@@ -22,31 +22,7 @@
 #ifndef _LINUX_I2C_SENSOR_H
 #define _LINUX_I2C_SENSOR_H
 
-/* A structure containing the detect information.
-   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
-     A list of I2C addresses which should normally be examined.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the address. These addresses are also probed,
-     as if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with I2C_CLIENT_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
-     I2C bus), the second is the I2C address. These addresses are never
-     probed. This parameter overrules 'normal' and  probe', but not the
-    'force' lists.
-   forces: insmod parameters. A list, ending with a NULL element.
-     Force variables overrule all other variables; they force a detection on
-     that place. If a specific chip is given, the module blindly assumes this
-     chip type is present; if a general force (kind = 0) is given, the module
-     will still try to figure out what type of chip is present. This is useful
-     if for some reasons the detect for SMBus address space filled fails.
-*/
-struct i2c_address_data {
-	unsigned short *normal_i2c;
-	unsigned short *probe;
-	unsigned short *ignore;
-	unsigned short **forces;
-};
+#include <linux/i2c.h>
 
 #define SENSORS_MODULE_PARM_FORCE(name) \
   I2C_CLIENT_MODULE_PARM(force_ ## name, \
@@ -60,7 +36,7 @@ struct i2c_address_data {
                       "List of adapter,address pairs to scan additionally"); \
   I2C_CLIENT_MODULE_PARM(ignore, \
                       "List of adapter,address pairs not to scan"); \
-	static struct i2c_address_data addr_data = {			\
+	static struct i2c_client_address_data addr_data = {		\
 			.normal_i2c =		normal_i2c,		\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
@@ -228,7 +204,7 @@ struct i2c_address_data {
    SMBus addresses, it will only call found_proc if some client is connected
    to the SMBus (unless a 'force' matched). */
 extern int i2c_detect(struct i2c_adapter *adapter,
-		      struct i2c_address_data *address_data,
+		      struct i2c_client_address_data *address_data,
 		      int (*found_proc) (struct i2c_adapter *, int, int));
 
 #endif				/* def _LINUX_I2C_SENSOR_H */

