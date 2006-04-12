From: bezaur@gmail.com (Charles Spirakis)
Date: Wed, 12 Apr 2006 02:38:17 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add w83791d support
Message-Id: <5bfe43f80604111938lb27d121r81b1e5b5b2f29808@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
In-Reply-To: <5bfe43f80604041606n5a99ecbcg234ae8532b016b6c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

Add support for the w83791d sensor chip. The w83791d hardware is
somewhere between the w83781d and the w83792d and this driver code
is derived from the code that supports those chips.

Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 Documentation/hwmon/w83791d |  113 +++
 drivers/hwmon/Kconfig       |   10
 drivers/hwmon/Makefile      |    1
 drivers/hwmon/w83791d.c     | 1255 ++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 1379 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_support.patch
Type: text/x-patch
Size: 46365 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060412/487f9186/w83791d_support-0001.bin
