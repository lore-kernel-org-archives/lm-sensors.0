From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 14:36:10 +0000
Subject: [lm-sensors] [PATCH 0/7] hwmon: it87 patch series
Message-Id: <1349966177-25985-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This series started with the idea of adding temperature offset registers.
It ended with fixing all checkpatch warnings and errors, and reducing
object file size by approximately 2k on x86_64.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
