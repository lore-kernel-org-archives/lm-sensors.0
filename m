From: Andrew Paprocki <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 10:40:08 +0000
Subject: [lm-sensors] [PATCH 1/4] hwmon: it87 support for 16-bit fan reading
Message-Id: <1215427211-6001-1-git-send-email-andrew@ishiboo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The it8705 chip supports 16-bit fan tachometers in revisions at least
>= 0x03 (Version G). This patch enables 16-bit fan readings on all
revisions >= 0x03 just like the it8712, it8716, and it8718 chips.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>
---
 Documentation/hwmon/it87 |    6 +++---
 drivers/hwmon/it87.c     |   19 ++++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index d931525..3496b70 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -6,7 +6,7 @@ Supported chips:
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/
+               http://www.ite.com.tw/product_info/file/pc/IT8705F_V.0.4.1.pdf
   * IT8712F
     Prefix: 'it8712'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -97,8 +97,8 @@ The IT8716F, IT8718F and later IT8712F revisions have support for
 The IT8716F and IT8718F, and late IT8712F and IT8705F also have optional
 16-bit tachometer counters for fans 1 to 3. This is better (no more fan
 clock divider mess) but not compatible with the older chips and
-revisions. For now, the driver only uses the 16-bit mode on the
-late IT8712F, IT8716F and IT8718F.
+revisions. The 16-bit tachometer mode is enabled by the driver when one
+of the above chips is detected.
 
 The IT8726F is just bit enhanced IT8716F with additional hardware
 for AMD power sequencing. Therefore the chip will appear as IT8716F
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 2a36568..30cdb09 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -272,9 +272,11 @@ struct it87_data {
 
 static inline int has_16bit_fans(const struct it87_data *data)
 {
-	/* IT8712F Datasheet 0.9.1, section 8.3.5 indicates 7h = Version I.
-	   This is the first revision with 16bit tachometer support. */
-	return (data->type = it8712 && data->revision >= 0x07)
+	/* IT8705F Datasheet 0.4.1, 3h = Version G.
+	   IT8712F Datasheet 0.9.1, section 8.3.5 indicates 7h = Version I.
+	   These are the first revisions with 16bit tachometer support. */
+	return (data->type = it87 && data->revision >= 0x03)
+	    || (data->type = it8712 && data->revision >= 0x07)
 	    || data->type = it8716
 	    || data->type = it8718;
 }
@@ -1370,10 +1372,13 @@ static void __devinit it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
-		if (tmp & (1 << 4))
-			data->has_fan |= (1 << 3);	/* fan4 enabled */
-		if (tmp & (1 << 5))
-			data->has_fan |= (1 << 4);	/* fan5 enabled */
+		/* IT8705F only supports three fans. */
+		if (data->type != it87) {
+			if (tmp & (1 << 4))
+				data->has_fan |= (1 << 3); /* fan4 enabled */
+			if (tmp & (1 << 5))
+				data->has_fan |= (1 << 4); /* fan5 enabled */
+		}
 	}
 
 	/* Set current fan mode registers and the default settings for the
-- 
1.5.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
