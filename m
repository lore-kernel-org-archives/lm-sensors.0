From: jim.cromie@gmail.com (Jim Cromie)
Date: Wed, 28 Dec 2005 18:51:00 +0000
Subject: [lm-sensors] hwmon-pc87360-use-sensor-attr-arrays.patch
Message-Id: <43B2DE94.7060100@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean,

I couldnt get rc5-mm3 to boot properly (some switchroot prob)
so I baselined this patch against rc7 + all accepted patches named in
http://khali.linux-fr.org/devel/i2c/linux-2.6/series

(diffstat is uninteresting, but hey ..)
jimc at harpo i2c-stuff]$ diffstat hwmon-pc87360-use-sensor-attr-arrays.patch
 pc87360.c |  410 
++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 202 insertions(+), 208 deletions(-)

Convert individual sensors to sensor-attr arrays by each sensor type,
and initialize them in loops instead of long blocks of individual calls.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-use-sensor-attr-arrays.patch
Type: text/x-patch
Size: 24375 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051228/29665e8f/hwmon-pc87360-use-sensor-attr-arrays.bin
