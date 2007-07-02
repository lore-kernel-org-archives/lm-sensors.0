From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 02 Jul 2007 20:59:03 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru3-detect.patch
Message-Id: <4689694A.3040708@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000707050904020702010506"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707050904020702010506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All, Mark,

Mark, this fixes the abituguru3 driver not detecting the uguru3 on some 
motherboards without the force=1 parameter, see:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=220160

Can you apply this to your testing tree please? Thanks!

Regards,

Hans

--------------000707050904020702010506
Content-Type: text/x-patch;
 name="hwmon-abituguru3-detect.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-abituguru3-detect.patch"

This patch changes the driver to also detect uguru3's which hold 0x08 at DATA
initially, as has been reported here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=220160

Also when an uguru3's holds 0x0014 in the ID register it will now report 
"Abit AB9 Pro" as motherboard identification.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/abituguru3.c~ linux-2.6.22-rc4/drivers/hwmon/abituguru3.c
--- linux-2.6.22-rc4/drivers/hwmon/abituguru3.c~	2007-07-02 22:21:23.000000000 +0200
+++ linux-2.6.22-rc4/drivers/hwmon/abituguru3.c	2007-07-02 22:21:23.000000000 +0200
@@ -351,7 +351,7 @@ static const struct abituguru3_motherboa
 		{ "AUX4 Fan",		38, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0014, "unknown", {
+	{ 0x0014, "Abit AB9 Pro", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -1053,12 +1053,13 @@ static struct platform_driver abituguru3
 
 static int __init abituguru3_detect(void)
 {
-	/* See if there is an uguru3 there. An idle uGuru3 will hold 0x00
-	   at DATA and 0xAC at CMD. Sometimes the uGuru3 will hold 0x05 at
-	   CMD instead, why is unknown. So we test for 0x05 too. */
+	/* See if there is an uguru3 there. An idle uGuru3 will hold 0x00 or
+	   0x08 at DATA and 0xAC at CMD. Sometimes the uGuru3 will hold 0x05
+	   at CMD instead, why is unknown. So we test for 0x05 too. */
 	u8 data_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_DATA);
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
-	if ((data_val == 0x00) && ((cmd_val == 0xAC) || (cmd_val == 0x05)))
+	if (((data_val == 0x00) || (data_val == 0x08)) &&
+			((cmd_val == 0xAC) || (cmd_val == 0x05)))
 		return ABIT_UGURU3_BASE;
 
 	ABIT_UGURU3_DEBUG("no Abit uGuru3 found, data = 0x%02X, cmd = "

--------------000707050904020702010506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000707050904020702010506--
