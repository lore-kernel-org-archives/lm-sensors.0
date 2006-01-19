From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 19 Jan 2006 23:32:58 +0000
Subject: [lm-sensors] [patch 1/X] pc87360: use SENSOR_ATTR_2 instead of
Message-Id: <43D021AA.1010308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Patch replaces all uses of SENSOR_ATTR with SENSOR_ATTR_2 in hwmon/pc87360.c
This yields a tiny (0.5%) shrink in the object size, (so its justifiable
by itself), but more importantly, it sets us up to consolidate many of the
show|set_*_* callbacks into a much smaller number of them.

It depends upon hwmon-sensor-attr-array-2.patch

   text    data     bss     dec     hex filename
  12114    3144      16   15274    3baa 
a2-pc-0/drivers/hwmon/pc87360.ko   <--- 16-rc1-mm1 + deps
  12046    3144      16   15206    3b66 a2-pc-1/drivers/hwmon/pc87360.ko

<aside>
Jean, I think the identical data-size means that 
sensor_device_attribute_2's
are not smaller than sensor_device_attribute's, probably because of 
alignment issues
in the array.
This suggests that maybe we should go straight to SENSOR_ATTR_4, with
4 u8's, or maybe even a union of u8 bytes[4]; u16 shorts[2]; int index;
</>


There are a few places where I could add line wraps, but this is meant 
as an interim
patch, and I expect the consolidated show_*() name to shorten it back 
up, and obviate
the need to wrap.  So I avoided the churn.



BTW, sensors still work, which (informally) validates the new mutexes here.

$ diffstat hwmon-pc87360-use-sensor-attr-2.patch
 pc87360.c |  492 
++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 277 insertions(+), 215 deletions(-)


Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>


-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-use-sensor-attr-2.patch
Type: text/x-patch
Size: 36103 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060120/6935482a/hwmon-pc87360-use-sensor-attr-2-0001.bin
