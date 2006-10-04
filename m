From: ebs@ebshome.net (Eugene Surovegin)
Date: Wed, 04 Oct 2006 03:25:10 +0000
Subject: [lm-sensors] [PATCH] PowerPC 4xx I2C driver - add
Message-Id: <20061004032510.GA10354@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This small patch adds calls to the functions request_mem_region and
release_mem_region.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol at teamlog.com>
Signed-off-by: Eugene Surovegin <ebs at ebshome.net>
-------------- next part --------------
--- linux-2.6.18/drivers/i2c/busses/i2c-ibm_iic.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6.18_tlgate/drivers/i2c/busses/i2c-ibm_iic.c	2006-09-28 16:23:38.000000000 +0200
@@ -680,10 +680,16 @@
 	dev->idx = ocp->def->index;
 	ocp_set_drvdata(ocp, dev);
 	
+	if (!request_mem_region(ocp->def->paddr, sizeof(struct iic_regs), "ibm_iic")) {
+		ret = -EBUSY;
+		goto fail2;
+	}
+	
 	if (!(dev->vaddr = ioremap(ocp->def->paddr, sizeof(struct iic_regs)))){
 		printk(KERN_CRIT "ibm-iic%d: failed to ioremap device registers\n",
 			dev->idx);
-		ret = -ENXIO;
+		release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
+		ret = -ENOMEM;
 		goto fail2;
 	}
 	
@@ -749,6 +755,7 @@
 	}	
 
 	iounmap(dev->vaddr);
+	release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
 fail2:	
 	ocp_set_drvdata(ocp, NULL);
 	kfree(dev);	
@@ -777,6 +784,7 @@
 		    free_irq(dev->irq, dev);
 		}
 		iounmap(dev->vaddr);
+		release_mem_region(ocp->def->paddr, sizeof(struct iic_regs));
 		kfree(dev);
 	}
 }
