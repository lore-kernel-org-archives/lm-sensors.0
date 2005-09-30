From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:52:27 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 3/5] i2c: update .owner field for mac's
Message-Id: <433D50E2.2000602@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch updates the .owner field for various struct xxxx_driver
variables which are available on PPC_MAC arch.

This one was _not_ even compile-tested...

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
---

Index: linux-2.6-mm/drivers/i2c/busses/i2c-keywest.c
=================================--- linux-2.6-mm.orig/drivers/i2c/busses/i2c-keywest.c	2005-09-12 20:34:09.762607750 +0200
+++ linux-2.6-mm/drivers/i2c/busses/i2c-keywest.c	2005-09-12 20:37:16.466276000 +0200
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




-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/ce24060a/signature.bin
