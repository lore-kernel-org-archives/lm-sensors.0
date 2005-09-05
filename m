From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:31 +0000
Subject: [lm-sensors] [PATCH] hwmon: hwmon vs i2c, second round (09/11)
Message-Id: <11259567693216@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567691080@kroah.com>
In-Reply-To: <11259567691080@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: hwmon vs i2c, second round (09/11)

Delete DEFAULT_VRM from hwmon-vid.h, it has no more users.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ee70d3a33368038d41985474d9e70ac07f19651c
tree e7ed65759dcd3eab4d094ef1030906a1cfab1f2e
parent da97a5a3279340462e8be6612feabc4b28883f87
author Jean Delvare <khali@linux-fr.org> Sun, 31 Jul 2005 21:57:33 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:23 -0700

 include/linux/hwmon-vid.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/hwmon-vid.h b/include/linux/hwmon-vid.h
--- a/include/linux/hwmon-vid.h
+++ b/include/linux/hwmon-vid.h
@@ -53,8 +53,6 @@
 
 int vid_which_vrm(void);
 
-#define DEFAULT_VRM	82
-
 static inline int vid_from_reg(int val, int vrm)
 {
 	int vid;

