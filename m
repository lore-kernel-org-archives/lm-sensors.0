From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:29 +0000
Subject: [lm-sensors] [PATCH v2 0/15] hwmon: (pmbus) Patch series for 3.1
Message-Id: <1310608484-20678-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following set of patches for PMBus drivers is targeted for 3.1 integration.

Please note that the patchset already implements the proposed new sysfs
attributes, so the patch to extend the ABI is included in the patchset for
reference.

v2:
- Improved status register handling for virtual page support
- Updated documentation for various drivers to include added attributes
- Added documentation for LM25066 driver

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
