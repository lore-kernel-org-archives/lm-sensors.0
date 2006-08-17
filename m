From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 17 Aug 2006 22:11:22 +0000
Subject: [lm-sensors] [PATCH] documentation-only update for w83791d to note
Message-Id: <5bfe43f80608171511h546b5ceai3cbf0b2987becbec@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

The alarm bits and the beep enable bits are in different positions in the
hardware. This patch documents the problem and leaves it to the user-space code
to handle the situation. When this driver is updated to the standardized sysfs
alarm/beep methodology, this won't be a problem.

This is a documentation only change.

Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 Documentation/hwmon/w83791d |   70
+++++++++++++++++++++++++------------------- drivers/hwmon/w83791d.c
  |    6 ++-
 2 files changed, 44 insertions(+), 32 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_update.patch
Type: text/x-patch
Size: 5812 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060817/9c817129/attachment-0001.bin 
