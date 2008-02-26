From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 26 Feb 2008 18:34:48 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru3-aw8d.patch
Message-Id: <47C45BC8.1030504@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050209070300060401010707"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050209070300060401010707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

This patch identifies the Abit AW8D board as such, and adds support for its
aux5 fan connector

signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

p.s.

It would be nice if this could make 2.6.25, its really a bugfix.

--------------050209070300060401010707
Content-Type: text/plain;
 name="hwmon-abituguru3-aw8d.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-abituguru3-aw8d.patch"

This patch identifies the Abit AW8D board as such, and adds support for its
aux5 fan connector

signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

diff -up vanilla-2.6.25-rc2-git7/drivers/hwmon/abituguru3.c.orig vanilla-2.6.25-rc2-git7/drivers/hwmon/abituguru3.c
--- vanilla-2.6.25-rc2-git7/drivers/hwmon/abituguru3.c.orig	2008-02-26 16:32:27.000000000 +0100
+++ vanilla-2.6.25-rc2-git7/drivers/hwmon/abituguru3.c	2008-02-26 19:26:53.000000000 +0100
@@ -323,7 +323,7 @@ static const struct abituguru3_motherboa
 		{ "AUX1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0013, "unknown", {
+	{ 0x0013, "Abit AW8D", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },
@@ -349,6 +349,7 @@ static const struct abituguru3_motherboa
 		{ "AUX2 Fan",		36, 2, 60, 1, 0 },
 		{ "AUX3 Fan",		37, 2, 60, 1, 0 },
 		{ "AUX4 Fan",		38, 2, 60, 1, 0 },
+		{ "AUX5 Fan",		39, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
 	{ 0x0014, "Abit AB9 Pro", {

--------------050209070300060401010707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050209070300060401010707--
