From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 08 Oct 2005 00:18:01 +0000
Subject: [lm-sensors] [PATCH 13/16] i2c: Rename i2c-parport variable to
Message-Id: <20051008001735.3ee379da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's a bit confusing to name a variable the same as an unrelated
structure. The compiler doesn't complain, but it certainly makes the
code harder to understand, and could confuse grep and LXR among
others.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/busses/i2c-parport.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc3.orig/drivers/i2c/busses/i2c-parport.c	2005-08-29 20:35:02.000000000 +0200
+++ linux-2.6.14-rc3/drivers/i2c/busses/i2c-parport.c	2005-10-06 19:36:30.000000000 +0200
@@ -232,7 +232,7 @@
 	}
 }
 
-static struct parport_driver i2c_driver = {
+static struct parport_driver i2c_parport_driver = {
 	.name	= "i2c-parport",
 	.attach	= i2c_parport_attach,
 	.detach	= i2c_parport_detach,
@@ -250,12 +250,12 @@
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

-- 
Jean Delvare
