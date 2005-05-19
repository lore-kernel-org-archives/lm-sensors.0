From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 11/15] drivers/s390/net/qeth_sys.c -
Message-Id: <25381867050517034323b6451@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 s390/net/qeth_sys.c              |  126 +++++++++++++++++++--------------------
 s390/scsi/zfcp_scsi.c            |    2 
 s390/scsi/zfcp_sysfs_adapter.c   |   10 +--
 s390/scsi/zfcp_sysfs_port.c      |   10 +--
 s390/scsi/zfcp_sysfs_unit.c      |    6 -
 scsi/53c700.c                    |    2 
 scsi/arm/eesox.c                 |    4 -
 scsi/arm/powertec.c              |    4 -
 scsi/ipr.c                       |    2 
 scsi/megaraid/megaraid_mbox.c    |    4 -
 scsi/scsi_sysfs.c                |   28 ++++----
 sh/superhyway/superhyway-sysfs.c |    2 
 usb/core/sysfs.c                 |   24 +++----
 usb/gadget/dummy_hcd.c           |    4 -
 usb/gadget/file_storage.c        |    8 +-
 usb/gadget/net2280.c             |    6 -
 usb/gadget/pxa2xx_udc.c          |    2 
 17 files changed, 122 insertions(+), 122 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.diff
Type: text/x-patch
Size: 48532 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/c056e962/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-update.diff-drivers.diff.6.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
