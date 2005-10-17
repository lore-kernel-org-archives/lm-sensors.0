From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:53:33 +0000
Subject: [lm-sensors] [PATCH 03/14] Owner field additions to many i2c
Message-Id: <20051017225352.708f8c24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-owner-field-03-i2c-keywest.patch

This patch updates the .owner field for various struct xxxx_driver
variables which are available on PPC_MAC arch.

This one was _not_ even compile-tested...

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/busses/i2c-keywest.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-keywest.c	2005-10-07 19:56:10.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-keywest.c	2005-10-08 18:03:42.000000000 +0200
@@ -716,6 +716,7 @@
 
 static struct macio_driver i2c_keywest_macio_driver = 
 {
+	.owner		= THIS_MODULE,
 	.name 		= "i2c-keywest",
 	.match_table	= i2c_keywest_match,
 	.probe		= create_iface_macio,
@@ -724,6 +725,7 @@
 
 static struct of_platform_driver i2c_keywest_of_platform_driver = 
 {
+	.owner		= THIS_MODULE,
 	.name 		= "i2c-keywest",
 	.match_table	= i2c_keywest_match,
 	.probe		= create_iface_of_platform,

-- 
Jean Delvare
