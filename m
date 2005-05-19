From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6.12-rc4 1/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <2538186705051100563e884f2f@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

Hi,

This patch adds support to the sysfs device_attribute to pass the new
void * attribute member to it's callback functions. The device
attribute will benefit the most from the dynamic sysfs callback patch
compared to the other attributes simply because of it's greater usage.

The first patch simply adds the void * parameter to the device
attribute function types and passes them when calling the callbacks.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 drivers/base/core.c    |    4 ++--
 include/linux/device.h |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.diff
Type: text/x-patch
Size: 1629 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050511/d6eab251/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr.bin
