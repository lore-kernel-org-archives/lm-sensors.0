From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [PATCH] i2c driver changes for 2.5.69
Message-Id: <10522676152488@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1052267615977@kroah.com>
References: <10522676142536@kroah.com>
In-Reply-To: <10522676142536@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1042.48.3, 2003/04/29 10:12:19-07:00, paulus@samba.org

[PATCH] i2c: i2c-keywest.c irq handler type

This patch changes the interrupt handler routine in i2c-keywest.c to
return an irqreturn_t.


 drivers/i2c/i2c-keywest.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/i2c-keywest.c b/drivers/i2c/i2c-keywest.c
--- a/drivers/i2c/i2c-keywest.c	Tue May  6 17:24:55 2003
+++ b/drivers/i2c/i2c-keywest.c	Tue May  6 17:24:55 2003
@@ -212,7 +212,7 @@
 #ifndef POLLED_MODE
 
 /* Interrupt handler */
-static void
+static irqreturn_t
 keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
@@ -225,6 +225,7 @@
 		add_timer(&iface->timeout_timer);
 	}
 	spin_unlock(&iface->lock);
+	return IRQ_HANDLED;
 }
 
 static void

