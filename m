From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 06:33:40 +0000
Subject: [lm-sensors] [PATCH 00/15] hwmon: (it87) Various enhancements and fixes
Message-Id: <1427697235-23566-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patch 1 and 2 are bug fixes.
Patch 3 and 4 are cleanup patches to simplify adding new chips to the driver.
Patch 5 adds support for IT8790E.
Patch 6 to 9 add and improve support for IT8620E.
Patch 10 adds support for the second pwm frequency configuration register
supported by recent ITE chips.
Patches 11 to 14 add support for a second Super-IO chip at SIO address 0x4e.
Patch 15 rearranges the code to avoid forward declarations.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
