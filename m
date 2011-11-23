From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 23 Nov 2011 19:30:50 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: (pmbus) PMBus patches for 3.3
Message-Id: <1322076654-5652-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The first patch adds device ID verification to the ADM1275 driver. Not strictly
necessary, but useful to prevent misconfigurations especially in test
environments.

The remaining patches improve support for Intersil devices. The second patch
adds support for ZL2005. The final two patches improve support for various BMR
devices, which are based on ZL2005 and ZL2008. Support for those devices is
moved from the generic PMBus driver to the Intersil (zl6100) driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
