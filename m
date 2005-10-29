From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:16:33 +0000
Subject: [lm-sensors] [PATCH] i2c: Rename i2c-parport variable to avoid
Message-Id: <1130533661783@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Rename i2c-parport variable to avoid confusion

It's a bit confusing to name a variable the same as an unrelated
structure. The compiler doesn't complain, but it certainly makes the
code harder to understand, and could confuse grep and LXR among
others.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6c129be8c7bd1bdbd47ba8e17f6e5053ef04aee8
tree ee63ddf9651ae49a2b48615135ea338ba9e12bb9
parent 30dac7469741906436b50f9413dccd446366d371
author Jean Delvare <khali@linux-fr.org> Sat, 08 Oct 2005 00:17:35 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:10 -0700

 drivers/i2c/busses/i2c-parport.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 71a2502..fa50618 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -232,7 +232,7 @@ static void i2c_parport_detach (struct p
 	}
 }
 
-static struct parport_driver i2c_driver = {
+static struct parport_driver i2c_parport_driver = {
 	.name	= "i2c-parport",
 	.attach	= i2c_parport_attach,
 	.detach	= i2c_parport_detach,
@@ -250,12 +250,12 @@ static int __init i2c_parport_init(void)
 		type = 0;
 	}
 	
-	return parport_register_driver(&i2c_driver);
+	return parport_register_driver(&i2c_parport_driver);
 }
 
 static void __exit i2c_parport_exit(void)
 {
-	parport_unregister_driver(&i2c_driver);
+	parport_unregister_driver(&i2c_parport_driver);
 }
 
 MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");

