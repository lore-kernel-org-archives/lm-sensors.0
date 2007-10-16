From: Riku Voipio <riku.voipio@movial.fi>
Date: Tue, 16 Oct 2007 10:08:57 +0000
Subject: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071016100857.GA25544@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On thecus n2100, the bootloader does not setup fans to run. In order
to protect the user from frying their gear, start up fans on boot.

Depends on:

f75375s: Add new style bindings
f75375s: allow setting up fans with platform_data

patches sent to lm-sensors mailing list.

Signed-off-by: Riku Voipio <riku.voipio@movial.fi>
---
 arch/arm/mach-iop32x/n2100.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-iop32x/n2100.c b/arch/arm/mach-iop32x/n2100.c
index 1873bd8..5a4acff 100644
--- a/arch/arm/mach-iop32x/n2100.c
+++ b/arch/arm/mach-iop32x/n2100.c
@@ -16,6 +16,7 @@
 
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/f75375s.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -200,11 +201,21 @@ static struct platform_device n2100_serial_device = {
 	.resource	= &n2100_uart_resource,
 };
 
+static struct f75375s_platform_data n2100_f75375s = {
+	.pwm		= { 255, 255 },
+	.pwm_enable = { 0, 0 },
+};
+
 static struct i2c_board_info __initdata n2100_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("rtc-rs5c372", 0x32),
 		.type = "rs5c372b",
 	},
+	{
+		I2C_BOARD_INFO("f75375", 0x2e),
+		.type = "f75375",
+		.platform_data = &n2100_f75375s,
+	},
 };
 
 /*
-- 
1.5.3.1


-- 
"rm -rf" only sounds scary if you don't have backups

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
