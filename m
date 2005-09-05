From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:15 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <11259567671846@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567663617@kroah.com>
In-Reply-To: <11259567663617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (9/9)

Move the definitions of i2c_is_isa_client and i2c_is_isa_adapter from
i2c.h to i2c-isa.h. Only hybrid drivers still need them.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 570aefc361d3315ec6749f573009286106b0b2d8
tree e399b3e54cc81c1f3c014b882e0c9a261f36d0f7
parent 02ff982c6911de1484e13a1d765d7bd31a0f8fee
author Jean Delvare <khali@linux-fr.org> Wed, 20 Jul 2005 00:09:03 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:12 -0700

 include/linux/i2c-isa.h |    7 +++++++
 include/linux/i2c.h     |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/i2c-isa.h b/include/linux/i2c-isa.h
--- a/include/linux/i2c-isa.h
+++ b/include/linux/i2c-isa.h
@@ -26,4 +26,11 @@
 extern int i2c_isa_add_driver(struct i2c_driver *driver);
 extern int i2c_isa_del_driver(struct i2c_driver *driver);
 
+/* Detect whether we are on the isa bus. This is only useful to hybrid
+   (i2c+isa) drivers. */
+#define i2c_is_isa_client(clientptr) \
+        ((clientptr)->adapter->algo->id = I2C_ALGO_ISA)
+#define i2c_is_isa_adapter(adapptr) \
+        ((adapptr)->algo->id = I2C_ALGO_ISA)
+
 #endif /* _LINUX_I2C_ISA_H */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -580,11 +580,4 @@ union i2c_smbus_data {
 			.force =		force,			\
 		}
 
-/* Detect whether we are on the isa bus. If this returns true, all i2c
-   access will fail! */
-#define i2c_is_isa_client(clientptr) \
-        ((clientptr)->adapter->algo->id = I2C_ALGO_ISA)
-#define i2c_is_isa_adapter(adapptr) \
-        ((adapptr)->algo->id = I2C_ALGO_ISA)
-
 #endif /* _LINUX_I2C_H */

