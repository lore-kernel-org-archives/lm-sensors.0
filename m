From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 29 Jan 2009 09:09:08 +0000
Subject: [lm-sensors] [Patch] Fix typo in error output
Message-Id: <20090129090908.GA4410@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Removed trailing semicolon in error string.

Signed-off-by: Andre Prendel <andre_prendel@gmx.de>
---

--- lm-sensors-dev/prog/sensors/main.c	2009-01-28 18:12:18.000000000 +0100
+++ my-lm-sensors/prog/sensors/main.c	2009-01-28 22:01:14.000000000 +0100
@@ -179,7 +179,7 @@ static int do_a_set(const sensors_chip_n
 
 	if ((err = sensors_do_chip_sets(name))) {
 		if (err = -SENSORS_ERR_KERNEL) {
-			fprintf(stderr, "%s: %s;\n",
+			fprintf(stderr, "%s: %s\n",
 				sprintf_chip_name(name),
 				sensors_strerror(err));
 			fprintf(stderr, "Run as root?\n");

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
