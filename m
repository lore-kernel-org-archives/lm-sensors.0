From: m.hunold@gmx.de (Michael Hunold)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: [PATCH][2.6] drivers/media/video/tda9840.c: honour return code of
Message-Id: <40D85585.1060608@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: sensors@stimpy.netroedge.com, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, a.othieno@bluewin.ch

Hello Linus,

i2c_add_driver() may actually fail, but my driver returns 0
regardless. Thanks to Arthur Othieno <a.othieno@bluewin.ch> for this 
obviously correct patch.

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
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

