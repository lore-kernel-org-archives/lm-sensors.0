From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 18:34:41 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon/lm85: Fixes and improvements
Message-Id: <20070705203441.353fe5db@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes a 5-piece patchset for the lm85 hardware monitoring driver.

[PATCH 1/5] hwmon/lm85: Use dynamic sysfs callbacks
[PATCH 2/5] hwmon/lm85: Export in5, in6 and in7 voltage channels
[PATCH 3/5] hwmon/lm85: Add individual alarm files
[PATCH 4/5] hwmon/lm85: Clean up the handling of additional resolution bits
[PATCH 5/5] hwmon/lm85: Let the user set the fan min limit to 0

Once more, thanks go to Bernardo Motta and Observit for donating a
motherboard with an SMSC EMC6D102 chip, which made it possible for me
to write and test these patches.

Reviewers and testers are of course welcome. In particular, I couldn't
test patch 2 as it affects only the SMSC EMC6D100, and patch 4 affects
the ADM1027 and ADT7463, which I do not have either.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
