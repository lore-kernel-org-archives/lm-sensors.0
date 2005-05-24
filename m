From: gregkh@suse.de (gregkh@suse.de)
Date: Tue, 24 May 2005 01:19:40 +0000
Subject: [lm-sensors] patch i2c-mpc-race-fix.patch added to gregkh-2.6 tree
Message-Id: <1DaMCC-4C5-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: i2c: Race fix for i2c-mpc.c

to my gregkh-2.6 tree.  Its filename is

     i2c-mpc-race-fix.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from tnt@246tNt.com are

i2c-mpc-race-fix.patch


From tnt@246tNt.com Wed May 18 13:55:26 2005
Message-ID: <0.20050518_204412.tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Greg KH <greg@kroah.com>
Cc: Kumar Gala <kumar.gala@freescale.com>,
        ML lm-sensors <lm-sensors@lm-sensors.org>,
        Sylvain Munaut <tnt@246tNt.com>
Subject: i2c: Race fix for i2c-mpc.c
Date: Wed, 18 May 2005 19:39:57 +0200 (CEST)

i2c: Race fix for i2c-mpc.c

The problem was that the clock speed and driver data is
initialized after the i2c adapter was added. This caused
the i2c bus to start working at a wrong speed. (Mostly
noticable on the second bus on mpc5200)

With this patch we've tried to keep the i2c adapter
working perfectly all the time it is included in the system.
Initialize before added, Remove garbage after deleleted. 


Submitted-by: Asier Llano Palacios
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/busses/i2c-mpc.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

--- gregkh-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2005-05-23 16:06:42.000000000 -0700
+++ gregkh-2.6/drivers/i2c/busses/i2c-mpc.c	2005-05-23 16:18:24.000000000 -0700
@@ -333,6 +333,9 @@
 	} else
 		i2c->irq = 0;
 
+	mpc_i2c_setclock(i2c);
+	ocp_set_drvdata(ocp, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 
@@ -341,8 +344,6 @@
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	ocp_set_drvdata(ocp, i2c);
 	return result;
 
       fail_add:
@@ -358,8 +359,8 @@
 static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
 {
 	struct mpc_i2c *i2c = ocp_get_drvdata(ocp);
-	ocp_set_drvdata(ocp, NULL);
 	i2c_del_adapter(&i2c->adap);
+	ocp_set_drvdata(ocp, NULL);
 
 	if (ocp->def->irq != OCP_IRQ_NA)
 		free_irq(i2c->irq, i2c);
@@ -430,6 +431,9 @@
 			goto fail_irq;
 		}
 
+	mpc_i2c_setclock(i2c);
+	dev_set_drvdata(device, i2c);
+
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
@@ -438,8 +442,6 @@
 		goto fail_add;
 	}
 
-	mpc_i2c_setclock(i2c);
-	dev_set_drvdata(device, i2c);
 	return result;
 
       fail_add:
@@ -456,8 +458,8 @@
 {
 	struct mpc_i2c *i2c = dev_get_drvdata(device);
 
-	dev_set_drvdata(device, NULL);
 	i2c_del_adapter(&i2c->adap);
+	dev_set_drvdata(device, NULL);
 
 	if (i2c->irq != 0)
 		free_irq(i2c->irq, i2c);
