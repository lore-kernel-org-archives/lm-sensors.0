From: "Felten, Lothar" <l-felten@ti.com>
Date: Tue, 06 Aug 2013 16:47:45 +0000
Subject: Re: [lm-sensors] [PATCH] support tmp112
Message-Id: <28DAD847AEFDD344B2D3802E7670BEE116B91417@DNCE04.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <28DAD847AEFDD344B2D3802E7670BEE116B91384@DNCE04.ent.ti.com>
In-Reply-To: <28DAD847AEFDD344B2D3802E7670BEE116B91384@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Lothar,
>
> Signed-off is still at the end :)
That was me, I can fix that :)

>
> Also, looks like your mailer replaced all tabs with spaces, or your editor is set to do the same.
> checkpatch result is 'total: 5 errors, 8 warnings, 52 lines checked'
I ran checkpatch.pl, my editor is ok but outlook is probably not a good mail program.
I changed some settings... let's see...

>
> Please fix.
>
> Thanks,
> Guenter

Signed-off-by: l-felten@ti.com

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index 2560a9c..c6a5ff1 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -42,13 +42,14 @@ Supported chips:
     Addresses scanned: none
     Datasheet: Publicly available at the ST website
                http://www.st.com/internet/analog/product/121769.jsp
-  * Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175, TMP275
-    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp175', 'tmp75', 'tmp275'
+  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP175, TMP275
+    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp275'
     Addresses scanned: none
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/product/tmp100
                http://www.ti.com/product/tmp101
                http://www.ti.com/product/tmp105
+               http://www.ti.com/product/tmp112
                http://www.ti.com/product/tmp75
                http://www.ti.com/product/tmp175
                http://www.ti.com/product/tmp275
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e989f7f..4316313 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -652,8 +652,8 @@ config SENSORS_LM75
                - NXP's LM75A
                - ST Microelectronics STDS75
                - TelCom (now Microchip) TCN75
-               - Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175,
-                 TMP275
+               - Texas Instruments TMP100, TMP101, TMP105, TMP112,
+                  TMP175, TMP275, TMP75

          This driver supports driver model based binding through board
          specific I2C device tables.
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index c03b490..3fe54ac 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -49,6 +49,7 @@ enum lm75_type {              /* keep sorted in alphabetical order */
        tmp100,
        tmp101,
        tmp105,
+       tmp112,
        tmp175,
        tmp275,
        tmp75,
@@ -236,6 +237,12 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
                data->sample_time = HZ;
                clr_mask |= 1 << 7;             /* not one-shot mode */
                break;
+       case tmp112:
+               set_mask |= 3 << 5;             /* 12-bit mode */
+               clr_mask |= 1 << 7;             /* not one-shot mode */
+               data->resolution = 12;
+               data->sample_time = HZ / 4;
+               break;
        case tmp105:
        case tmp175:
        case tmp275:
@@ -306,6 +313,7 @@ static const struct i2c_device_id lm75_ids[] = {
        { "tmp100", tmp100, },
        { "tmp101", tmp101, },
        { "tmp105", tmp105, },
+       { "tmp112", tmp112, },
        { "tmp175", tmp175, },
        { "tmp275", tmp275, },
        { "tmp75", tmp75, },


Texas Instruments Belgium SA, Rond Point Schuman 6- Bo?te 5, 1040 Bruxelles. BCE: 0414.207.123. RPM Bruxelles. IBAN: BE83570121895615. Swift: CITIBEBX. TVA BE 0414.207.123



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
