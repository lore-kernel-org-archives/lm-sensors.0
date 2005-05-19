From: a.othieno@bluewin.ch (Arthur Othieno)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH 2.6] drivers/media/video/bt832.c: ACK return on
Message-Id: <20040622151603.GA1473@mars>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

i2c_add_driver() may actually fail, but this driver returns 0
regardless. Against 2.6.7. Thanks.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 bt832.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/media/video/bt832.c	2004-06-17 17:29:45.000000000 +0200
+++ b/drivers/media/video/bt832.c	2004-06-17 17:31:21.000000000 +0200
@@ -255,13 +255,12 @@ static struct i2c_client client_template
 };
 
 
-int bt832_init_module(void)
+static int __init bt832_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void bt832_cleanup_module(void)
+static void __exit bt832_cleanup_module(void)
 {
 	i2c_del_driver(&driver);
 }
