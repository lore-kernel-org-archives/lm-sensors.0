From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 17 Sep 2008 22:23:09 +0000
Subject: [lm-sensors] [PATCH 2/5] hwmon: applesmc: Fix the 'wait status
Message-Id: <48D1834D.5090406@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Boichat <nicolas@boichat.ch>, lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

On many Macbooks since mid 2007, the Pro, C2D and Air models, applesmc
fails to read some or all SMC ports. This problem has various effects,
such as flooded logfiles, malfunctioning temperature sensors,
accelerometers failing to initialize, and difficulties getting
backlight functionality to work properly.

The root of the problem seems to be the command protocol. The current
code sends out a command byte, then repeatedly polls for an ack before
continuing to send or recieve data. From experiments leading to this
patch, it seems the command protocol never quite worked or changed so
that one now sends a command byte, waits a little bit, polls for an
ack, and if it fails, repeats the whole thing by sending the command
byte again.

This patch implements a send_command function according to the new
interpretation of the protocol, and should work also for earlier
models.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hwmon/applesmc.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index b401975..9a43c4b 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -191,6 +191,26 @@ static int __wait_status(u8 val)
 }

 /*
+ * special treatment of command port - on newer macbooks, it seems necessary
+ * to resend the command byte before polling the status again. Callers must
+ * hold applesmc_lock.
+ */
+static int send_command(u8 cmd)
+{
+	int i;
+	for (i = 0; i < 1000; i++) {
+		outb(cmd, APPLESMC_CMD_PORT);
+		udelay(5);
+		if ((inb(APPLESMC_CMD_PORT) & APPLESMC_STATUS_MASK) = 0x0c)
+			return 0;
+		udelay(5);
+	}
+	printk(KERN_WARNING "applesmc: command failed: %x -> %x\n",
+		cmd, inb(APPLESMC_CMD_PORT));
+	return -EIO;
+}
+
+/*
  * applesmc_read_key - reads len bytes from a given key, and put them in buffer.
  * Returns zero on success or a negative error on failure. Callers must
  * hold applesmc_lock.
@@ -205,8 +225,7 @@ static int applesmc_read_key(const char* key, u8* buffer, u8 len)
 		return -EINVAL;
 	}

-	outb(APPLESMC_READ_CMD, APPLESMC_CMD_PORT);
-	if (__wait_status(0x0c))
+	if (send_command(APPLESMC_READ_CMD))
 		return -EIO;

 	for (i = 0; i < 4; i++) {
@@ -249,8 +268,7 @@ static int applesmc_write_key(const char* key, u8* buffer, u8 len)
 		return -EINVAL;
 	}

-	outb(APPLESMC_WRITE_CMD, APPLESMC_CMD_PORT);
-	if (__wait_status(0x0c))
+	if (send_command(APPLESMC_WRITE_CMD))
 		return -EIO;

 	for (i = 0; i < 4; i++) {
@@ -284,8 +302,7 @@ static int applesmc_get_key_at_index(int index, char* key)
 	readkey[2] = index >> 8;
 	readkey[3] = index;

-	outb(APPLESMC_GET_KEY_BY_INDEX_CMD, APPLESMC_CMD_PORT);
-	if (__wait_status(0x0c))
+	if (send_command(APPLESMC_GET_KEY_BY_INDEX_CMD))
 		return -EIO;

 	for (i = 0; i < 4; i++) {
@@ -315,8 +332,7 @@ static int applesmc_get_key_type(char* key, char* type)
 {
 	int i;

-	outb(APPLESMC_GET_KEY_TYPE_CMD, APPLESMC_CMD_PORT);
-	if (__wait_status(0x0c))
+	if (send_command(APPLESMC_GET_KEY_TYPE_CMD))
 		return -EIO;

 	for (i = 0; i < 4; i++) {
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
