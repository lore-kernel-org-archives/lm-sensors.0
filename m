From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 03:31:28 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: (pmbus) Final set of PMBus patches
Message-Id: <1316748692-8326-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch series adds support for LTC3880 and Lineage Power DC-DC
Power Modules to the PMBus driver.

The first patch adds support for a new virtual command to read peak values for
READ_TEMPERATURE2, as well as the matching attribute definition.

The second patch adds an explicit driver for LTC2978. This driver also adds
support for vendor-specific attributes by using the virtual command register
infrastructure introduced with commit 6f183d33a02e686608f708ef713b6423db39bcba.

The LTC2978 driver is then used in the third patch to add support for LTC3880.

The forth patch adds device IDs for Lineage Power Modules to the generic PMBus driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
