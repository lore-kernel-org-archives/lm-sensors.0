From: bezaur@gmail.com (Charles Spirakis)
Date: Tue, 04 Apr 2006 23:06:46 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the w83791d sensor chip. The w83791d hardware is
somewhere between the w83781d and the w83792d and this driver code
is derived from the code that supports those chips.

Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

  Documentation/hwmon/w83791d |  106 +++
  drivers/hwmon/Kconfig       |   10
  drivers/hwmon/Makefile      |    1
  drivers/hwmon/w83791d.c     | 1247
++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1364 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_support.patch
Type: text/x-patch
Size: 44837 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060405/ac649306/w83791d_support-0001.bin
