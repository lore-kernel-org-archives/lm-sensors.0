From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:09:35 +0000
Subject: [lm-sensors] [RFC PATCH 00/10] LIS3: Feature updates and corrections
Message-Id: <1257250185-7929-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1680200939995204613=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1680200939995204613==
Content-Type: text/plain

This patch set makes several changes to the lis3 accelerometer chip family
driver. There are also two patches from Eric Piel.
He may want to still adjust those, but I attached patches to this set
because my changes are done to top of them.

I have possibility to test these changes only with 8 bit version (lis302d).
Since part of the changes are specific to 12 bit device, I would appreciate
if someone could try these on 12 bit device.

0001:
Sync event is sent after each measurement. This helps user space applications
to detect which 3 reported values belongs to one atomic measurement.

0002:
polled input device was not totally released in module unload. This corrects
memory leak. 

0003:
This patch is originally from Eric Piel. Updates documentation and chip ID
handling

0004:
This patch is originally from Eric Piel. Correction to sampling rate handling
for 8 bit devices

0005:
Chip power on sequence was not waiting for chip to be ready. This caused
incorrect values right after the power on.

0006:
Chip specifications contains selftest for the chip. This patch implements that.

0007:
Calibration functionality is removed from the driver. Chip is allready
calibrated by the manufacturer. SW calibration doesn't improve the situation.

0008:
Added possibility to set chip sampling rate. position entry in sysfs allows
reading at sampling rate.

0009:
Scale output values to mg (1/1000 of earth gravity).

0010:
Updates documentation

Samu Onkalo (8):
  LIS3LV02D: Send sync event
  LIS3LV02D: Correct memory leak in module unload
  LIS3LV02D: Proper power on sequence
  LIS3LV02D: Selftest support
  LIS3LV02D: Remove calibaration functionality
  lis3: Sysfs entry for setting chip measurement rate
  lis3: Scale output values to mg
  LIS3: Update documentation to match latest changes

������ric Piel (2):
  lis3: Update documentation and comments
  lis3: fix show rate for 8 bits chips

 Documentation/hwmon/lis3lv02d |   40 ++++---
 drivers/hwmon/Kconfig         |   22 ++--
 drivers/hwmon/lis3lv02d.c     |  234 +++++++++++++++++++++++++++++++----------
 drivers/hwmon/lis3lv02d.h     |   48 ++++++---
 include/linux/lis3lv02d.h     |    2 +
 5 files changed, 249 insertions(+), 97 deletions(-)



--===============1680200939995204613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1680200939995204613==--
