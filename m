From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 11 May 2011 12:31:40 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon/sch5627: Add sch5627_send_cmd
Message-Id: <1305117101-4325-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch generalizes sch5627_read_virtual_reg so that it can
be used to write virtual regs too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5627.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 9a51dcc..d785a2c 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -52,6 +52,9 @@
 #define SCH5627_COMPANY_ID		0x5c
 #define SCH5627_PRIMARY_ID		0xa0
 
+#define SCH5627_CMD_READ		0x02
+#define SCH5627_CMD_WRITE		0x03
+
 #define SCH5627_REG_BUILD_CODE		0x39
 #define SCH5627_REG_BUILD_ID		0x3a
 #define SCH5627_REG_HWMON_ID		0x3c
@@ -140,7 +143,7 @@ static inline void superio_exit(int base)
 	release_region(base, 2);
 }
 
-static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
+static int sch5627_send_cmd(struct sch5627_data *data, u8 cmd, u16 reg, u8 v)
 {
 	u8 val;
 	int i;
@@ -163,10 +166,14 @@ static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
 	outb(0x80, data->addr + 3);
 
 	/* Write Request Packet Header */
-	outb(0x02, data->addr + 4); /* Access Type: VREG read */
+	outb(cmd, data->addr + 4); /* VREG Access Type read:0x02 write:0x03 */
 	outb(0x01, data->addr + 5); /* # of Entries: 1 Byte (8-bit) */
 	outb(0x04, data->addr + 2); /* Mailbox AP to first data entry loc. */
 
+	/* Write Value field */
+	if (cmd = SCH5627_CMD_WRITE)
+		outb(v, data->addr + 4);
+
 	/* Write Address field */
 	outb(reg & 0xff, data->addr + 6);
 	outb(reg >> 8, data->addr + 7);
@@ -224,8 +231,16 @@ static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
 	 * But if we do that things don't work, so let's not.
 	 */
 
-	/* Read Data from Mailbox */
-	return inb(data->addr + 4);
+	/* Read Value field */
+	if (cmd = SCH5627_CMD_READ)
+		return inb(data->addr + 4);
+
+	return 0;
+}
+
+static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
+{
+	return sch5627_send_cmd(data, SCH5627_CMD_READ, reg, 0);
 }
 
 static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
-- 
1.7.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
