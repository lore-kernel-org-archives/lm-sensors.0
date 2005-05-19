From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <10999778564013@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10999778564020@kroah.com>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2014.1.13, 2004/11/05 13:49:29-08:00, greg@kroah.com

W1: fix build warnings due to msleep changes.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1_family.c |    1 +
 drivers/w1/w1_int.c    |    1 +
 2 files changed, 2 insertions(+)


diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2004-11-08 18:55:22 -08:00
+++ b/drivers/w1/w1_family.c	2004-11-08 18:55:22 -08:00
@@ -21,6 +21,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 
 #include "w1_family.h"
 
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2004-11-08 18:55:22 -08:00
+++ b/drivers/w1/w1_int.c	2004-11-08 18:55:22 -08:00
@@ -21,6 +21,7 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/delay.h>
 
 #include "w1.h"
 #include "w1_log.h"

