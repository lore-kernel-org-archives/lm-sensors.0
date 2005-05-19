From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [PATCH] i2c driver fixes for 2.6.3-rc1
Message-Id: <10763687741075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10763687741938@kroah.com>
References: <10763687741938@kroah.com>
In-Reply-To: <10763687741938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1500.11.2, 2004/01/30 16:56:36-08:00, ender@debian.org

[PATCH] I2C: fix typos

Following patch fixes two typos and a missing full stop.


 drivers/i2c/chips/lm85.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Feb  9 15:06:03 2004
+++ b/drivers/i2c/chips/lm85.c	Mon Feb  9 15:06:03 2004
@@ -816,7 +816,7 @@
 			kind = lm85b ;
 		} else if( company = LM85_COMPANY_NATIONAL
 		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to LM85.\n", verstep);
 			kind = any_chip ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
@@ -827,7 +827,7 @@
 			kind = adt7463 ;
 		} else if( company = LM85_COMPANY_ANALOG_DEV
 		    && (verstep & 0xf0) = LM85_VERSTEP_GENERIC ) {
-			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
+			dev_err(&adapter->dev, "Unrecognized version/stepping 0x%02x"
 				" Defaulting to ADM1027.\n", verstep);
 			kind = adm1027 ;
 		} else if( kind = 0 && (verstep & 0xf0) = 0x60) {
@@ -1204,7 +1204,7 @@
 
 /* Thanks to Richard Barrington for adding the LM85 to sensors-detect.
  * Thanks to Margit Schubert-While <margitsw@t-online.de> for help with
- *     post 2.7.0 CVS changes
+ *     post 2.7.0 CVS changes.
  */
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Philip Pokorny <ppokorny@penguincomputing.com>, Margit Schubert-While <margitsw@t-online.de>");

