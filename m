From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 13:36:20 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4-mm2] drivers: (dynamic sysfs
Message-Id: <253818670505190435648367db@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Greg,

I'm taking two steps here to try and mitigate the pain of a potential -mm merge.

I'm including a patch against 2.4.12-rc4-mm2 to fix the failed hunks
when applying my 2.4.12-rc4 patch and update the callbacks in the new
drivers that exist in -mm2.

In reply to this patch I'll include the latest perl script I'm using
to update callbacks in code which can be used to update any old
callbacks in a single file/source tree to the new callbacks. A warning
along the lines of  "warning: assignment from incompatible pointer
type" when compiling is a good sign of an old callback that needs
updating..

It is important to note that unlike before, updating the callbacks
isn't just removing warnings/good practice. The new device_attribute *
parameter was not added on the end of callback function's parameter
list as the void * parameter was in previous device_attribute patches,
but as the second parameter (mainly because of style and Russell did
it that way). Thus if a device_attribute callback isn't updated it
will very likely be broken...

If you can think of anything else I can do let me know to ease things
let me know.

Yani

---
char/tpm/tpm.c            |    8 ++++----
  char/tpm/tpm.h            |    8 ++++----
 i2c/chips/adm1025.c       |    8 ++++----
 i2c/chips/adm9240.c       |   32 ++++++++++++++++----------------
 i2c/chips/atxp1.c         |   12 ++++++------
 i2c/chips/w83627ehf.c     |   18 +++++++++---------
  input/serio/serio.c       |   12 ++++++------
  message/fusion/mptscsih.c |    2 +-
  message/fusion/mptscsih.h |    2 +-
  pci/pci-sysfs.c           |    2 +-
  pcmcia/ds.c               |    2 +-
  usb/core/sysfs.c          |    2 +-
 12 files changed, 54 insertions(+), 54 deletions(-)
---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-mm2-sysfsdyncallback-deviceattr-update.diff
Type: text/x-patch
Size: 22087 bytes
Desc: not available
Url : http://lists.atrpms.net/pipermail/lm-sensors/attachments/20050519/51d1b247/patch-linux-2.6.12-rc4-mm2-sysfsdyncallback-deviceattr-update.bin
