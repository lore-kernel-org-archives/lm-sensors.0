From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 16:36:41 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (nct6775) Add support for NCT6102D/6106D
Message-Id: <1365871004-14448-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This series is the first cut to add support for NCT6102D/6106D to the nct6775
driver. It will rest in my staging branch for the time being. It is available
in the stand-alone driver at https://github.com/groeck/nct6775.

The series depends on the other patches submitted for the nct6775 driver.

I don't consider this code stable enough to include it upstream, but it is
in good enough shape to start testing it (ie it no longer crashes the system).
With luck, I might even get some review feedback.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
