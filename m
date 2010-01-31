From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 31 Jan 2010 21:52:00 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Request I/O ports
Message-Id: <20100131225200.537b29e9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Different motherboards have different PNP declarations for
W83781D/W83782D chips. Some declare the whole range of I/O ports (8
ports), some declare only the useful ports (2 ports at offset 5) and
some declare fancy ranges, for example 4 ports at offset 4. To
properly handle all cases, request all ports individually for probing.
After we have determined that we really have a W83781D or W83782D
chip, the useful port range will be requested again, as a single
block.

I did not see a board which needs this yet, but I know of one for lm78
driver and I'd like to keep the logic of these two drivers in sync.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@kernel.org
---
 drivers/hwmon/w83781d.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/w83781d.c	2009-12-18 08:34:09.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/w83781d.c	2010-01-17 20:20:25.000000000 +0100
@@ -1793,17 +1793,17 @@ static int __init
 w83781d_isa_found(unsigned short address)
 {
 	int val, save, found = 0;
+	int port;
 
-	/* We have to request the region in two parts because some
-	   boards declare base+4 to base+7 as a PNP device */
-	if (!request_region(address, 4, "w83781d")) {
-		pr_debug("w83781d: Failed to request low part of region\n");
-		return 0;
-	}
-	if (!request_region(address + 4, 4, "w83781d")) {
-		pr_debug("w83781d: Failed to request high part of region\n");
-		release_region(address, 4);
-		return 0;
+	/* Some boards declare base+0 to base+7 as a PNP device, some base+4
+	 * to base+7 and some base+5 to base+6. So we better request each port
+	 * individually for the probing phase. */
+	for (port = address; port < address + W83781D_EXTENT; port++) {
+		if (!request_region(port, 1, "w83781d")) {
+			pr_debug("w83781d: Failed to request port 0x%x\n",
+				 port);
+			goto release;
+		}
 	}
 
 #define REALLY_SLOW_IO
@@ -1877,8 +1877,8 @@ w83781d_isa_found(unsigned short address
 			val = 0x30 ? "W83782D" : "W83781D", (int)address);
 
  release:
-	release_region(address + 4, 4);
-	release_region(address, 4);
+	for (port--; port >= address; port--)
+		release_region(port, 1);
 	return found;
 }
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
