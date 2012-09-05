From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Sep 2012 02:03:26 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: Remove legacy sysfs attributes for chassis intrusion
Message-Id: <1346810610-26352-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Per feature-removal-schedule.txt:

What:	Legacy, non-standard chassis intrusion detection interface.
When:	June 2011
Why:	The adm9240, w83792d and w83793 hardware monitoring drivers have
	legacy interfaces for chassis intrusion detection. A standard
	interface has been added to each driver, so the legacy interface
	can be removed.

About time to actually do it.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
