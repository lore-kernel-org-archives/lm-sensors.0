From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 16 May 2006 18:06:37 +0000
Subject: [lm-sensors] [ patch 2/3 ] hwmon/pc87360 use SENSOR_ATTR_2 in
Message-Id: <446A14AD.4040207@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This patch converts SENSOR_ATTRs to SENSOR_ATTR_2s for all sysfs-callbacks.
Also adds a number of #define FN_$(SENSOR)_($ATTR)s which provide
symbolic values used in the sensor array initializations.  With this in 
place, we
have 2-D info in the attribute handed to the callbacks.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

$ diffstat hwmon-pc87360-use-sensor-attr-2.patch
 pc87360.c |  492 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 277 insertions(+), 215 deletions(-)

---

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-use-sensor-attr-2.patch
Type: text/x-patch
Size: 36103 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060516/ebc9ab56/hwmon-pc87360-use-sensor-attr-2-0001.bin
