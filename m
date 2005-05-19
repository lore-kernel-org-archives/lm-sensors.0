From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/ir-kbd-i2c.c: ACK return on
Message-Id: <20040622151905.GB1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 ir-kbd-i2c.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/ir-kbd-i2c.c	2004-05-20 23:48:07.000000000 +0200
+++ b/drivers/media/video/ir-kbd-i2c.c	2004-05-19 13:19:21.000000000 +0200
@@ -388,13 +388,12 @@ MODULE_AUTHOR("Gerd Knorr, Michal Kochan
 MODULE_DESCRIPTION("input driver for i2c IR remote controls");
 MODULE_LICENSE("GPL");
 
-static int ir_init(void)
+static int __init ir_init(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void ir_fini(void)
+static void __exit ir_fini(void)
 {
 	i2c_del_driver(&driver);
 }
