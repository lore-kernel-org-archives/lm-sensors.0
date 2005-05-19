From: galak@freescale.com (Kumar Gala)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] I2C-MPC: Allow for sharing of the interrupt line
Message-Id: <Pine.LNX.4.61.0505031849120.19691@nylon.am.freescale.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, linuxppc-embedded <linuxppc-embedded@ozlabs.org>

I2C-MPC: Allow for sharing of the interrupt line

On the MPC8548 devices we have multiple I2C-MPC buses however they are on the
same interrupt line.  Made request_irq pass SA_SHIRQ now so the second bus can
register for the same IRQ.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit cc75b79f8142eb8a50432cf612bb1ab189136cd0
tree 79fd2184cd5cfee440f3ca2952f7c9f834ece443
parent 52292c9b8c16aa9024a65aaeeca434bb8fec7d24
author Kumar K. Gala <kumar.gala@freescale.com> 1115164017 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> 1115164017 -0500

Index: drivers/i2c/busses/i2c-mpc.c
=================================--- 59c7aae8cab7c4e1e557dd3a4fff6afbffab38e2/drivers/i2c/busses/i2c-mpc.c  (mode:100644 sha1:6f33496d31c31e6c57d3d2479db4afb4dad23617)
+++ 79fd2184cd5cfee440f3ca2952f7c9f834ece443/drivers/i2c/busses/i2c-mpc.c  (mode:100644 sha1:c8a8703dcbcb16fdd5ccd5fddf8f322d2509d5dd)
@@ -325,7 +325,7 @@
 	if (i2c->irq != OCP_IRQ_NA)
 	{
 		if ((result = request_irq(ocp->def->irq, mpc_i2c_isr,
-					  0, "i2c-mpc", i2c)) < 0) {
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
@@ -424,7 +424,7 @@
 
 	if (i2c->irq != 0)
 		if ((result = request_irq(i2c->irq, mpc_i2c_isr,
-					  0, "fsl-i2c", i2c)) < 0) {
+					  SA_SHIRQ, "i2c-mpc", i2c)) < 0) {
 			printk(KERN_ERR
 			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_irq;
