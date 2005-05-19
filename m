From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/tuner-3036.c: ACK return on
Message-Id: <20040622155619.GK1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 tuner-3036.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/tuner-3036.c	2003-12-18 03:58:47.000000000 +0100
+++ b/drivers/media/video/tuner-3036.c	2004-06-04 18:13:50.000000000 +0200
@@ -197,14 +197,13 @@ static struct i2c_client client_template
 	.name		= "SAB3036",
 };
 
-int __init
+static int __init
 tuner3036_init(void)
 {
-	i2c_add_driver(&i2c_driver_tuner);
-	return 0;
+	return i2c_add_driver(&i2c_driver_tuner);
 }
 
-void __exit
+static void __exit
 tuner3036_exit(void)
 {
 	i2c_del_driver(&i2c_driver_tuner);
