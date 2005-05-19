From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/tea6415c.c: ACK return on
Message-Id: <20040622154839.GI1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 tea6415c.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/tea6415c.c	2003-12-18 03:59:16.000000000 +0100
+++ b/drivers/media/video/tea6415c.c	2004-03-31 20:24:35.000000000 +0200
@@ -217,13 +217,12 @@ static struct i2c_driver driver = {
         .command	= tea6415c_command,
 };
 
-static int tea6415c_init_module(void)
+static int __init tea6415c_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tea6415c_cleanup_module(void)
+static void __exit tea6415c_cleanup_module(void)
 {
         i2c_del_driver(&driver);
 }
