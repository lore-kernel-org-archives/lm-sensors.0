From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 10 Nov 2009 12:41:02 +0000
Subject: [lm-sensors] [PATCH v2 00/10] LIS3: Feature updates and corrections
Message-Id: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0236936903744804838=="
List-Id: <lm-sensors.vger.kernel.org>
To: eric.piel@tremplin-utc.net, daniel@caiaq.de, pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Samu Onkalo <samu.p.onkalo@nokia.com>

--===============0236936903744804838==
Content-Type: text/plain

This patch set has earlier been sent to lm-sensors list (thus patch v2).
No changes after that except to patch 0006 to make it applicable to
2.6.32-rc6 (no functional changes).

There has been discussion on lm-sensors list about the patch 
"lis3: Scale output values to mg (0009)". It causes changes to 
existing user space applications.
See link below about this discussion:
http://lists.lm-sensors.org/pipermail/lm-sensors/2009-November/027101.html

Patches are applicable to top of 2.6.32-RC6.

This patch set makes several changes to the lis3 accelerometer chip 
family driver. There are also two patches from Eric Piel.

I have possibility to test these changes only with 8 bit version (lis302d).
Since part of the changes are specific to 12 bit device, I would appreciate
if someone could try these on 12 bit device.

0001:
Sync event is sent after each measurement. This helps user space
applications to detect which 3 reported values belongs to
one atomic measurement.

0002:
polled input device was not totally released in module unload.
This corrects memory leak. 

0003:
This patch is originally from Eric Piel. 
Updates documentation and chip ID handling

0004:
This patch is originally from Eric Piel.
Correction to sampling rate handling for 8 bit devices

0005:
Chip power on sequence was not waiting for chip to be ready.
This caused incorrect values right after the power on.

0006:
Chip specifications contains selftest for the chip. This patch implements that.

0007:
Calibration functionality is removed from the driver. Chip is allready
calibrated by the manufacturer. SW calibration doesn't improve the situation.

0008:
Added possibility to set chip sampling rate. Position entry in sysfs
allows reading at sampling rate.

0009:
Scale output values to mg (1/1000 of earth gravity). (see comments above)

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



--===============0236936903744804838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0236936903744804838==--
