From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <1048295082521@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030322010405.GA18613@kroah.com>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1188, 2003/03/21 12:29:44-08:00, vandrove@vc.cvut.cz

[PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk

i2c initialization must not use module_init now, when it was converted
to the kobject interface. There are dozens of users which need it working
much sooner. i2c is subsystem after all, isn't it?

Fixes kernel oopses in kobject_get during system init which were happening
to me.


 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Fri Mar 21 16:53:45 2003
+++ b/drivers/i2c/i2c-core.c	Fri Mar 21 16:53:45 2003
@@ -675,7 +675,7 @@
 	bus_unregister(&i2c_bus_type);
 }
 
-module_init(i2c_init);
+subsys_initcall(i2c_init);
 module_exit(i2c_exit);
 
 /* ----------------------------------------------------
