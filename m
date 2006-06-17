From: bezaur@gmail.com (Charles Spirakis)
Date: Sat, 17 Jun 2006 05:33:22 +0000
Subject: [lm-sensors] [PATCH] detect: update sensors-detect for w83791d and
Message-Id: <5bfe43f80606162233r484a8d54k54c624403c9add69@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Change sensors-detect to support the w83791d driver when run on a 2.6 kernel

Signed-off by: Charles Spirakis <bezaur at gmail.com>

---

 sensors-detect |   42 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 6 deletions(-)
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060616/794b865a/attachment-0001.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2_w83791d.patch
Type: text/x-patch
Size: 2879 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060616/794b865a/attachment-0001.bin 
