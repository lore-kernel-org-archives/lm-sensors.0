From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 03 Aug 2006 07:57:15 +0000
Subject: [lm-sensors] [PATCH] w83791d - swap bit 1 and bit 13 in beep_enable
Message-Id: <5bfe43f80608030057w2a35591ag2f6bd7b771b0c568@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Charles Spirakis <bezaur at gmail.com>

The alarm and beep enable bits are close to being the same but bit 1 and
bit 13 are swapped. This patch swaps those bits on the beep enable side
so that user-mode doesn't need to know. Also, the w83791d official
documentation for the alarm bits doesn't seem to match reality so
update the driver documentation to reflect reality.  Patch was originally
submitted by Sven Anders.

Signed-off by: Sven Anders <anders at anduras.de>
Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 Documentation/hwmon/w83791d |   43 ++++++++++++++++++++++++++-----------------
 drivers/hwmon/w83791d.c     |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 20 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83791d_update.patch
Type: text/x-patch
Size: 5790 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060803/b5693a78/attachment.bin 
