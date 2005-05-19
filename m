From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/tda7432.c: ACK return on
Message-Id: <20040622153140.GE1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 tda7432.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/media/video/tda7432.c	2004-06-17 17:29:45.000000000 +0200
+++ b/drivers/media/video/tda7432.c	2004-06-17 17:31:21.000000000 +0200
@@ -532,17 +532,17 @@ static struct i2c_client client_template
 	.driver     = &driver, 
 };
 
-static int tda7432_init(void)
+static int __init tda7432_init(void)
 {
 	if ( (loudness < 0) || (loudness > 15) ) {
 		printk(KERN_ERR "tda7432: loudness parameter must be between 0 and 15\n");
 		return -EINVAL;
 	}
-	i2c_add_driver(&driver);
-	return 0;
+
+	return i2c_add_driver(&driver);
 }
 
-static void tda7432_fini(void)
+static void __exit tda7432_fini(void)
 {
 	i2c_del_driver(&driver);
 }
