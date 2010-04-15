From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Thu, 15 Apr 2010 10:34:07 +0000
Subject: [lm-sensors] [PATCH 0/1] BH1770GLC / SFH7770 combined ambient light
Message-Id: <1271327648-13497-1-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>

This patch introduces driver for Rohm BH1770GLC and Osram SFH7770
combined ambient light and proximity sensor.

Driver is divided to 3 parts. Core-part contains common functionality for
both parts of the chips. ALS and PS specific functionalities are
in separate files.

ALS part is fully based on threshold interrupts. Driver doesn't provide
direct control for threshold levels. Instead, based on sensitivity setting,
threshold levels are updated after every interrupt. This method keeps sensor
to follow changes in the lightning.

PS part uses interrupt for high threshold events and delayed work to simulate
missing low threshold interrupts. This way driver is able to react proximity
on / off events using only high threshold interrupt. Proximity sensing can
utilize up to 3 IR leds for movement detection. Driver supports 1-3 leds
configurations.

Platform data is used to provide IR led configuration: number of channels and
absolute maximum operating currents for the leds.

Chip is kept running only when someone keeps device handles open.
Otherwise chip is powered down and optionally power supplies are turned off.

Interfaces:
Both parts of the driver provides results via separate misc char device.

sysfs interface:
als_calib - (RW) calibration coeffient (default is neutral value)
als_mode  - (R)  returns current chip operational state for ALS
als_rate  - (RW) ALS side measurement rate in ms
als_sens  - (RW) sensitivity for changes in lightning level
ps_calib  - (RW) calibration coeffient
ps_leds   - (RW) IR led currents in mA
ps_mode   - (R)  returns current chip operational state for PS
ps_rate   - (RW) PS side measurement rates (separate rates for below /
	         above threshold condition)
ps_threshold - (RW) threshold levels
chip_id   - (R)  chip version and revision information

Tested in top of 2.6.32 kernel. Applies to 2.6.34-RC3.

Samu Onkalo (1):
  misc: bh1770glc: Driver for bh1770glc combined als and ps sensor

 drivers/misc/Kconfig          |   12 +
 drivers/misc/Makefile         |    3 +
 drivers/misc/bh1770glc.h      |  169 ++++++++++++
 drivers/misc/bh1770glc_als.c  |  424 +++++++++++++++++++++++++++++
 drivers/misc/bh1770glc_core.c |  301 +++++++++++++++++++++
 drivers/misc/bh1770glc_ps.c   |  585 +++++++++++++++++++++++++++++++++++++++++
 include/linux/bh1770glc.h     |   39 +++
 7 files changed, 1533 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/bh1770glc.h
 create mode 100644 drivers/misc/bh1770glc_als.c
 create mode 100644 drivers/misc/bh1770glc_core.c
 create mode 100644 drivers/misc/bh1770glc_ps.c
 create mode 100644 include/linux/bh1770glc.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
