From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 24 Oct 2007 12:33:18 +0000
Subject: [lm-sensors] Patch: hwmon-abituguru3-identify-ip35-pro.patch
Message-Id: <471F3B8E.7000008@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050500060004080202060109"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050500060004080202060109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch changes the identification string for motherboards with an id of
0x001A from unknown to "Abit IP35 Pro". Thanks to James Scott who has an
Abit IP35 Pro.

Signed-off-by: j.w.r.degoede@hhs.nl

Regards,

Hans

--------------050500060004080202060109
Content-Type: text/x-patch;
 name="hwmon-abituguru3-identify-ip35-pro.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hwmon-abituguru3-identify-ip35-pro.patch"

Hi All,

This patch changes the identification string for motherboards with an id of
0x001A from unknown to "Abit IP35 Pro". Thanks to James Scott who has an
Abit IP35 Pro.

Signed-off-by: j.w.r.degoede@hhs.nl
diff -up linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c~ linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c
--- linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c~	2007-10-24 14:29:32.000000000 +0200
+++ linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c	2007-10-24 14:29:32.000000000 +0200
@@ -503,7 +503,7 @@ static const struct abituguru3_motherboa
 		{ "AUX3 FAN",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001A, "unknown", {
+	{ 0x001A, "Abit IP35 Pro", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },

--------------050500060004080202060109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050500060004080202060109--
