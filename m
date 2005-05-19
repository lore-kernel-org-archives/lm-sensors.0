From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 12/15] drivers/usb/input/aiptek.c -
Message-Id: <2538186705051703443405ff1d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 usb/input/aiptek.c      |   78 ++++++++++++++++++++++++------------------------
 usb/misc/cytherm.c      |   20 ++++++------
 usb/misc/phidgetkit.c   |   14 ++++----
 usb/misc/phidgetservo.c |    4 +-
 usb/misc/usbled.c       |    4 +-
 usb/serial/ftdi_sio.c   |    6 +--
 usb/storage/scsiglue.c  |    4 +-
 video/gbefb.c           |    4 +-
 video/w100fb.c          |   12 +++----
 w1/w1.c                 |   16 ++++-----
 w1/w1_family.h          |    4 +-
 w1/w1_smem.c            |    8 ++--
 w1/w1_therm.c           |    8 ++--
 zorro/zorro-sysfs.c     |    4 +-
 14 files changed, 93 insertions(+), 93 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.7.diff
Type: text/x-patch
Size: 39302 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/a515a1c3/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.7.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
