From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <1075246453858@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1075246453680@kroah.com>
References: <10752464532280@kroah.com>
In-Reply-To: <10752464532280@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.148.2, 2004/01/23 17:14:38-08:00, khali@linux-fr.org

[PATCH] I2C: undo documentation change

Undo a recent change to the i2c documentation. The change belongs to
2.7.


 Documentation/i2c/porting-clients |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients	Tue Jan 27 15:27:19 2004
+++ b/Documentation/i2c/porting-clients	Tue Jan 27 15:27:19 2004
@@ -92,10 +92,7 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
-  by module_param(). Note that module_param has a third parameter,
-  that you should set to 0 by default. See include/linux/moduleparam.h
-  for details.
+  there is a MODULE_LICENSE() line.
 
 Coding policy:
 

