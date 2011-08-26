From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 16:19:02 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (pmbus) Add comments explaining
Message-Id: <1314375545-18335-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Return values for functions reading/writing manufacturer specific registers are
poorly explained. Add comments to improve documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus.h |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index a6ae20f..da90167 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -134,8 +134,16 @@
  * Semantics:
  * Virtual registers are all word size.
  * READ registers are read-only; writes are either ignored or return an error.
- * RESET registers are read/write. Reading returns zero (used for detection),
- * writing any value causes the associated history to be reset.
+ * RESET registers are read/write. Reading reset registers returns zero
+ * (used for detection), writing any value causes the associated history to be
+ * reset.
+ * Virtual registers have to be handled in device specific driver code. Chip
+ * driver code returns non-negative register values if a virtual register is
+ * supported, or a negative error code if not. The chip driver may return
+ * -ENODATA or any other error code in this case, though an error code other
+ * than -ENODATA is handled more efficiently and thus preferred. Either case,
+ * the calling PMBus core code will abort if the chip driver returns an error
+ * code when reading or writing virtual registers.
  */
 #define PMBUS_VIRT_BASE			0x100
 #define PMBUS_VIRT_READ_TEMP_MIN	(PMBUS_VIRT_BASE + 0)
@@ -320,6 +328,12 @@ struct pmbus_driver_info {
 	 * The following functions map manufacturing specific register values
 	 * to PMBus standard register values. Specify only if mapping is
 	 * necessary.
+	 * Function return the register value (read) or zero (write) if
+	 * successful. A return value of -ENODATA indicates that there is no
+	 * manufacturer specific register, but that a standard PMBus register
+	 * may exist. Any other negative return value indicates that the
+	 * register does not exist, and that no attempt should be made to read
+	 * the standard register.
 	 */
 	int (*read_byte_data)(struct i2c_client *client, int page, int reg);
 	int (*read_word_data)(struct i2c_client *client, int page, int reg);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
