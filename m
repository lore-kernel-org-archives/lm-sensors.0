From: David Brownell <david-b@pacbell.net>
Date: Mon, 17 Sep 2007 20:50:24 +0000
Subject: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When "i2cdetect -F" says "SMBus PEC", it's extremely misleading.  The
issue is whether or not PEC has *HARDWARE* support, not whether PEC
itself is supported.  (PEC is portably implemented in software.)

--- lm_sensors-2.10.4.orig/prog/detect/i2cdetect.c
+++ lm_sensors-2.10.4/prog/detect/i2cdetect.c
@@ -147,7 +147,7 @@ static const struct func all_func[] = {
 	{ .value = I2C_FUNC_SMBUS_BLOCK_PROC_CALL,
 	  .name = "SMBus Block Process Call" },
 	{ .value = I2C_FUNC_SMBUS_HWPEC_CALC,
-	  .name = "SMBus PEC" },
+	  .name = "SMBus PEC in Hardware" },
 	{ .value = I2C_FUNC_SMBUS_WRITE_I2C_BLOCK,
 	  .name = "I2C Block Write" },
 	{ .value = I2C_FUNC_SMBUS_READ_I2C_BLOCK,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
