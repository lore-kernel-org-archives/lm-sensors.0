From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 21 Apr 2011 13:35:18 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon/sch5627: Add a
Message-Id: <1303392919-3667-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5627.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 9a51dcc..09a47bf 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -140,7 +140,7 @@ static inline void superio_exit(int base)
 	release_region(base, 2);
 }
 
-static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
+static int sch5627_send_cmd(struct sch5627_data *data, u8 cmd, u16 reg, u8 v)
 {
 	u8 val;
 	int i;
@@ -163,10 +163,14 @@ static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
 	outb(0x80, data->addr + 3);
 
 	/* Write Request Packet Header */
-	outb(0x02, data->addr + 4); /* Access Type: VREG read */
+	outb(cmd, data->addr + 4); /* VREG Access Type read:0x02 write:0x03 */
 	outb(0x01, data->addr + 5); /* # of Entries: 1 Byte (8-bit) */
 	outb(0x04, data->addr + 2); /* Mailbox AP to first data entry loc. */
 
+	/* Write Value field */
+	if (cmd = 0x03)
+		outb(v, data->addr + 4);
+
 	/* Write Address field */
 	outb(reg & 0xff, data->addr + 6);
 	outb(reg >> 8, data->addr + 7);
@@ -224,8 +228,22 @@ static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
 	 * But if we do that things don't work, so let's not.
 	 */
 
-	/* Read Data from Mailbox */
-	return inb(data->addr + 4);
+	/* Read Value field */
+	if (cmd = 0x02)
+		return inb(data->addr + 4);
+
+	return 0;
+}
+
+static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
+{
+	return sch5627_send_cmd(data, 0x02, reg, 0);
+}
+
+static int sch5627_write_virtual_reg(struct sch5627_data *data,
+				     u16 reg, u8 val)
+{
+	return sch5627_send_cmd(data, 0x03, reg, val);
 }
 
 static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
-- 
1.7.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
