From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:22:41 +0000
Subject: [lm-sensors] [PATCH 00/95] hwmon: Convert hwmon drivers to use devm_ functions
Message-Id: <1339773856-3443-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert most of the hwmon drivers to use devm_ functions to reduce code size
and simplify the code.

Overall code size reduction on a x86_64 target with allmodconfig is
approximately 15k.

Plan is to push the patches into my hwmon-staging branch for the time being.
If I get an Acked-by or Reviewed-by from a maintainer or from some other
interested party, I will move the respective patch to my hwmon-next branch,
for inclusion into 3.6. I will do the same for other patches if I think the
change is low risk, and if I can at least compile test it.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
