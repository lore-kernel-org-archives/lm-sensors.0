From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 19:06:47 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru3-new-motherboards.patch
Message-Id: <47190047.6020803@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010000070705070507030005"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010000070705070507030005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mark & All,

This patch adds support for 2 new motherboards to the abituguru3 driver. Its a 
pretty trivial patch and it would be nice if this could make 2.6.24.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Thnaks & Regards,

Hans

--------------010000070705070507030005
Content-Type: text/x-patch;
 name="hwmon-abituguru3-new-motherboards.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hwmon-abituguru3-new-motherboards.patch"

This patch adds support for 2 new motherboards to the abituguru3 driver.

Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c~ linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c
--- linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c~	2007-10-19 21:01:23.000000000 +0200
+++ linux-2.6.23.x86_64/drivers/hwmon/abituguru3.c	2007-10-19 21:01:23.000000000 +0200
@@ -530,6 +530,58 @@ static const struct abituguru3_motherboa
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
+	{ 0x001B, "unknown", {
+		{ "CPU Core",		 0, 0, 10, 1, 0 },
+		{ "DDR3",		 1, 0, 20, 1, 0 },
+		{ "DDR3 VTT",		 2, 0, 10, 1, 0 },
+		{ "CPU VTT",		 3, 0, 10, 1, 0 },
+		{ "MCH 1.25V",		 4, 0, 10, 1, 0 },
+		{ "ICHIO 1.5V",		 5, 0, 10, 1, 0 },
+		{ "ICH 1.05V",		 6, 0, 10, 1, 0 },
+		{ "ATX +12V (24-Pin)",	 7, 0, 60, 1, 0 },
+		{ "ATX +12V (8-pin)",	 8, 0, 60, 1, 0 },
+		{ "ATX +5V",		 9, 0, 30, 1, 0 },
+		{ "+3.3V",		10, 0, 20, 1, 0 },
+		{ "5VSB",		11, 0, 30, 1, 0 },
+		{ "CPU",		24, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
+		{ "PWM Phase1",		26, 1, 1, 1, 0 },
+		{ "PWM Phase2",		27, 1, 1, 1, 0 },
+		{ "PWM Phase3",		28, 1, 1, 1, 0 },
+		{ "PWM Phase4",		29, 1, 1, 1, 0 },
+		{ "PWM Phase5",		30, 1, 1, 1, 0 },
+		{ "CPU Fan",		32, 2, 60, 1, 0 },
+		{ "SYS Fan",		34, 2, 60, 1, 0 },
+		{ "AUX1 Fan",		33, 2, 60, 1, 0 },
+		{ "AUX2 Fan",		35, 2, 60, 1, 0 },
+		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
+	},
+	{ 0x001C, "unknown", {
+		{ "CPU Core",		 0, 0, 10, 1, 0 },
+		{ "DDR2",		 1, 0, 20, 1, 0 },
+		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },
+		{ "CPU VTT",		 3, 0, 10, 1, 0 },
+		{ "MCH 1.25V",		 4, 0, 10, 1, 0 },
+		{ "ICHIO 1.5V",		 5, 0, 10, 1, 0 },
+		{ "ICH 1.05V",		 6, 0, 10, 1, 0 },
+		{ "ATX +12V (24-Pin)",	 7, 0, 60, 1, 0 },
+		{ "ATX +12V (8-pin)",	 8, 0, 60, 1, 0 },
+		{ "ATX +5V",		 9, 0, 30, 1, 0 },
+		{ "+3.3V",		10, 0, 20, 1, 0 },
+		{ "5VSB",		11, 0, 30, 1, 0 },
+		{ "CPU",		24, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
+		{ "PWM Phase1",		26, 1, 1, 1, 0 },
+		{ "PWM Phase2",		27, 1, 1, 1, 0 },
+		{ "PWM Phase3",		28, 1, 1, 1, 0 },
+		{ "PWM Phase4",		29, 1, 1, 1, 0 },
+		{ "PWM Phase5",		30, 1, 1, 1, 0 },
+		{ "CPU Fan",		32, 2, 60, 1, 0 },
+		{ "SYS Fan",		34, 2, 60, 1, 0 },
+		{ "AUX1 Fan",		33, 2, 60, 1, 0 },
+		{ "AUX2 Fan",		35, 2, 60, 1, 0 },
+		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
+	},
 	{ 0x0000, NULL, { { NULL, 0, 0, 0, 0, 0 } } }
 };
 

--------------010000070705070507030005
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010000070705070507030005--
