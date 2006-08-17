From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 17 Aug 2006 03:04:52 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <5bfe43f80608162004r20bad3b8hd25827282b2c5363@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
In-Reply-To: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

Modified patch from Sven Anders to enhance w83791d support. Adds output
for in7, in8, in9, fan4 and fan5. Also updated to display the (beep)
properly due to the fact that the w83791d beep enable mask is different
than the alarm mask.

Signed-off by: Sven Anders <anders at anduras.de>
Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 kernel/chips/w83781d.c |   18 +++++++--
 prog/sensors/chips.c   |   94
++++++++++++++++++++++++++++++++++++++++++++++--- 2 files changed, 103
insertions(+), 9 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm-sensors-r4079-20060730_sven_changes.patch
Type: text/x-patch
Size: 8721 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060816/43b7b6d7/attachment.bin 
