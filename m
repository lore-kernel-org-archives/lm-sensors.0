From: Andrew Paprocki <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 10:40:11 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: it87 force enable fans1-3 to
Message-Id: <1215427211-6001-4-git-send-email-andrew@ishiboo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch always forces fans1-3 to be enabled and logs a debug
message indicating the action. Certain BIOSes incorrectly report
connected fans as disabled. There is already a mechanism via
sensors.conf to ignore invalid inputs, so it is desired over
making the driver more complex with an optional module parameter.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
---
 Documentation/hwmon/it87 |    6 ++++++
 drivers/hwmon/it87.c     |   11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index 77196bf..f73f95f 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -91,8 +91,14 @@ the driver won't notice and report changes in the VID value. The two
 upper VID bits share their pins with voltage inputs (in5 and in6) so you
 can't have both on a given board.
 
+System BIOSes do not always properly enable fans1-3 which are actually
+connected. For this reason, fans1-3 will be forcefully enabled by the
+driver and any disconnected fans should be ignored in sensors.conf.
+
 The IT8716F, IT8718F and later IT8712F revisions have support for
 2 additional fans. The additional fans are supported by the driver.
+These fans are not forced on by the driver because there is no known
+cases of chips incorrectly reporting their status.
 
 The IT8716F and IT8718F, and late IT8712F and IT8705F also have optional
 16-bit tachometer counters for fans 1 to 3. This is better (no more fan
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index b7b9b58..14143bf 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1417,10 +1417,15 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 
 	/* Check if tachometers are reset manually or by some reason */
 	data->fan_main_ctrl = it87_read_value(data, IT87_REG_FAN_MAIN_CTRL);
-	if ((data->fan_main_ctrl & 0x70) = 0) {
-		/* Enable all fan tachometers */
+	if ((data->fan_main_ctrl & 0x70) = 0
+	 || (data->fan_main_ctrl & 0x70) != 0x70) {
+		/* Enable all fan tachometers if not all were enabled.
+		   BIOS configuration is sometimes wrong, unused fans
+		   should be disabled in sensors.conf. */
+		dev_dbg(&pdev->dev, "Forcing fan1-3 enabled\n");
 		data->fan_main_ctrl |= 0x70;
-		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL, data->fan_main_ctrl);
+		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+				 data->fan_main_ctrl);
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
-- 
1.5.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
