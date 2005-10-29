From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:02 +0000
Subject: [lm-sensors] [PATCH] Owner field additions to many i2c drivers,
Message-Id: <11305336621501@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] Owner field additions to many i2c drivers, 3 of 5

This patch updates the .owner field for various struct xxxx_driver
variables which are available on PPC_MAC arch.

This one was _not_ even compile-tested...

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e78f857cc5299c3f6b3d046084696ef205948837
tree ff83d0b12d252becaa211f99da5b9e1f9c74f9b7
parent 0cf3628181660be4e21fe520766dcbc3da9d71c8
author Laurent Riffard <laurent.riffard@free.fr> Mon, 17 Oct 2005 22:53:52 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:11 -0700

 drivers/i2c/busses/i2c-keywest.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-keywest.c b/drivers/i2c/busses/i2c-keywest.c
index eff5896..34e43c8 100644
--- a/drivers/i2c/busses/i2c-keywest.c
+++ b/drivers/i2c/busses/i2c-keywest.c
@@ -716,6 +716,7 @@ static struct of_device_id i2c_keywest_m
 
 static struct macio_driver i2c_keywest_macio_driver = 
 {
+	.owner		= THIS_MODULE,
 	.name 		= "i2c-keywest",
 	.match_table	= i2c_keywest_match,
 	.probe		= create_iface_macio,
@@ -724,6 +725,7 @@ static struct macio_driver i2c_keywest_m
 
 static struct of_platform_driver i2c_keywest_of_platform_driver = 
 {
+	.owner		= THIS_MODULE,
 	.name 		= "i2c-keywest",
 	.match_table	= i2c_keywest_match,
 	.probe		= create_iface_of_platform,

