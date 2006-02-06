From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 06 Feb 2006 05:52:50 +0000
Subject: [lm-sensors] [patch 1/1] hwmon-pc87360 : avoid lock & unlock when
Message-Id: <43E6E432.8030408@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From:  Jim Cromie <jim.cromie at gmail.com>

Modifies pc87360_update_device() to avoid locking & unlocking
when data is not actually being resampled.  Also re-indented
the body of the function, removing the now extra tabs.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

----

patch applies over:
linux-2.6.16-rc1-mm4
+ hwmon-pc87360-use-sensor-attr-2.patch
+ hwmon-pc87360-sysfs-combo-callbacks.patch

or without the 2 patches, with  (offset -34 lines).

$ diffstat hwmon-pc87360-lock-only-when-sampling.patch
 pc87360.c |  158 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 79 insertions(+), 79 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-lock-only-when-sampling.patch
Type: text/x-patch
Size: 6213 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060206/ebddd2e9/hwmon-pc87360-lock-only-when-sampling-0001.bin
