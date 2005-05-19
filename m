From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] i2c-vid.h: Support for VID to reg conversion 2
Message-Id: <425D8043.4010107@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050412163404.GA14857@kroah.com>
In-Reply-To: <20050412163404.GA14857@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Adds conversion from VID (mV) to register value. Used by the atxp1 I2C module.
Removed uneeded switch case.

Signed-off-by: Sebastian Witt <se.witt@gmx.net>
-------------- next part --------------
diff -ruN linux-2.6.12-rc2-mm3-orig/include/linux/i2c-vid.h linux-2.6.12-rc2-mm3/include/linux/i2c-vid.h
--- linux-2.6.12-rc2-mm3-orig/include/linux/i2c-vid.h   2005-03-02 08:37:31.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/linux/i2c-vid.h        2005-04-12 18:22:23.000000000 +0200
@@ -97,3 +97,22 @@
                                     2050 - (val) * 50);
        }
 }
+
+static inline int vid_to_reg(int val, int vrm)
+{
+        
+        switch (vrm) {
+
+        case 91:                /* VRM 9.1 */
+        case 90:                /* VRM 9.0 */
+                return ((val >= 1100) && (val <= 1850) ?
+                        ((18499 - val * 10) / 25 + 5) / 10 : -1);
+        
+        default:
+                return -1;
+
+        }
+}
