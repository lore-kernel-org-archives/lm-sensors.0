From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:31 +0000
Subject: [lm-sensors] [PATCH 5/44] [PATCH] f71805f: Resource needs not be
Message-Id: <11510009063966-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

The F71805F I/O resource structure needs not be a global variable,
as the platform core allocs its own copy of it anyway.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/f71805f.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
index 885465d..fd72440 100644
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -99,10 +99,6 @@ #define REGION_LENGTH		2
 #define ADDR_REG_OFFSET		0
 #define DATA_REG_OFFSET		1
 
-static struct resource f71805f_resource __initdata = {
-	.flags	= IORESOURCE_IO,
-};
-
 /*
  * Registers
  */
@@ -782,6 +778,11 @@ static struct platform_driver f71805f_dr
 
 static int __init f71805f_device_add(unsigned short address)
 {
+	struct resource res = {
+		.start	= address,
+		.end	= address + REGION_LENGTH - 1,
+		.flags	= IORESOURCE_IO,
+	};
 	int err;
 
 	pdev = platform_device_alloc(DRVNAME, address);
@@ -791,10 +792,8 @@ static int __init f71805f_device_add(uns
 		goto exit;
 	}
 
-	f71805f_resource.start = address;
-	f71805f_resource.end = address + REGION_LENGTH - 1;
-	f71805f_resource.name = pdev->name;
-	err = platform_device_add_resources(pdev, &f71805f_resource, 1);
+	res.name = pdev->name;
+	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device resource addition failed "
 		       "(%d)\n", err);
-- 
1.4.0


