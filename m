From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 11:30:48 +0000
Subject: [lm-sensors] Re: [PATCH] hwmon : Fix W83627THF VID reading
Message-Id: <If7dVZfe.1132049812.6440050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB7@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch fixes the VID reading; no cpu0_vid and vrm files created if
> the chip is w83627thf and GPIO5 not enabled.
> Please check.

Looks good to me. I had to fix the patch manually this time again though.

I have done three minor edits to your patch, I hope you won't mind:

1* I think the following test:
+	if (kind != w83697hf &&
+		!(kind = w83627thf && data->vid = 0xff)) {
Can be simplified to:
+	if (kind != w83697hf && data->vid != 0xff)) {
Because data->vid can only have value 0xff for type w83627thf anyway.

2* In w83627thf_read_gpio5, I did:
-	sel = superio_inb(W83627THF_GPIO5_IOSR);
+	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
The datasheet suggests that the two unused bits of register CRF4
(W83627THF_GPIO5_DR) are always zero, but better safe than sorry.

3* I dropped "default" in that comment:
        /* Convert VID to voltage based on default VRM */
It's not more a default value, it's deduced from the CPU model.

I'll stack your patch and will get it into -mm soon so that it gets some
testing. It should then go into mainline for 2.6.16. Thanks for your
contribution!

While checking the W83627THF datasheet, I noticed that there is an
additional GPIO configuration register, CRF5, named "inversion
register". Wouldn't it make sense to check the value of this register
and make sure all pins supposedly used as VID inputs are not inverted?
Mark, can you please confirm that your system which does use GPIO5 for
VID would pass that test? Proposed patch attached, comments and testers
welcome.

Thanks,
--
Jean Delvare
-------------- next part --------------
Improve the W83627THF GPIO5 testing, so that we don't think these pins
are used as VID inputs when they cannot be. This is done by checking
that none of these pins are in inverted mode.
---

 drivers/hwmon/w83627hf.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1.orig/drivers/hwmon/w83627hf.c	2005-11-15 11:03:52.000000000 +0100
+++ linux-2.6.15-rc1/drivers/hwmon/w83627hf.c	2005-11-15 11:19:49.000000000 +0100
@@ -99,6 +99,7 @@
 #define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
 #define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
 #define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
+#define W83627THF_GPIO5_INV	0xf5 /* w83627thf only */
 
 static inline void
 superio_outb(int reg, int val)
@@ -1218,7 +1219,7 @@
 
 static int w83627thf_read_gpio5(struct i2c_client *client)
 {
-	int res = 0xff, sel;
+	int res = 0xff, sel, inv;
 
 	superio_enter();
 	superio_select(W83627HF_LD_GPIO5);
@@ -1232,7 +1233,8 @@
 	/* Make sure the pins are configured for input
 	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
 	sel = superio_inb(W83627THF_GPIO5_IOSR) & 0x3f;
-	if ((sel & 0x1f) != 0x1f) {
+	inv = superio_inb(W83627THF_GPIO5_INV) & 0x3f;
+	if ((sel & 0x1f) != 0x1f || (inv & sel) != 0x00) {
 		dev_dbg(&client->dev, "GPIO5 not configured for VID "
 			"function\n");
 		goto exit;
