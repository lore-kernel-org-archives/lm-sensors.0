From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c:
Message-Id: <2538186705051703479bd0c29@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Finally (phew!) this patch demonstrates how to adapt the adm1026 to
take advantage of the new callbacks, and the i2c-sysfs.h defined
structure/macros. Most of the other sensor/hwmon drivers could be
updated in the same way. The odd few exceptions (bmcsensors for
example) however might be better off with their own custom attribute
structure.

Again I'd prefer someone test this particular patch before it be
applied, because I haven't got an adm1026 to test it with :-).

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

---
-------------- next part --------------
 drivers/i2c/chips/adm1026.c |  524 ++++++++++++++++++++------------------------
 include/linux/i2c-sysfs.h   |    2 
 2 files changed, 242 insertions(+), 284 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c-adm1026.diff
Type: text/x-patch
Size: 41313 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050517/00459ca1/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-i2c-adm1026.bin
-------------- next part --------------
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
