From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 03 Aug 2006 07:56:47 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

Modified patch from Sven Anders to enhance w83791d support. Partial
support was already implemented, but it was missing IN9/FAN4/FAN5 output.

Signed-off by: Sven Anders <anders at anduras.de>
Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 kernel/chips/w83781d.c |   16 ++++++++++-----
 prog/sensors/chips.c   |   50
+++++++++++++++++++++++++++++++++++++++++++++++-- 2 files changed, 59
insertions(+), 7 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-r4079-20060730_sven_changes.patch
Type: text/x-patch
Size: 6216 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060803/920c40e7/attachment-0001.bin 
