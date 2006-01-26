From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 26 Jan 2006 19:27:58 +0000
Subject: [lm-sensors] [patch 1/2] hwmon/pc87360: use SENSOR_ATTR_2 instead
Message-Id: <43D922BE.8040801@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jim Cromie <jim.cromie at gmail.com>

hwmon-pc87360-use-sensor-attr-2.patch  converts SENSOR_ATTRs
to SENSOR_ATTR_2s,  and adds a bunch of #defines for the new member's 
values. 

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---

$ diffstat hwmon-pc87360-use-sensor-attr-2.patch
 pc87360.c |  492 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 277 insertions(+), 215 deletions(-)

The defines use different integers for each attr, which allows
all of the show_X handlers to also be combined in 1 big switch.
Im not doing so, but somebody might want to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-use-sensor-attr-2.patch
Type: text/x-patch
Size: 36103 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060126/20ecbda2/hwmon-pc87360-use-sensor-attr-2-0001.bin
