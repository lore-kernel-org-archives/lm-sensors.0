From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <20040225111219.1c117787.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
Thanks Jean for your works and kind advices.
I'll go on the next step.

My second proposal for it87 is adding 'reset' option and do not reset
the registers unless users really want to do. It's the same behavior
as it87 of kernel2.4.
If 'smart guardian' was enabled by BIOS, resetting registers makes all
fans go to full power, very noisy.
Resetting registers is, I think, not required for normal use.

Here's the small patch.

--- linux/drivers/i2c/chips/it87.c.sensor_type	2004-02-18 11:21:16.000000000 +0900
+++ linux/drivers/i2c/chips/it87.c	2004-02-19 11:25:12.977638078 +0900
@@ -58,4 +58,7 @@
 static int update_vbat = 0;
 
+/* Reset the registers on init */
+static int reset = 0;
+
 /* Many IT87 constants specified below */
 
@@ -828,5 +831,7 @@
 	/* Reset all except Watchdog values and last conversion values
 	   This sets fan-divs to 2, among others */
-	it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	if ( reset ) {
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	}
 	it87_write_value(client, IT87_REG_VIN_MIN(0),
 			 IN_TO_REG(IT87_INIT_IN_MIN_0));
@@ -989,4 +994,6 @@
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup
value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 

Thanks in advance.
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
