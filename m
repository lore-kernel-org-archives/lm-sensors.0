From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 31 Jul 2005 21:58:02 +0000
Subject: [lm-sensors] [PATCH 2.6] (9/11) hwmon vs i2c, second round
Message-Id: <20050731215733.42657957.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>

Delete DEFAULT_VRM from hwmon-vid.h, it has no more users.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 include/linux/hwmon-vid.h |    2 --
 1 files changed, 2 deletions(-)

--- linux-2.6.13-rc4.orig/include/linux/hwmon-vid.h	2005-07-31 16:59:30.000000000 +0200
+++ linux-2.6.13-rc4/include/linux/hwmon-vid.h	2005-07-31 20:55:49.000000000 +0200
@@ -53,8 +53,6 @@
 
 int vid_which_vrm(void);
 
-#define DEFAULT_VRM	82
-
 static inline int vid_from_reg(int val, int vrm)
 {
 	int vid;


-- 
Jean Delvare
