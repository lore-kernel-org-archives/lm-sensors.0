From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/tda9840.c: ACK return on
Message-Id: <20040622153408.GF1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 tda9840.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/tda9840.c	2003-12-18 03:59:06.000000000 +0100
+++ b/drivers/media/video/tda9840.c	2004-06-04 18:15:25.000000000 +0200
@@ -268,13 +268,12 @@ static struct i2c_driver driver = {
         .command	= tda9840_command,
 };
 
-static int tda9840_init_module(void)
+static int __init tda9840_init_module(void)
 {
-        i2c_add_driver(&driver);
-        return 0;
+        return i2c_add_driver(&driver);
 }
 
-static void tda9840_cleanup_module(void)
+static void __exit tda9840_cleanup_module(void)
 {
         i2c_del_driver(&driver);
 }
