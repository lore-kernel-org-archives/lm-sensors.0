From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/saa7134/saa6752.c: ACK return on
Message-Id: <20040622152836.GD1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 saa6752hs.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/saa7134/saa6752hs.c	2004-06-17 17:29:45.000000000 +0200
+++ b/drivers/media/video/saa7134/saa6752hs.c	2004-06-17 17:31:21.000000000 +0200
@@ -388,13 +388,12 @@ static struct i2c_client client_template
         .driver     = &driver,
 };
 
-static int saa6752hs_init_module(void)
+static int __init saa6752hs_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void saa6752hs_cleanup_module(void)
+static void __exit saa6752hs_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
