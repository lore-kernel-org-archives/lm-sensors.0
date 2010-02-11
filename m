From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Feb 2010 15:22:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Drop dead web links in
Message-Id: <20100211162219.77049297@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Unfortunately ITE is no longer publicly providing datasheets for their
IT87xxF series of chips. They may send them on request if you ask
politely.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/it87 |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- linux-2.6.33-rc7.orig/Documentation/hwmon/it87	2010-02-11 15:44:56.000000000 +0100
+++ linux-2.6.33-rc7/Documentation/hwmon/it87	2010-02-11 15:46:09.000000000 +0100
@@ -5,31 +5,23 @@ Supported chips:
   * IT8705F
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/product_info/file/pc/IT8705F_V.0.4.1.pdf
+    Datasheet: Once publicly available at the ITE website, but no longer
   * IT8712F
     Prefix: 'it8712'
     Addresses scanned: from Super I/O config space (8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/product_info/file/pc/IT8712F_V0.9.1.pdf
-               http://www.ite.com.tw/product_info/file/pc/Errata%20V0.1%20for%20IT8712F%20V0.9.1.pdf
-               http://www.ite.com.tw/product_info/file/pc/IT8712F_V0.9.3.pdf
+    Datasheet: Once publicly available at the ITE website, but no longer
   * IT8716F/IT8726F
     Prefix: 'it8716'
     Addresses scanned: from Super I/O config space (8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/product_info/file/pc/IT8716F_V0.3.ZIP
-               http://www.ite.com.tw/product_info/file/pc/IT8726F_V0.3.pdf
+    Datasheet: Once publicly available at the ITE website, but no longer
   * IT8718F
     Prefix: 'it8718'
     Addresses scanned: from Super I/O config space (8 I/O ports)
-    Datasheet: Publicly available at the ITE website
-               http://www.ite.com.tw/product_info/file/pc/IT8718F_V0.2.zip
-               http://www.ite.com.tw/product_info/file/pc/IT8718F_V0%203_(for%20C%20version).zip
+    Datasheet: Once publicly available at the ITE website, but no longer
   * IT8720F
     Prefix: 'it8720'
     Addresses scanned: from Super I/O config space (8 I/O ports)
-    Datasheet: Not yet publicly available.
+    Datasheet: Not publicly available
   * SiS950   [clone of IT8705F]
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
