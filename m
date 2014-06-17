From: "Zhu, Richard (NSN - CN/Beijing)" <richard.zhu@nsn.com>
Date: Tue, 17 Jun 2014 07:16:55 +0000
Subject: [lm-sensors] [PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages
Message-Id: <E9BC5E534B6C564CA4B01BC388FD1B5A34410C6A@SGSIMBX007.nsn-intra.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

When I was trouble shooting the TI power manager chip TPS40422, I found that the kernel pmbus driver (pmbus.c) was not trying to detect the temperature sensors other than page 0 for pmbus devices, so the temp2_input file couldn't be seen in sysfs. So I made a patch file to trying to solve the problem. Please help to review my findings, and to see if the patch can go to the upstream.


The following content is the content of the patch file:
[PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages

For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
page 1 of the chip, but the original driver only tried to detect this command on
page 0, this will lead to a result that the temperature sensor in page 1 couldn't
be detected. This change is finding the temperature sensors on all pages to solve
the problem.

Signed-off-by: Zhu Laiwen <richard.zhu@nsn.com>

--- a/drivers/hwmon/pmbus/pmbus.c	2013-07-01 00:13:29.000000000 +0200
+++ b/drivers/hwmon/pmbus/pmbus.c	2014-06-16 05:26:28.388304000 +0200
@@ -59,20 +59,19 @@ static void pmbus_find_sensor_groups(str
 		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
 			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
 	}
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1))
-		info->func[0] |= PMBUS_HAVE_TEMP;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
-		info->func[0] |= PMBUS_HAVE_TEMP2;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
-		info->func[0] |= PMBUS_HAVE_TEMP3;
-	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
-			     | PMBUS_HAVE_TEMP3)
-	    && pmbus_check_byte_register(client, 0,
-					 PMBUS_STATUS_TEMPERATURE))
-			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
-
 	/* Sensors detected on all pages */
 	for (page = 0; page < info->pages; page++) {
+		if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1))
+			info->func[page] |= PMBUS_HAVE_TEMP;
+		if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
+			info->func[page] |= PMBUS_HAVE_TEMP2;
+		if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
+			info->func[page] |= PMBUS_HAVE_TEMP3;
+		if (info->func[page] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+					| PMBUS_HAVE_TEMP3)
+			&& pmbus_check_byte_register(client, 0,
+					 PMBUS_STATUS_TEMPERATURE))
+			info->func[page] |= PMBUS_HAVE_STATUS_TEMP;
 		if (pmbus_check_word_register(client, page, PMBUS_READ_VOUT)) {
 			info->func[page] |= PMBUS_HAVE_VOUT;
 			if (pmbus_check_byte_register(client, page,

Regards,
Richard

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
