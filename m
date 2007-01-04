From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 04 Jan 2007 22:33:39 +0000
Subject: [lm-sensors] [PATCH] i2c: fix oops in i2c-mv64xxx
Message-Id: <1167950019.22993.95.camel@sakura.staff.proxad.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I have a Marvell board which has the same i2c hw block than mv64xxx, so
I'm trying to use i2c-mv64xxx driver.

But I get the following random oops at boot:

Unable to handle kernel NULL pointer dereference at virtual address 00000002
Backtrace: 
[<c0397e4c>] (mv64xxx_i2c_intr+0x0/0x2b8) from [<c02879c4>] (__do_irq+0x4c/0x8c)
[<c0287978>] (__do_irq+0x0/0x8c) from [<c0287c0c>] (do_level_IRQ+0x68/0xc0)
 r8 = C0501E08  r7 = 00000005  r6 = C0501E08  r5 = 00000005
 r4 = C048BB78 
[<c0287ba4>] (do_level_IRQ+0x0/0xc0) from [<c02885f8>] (asm_do_IRQ+0x50/0x134)
 r6 = C0449C78  r5 = F1020000  r4 = FFFFFFFF 
[<c02885a8>] (asm_do_IRQ+0x0/0x134) from [<c02869c4>] (__irq_svc+0x24/0x100)
 r8 = C1CAC400  r7 = 00000005  r6 = 00000002  r5 = F1020000
 r4 = FFFFFFFF 
[<c0287efc>] (setup_irq+0x0/0x124) from [<c02880d0>] (request_irq+0xb0/0xd0)
 r7 = C041B2AC  r6 = C0397E4C  r5 = 00000000  r4 = 00000005
[<c0288020>] (request_irq+0x0/0xd0) from [<c03985f4>] (mv64xxx_i2c_probe+0x148/0x244)
[<c03984ac>] (mv64xxx_i2c_probe+0x0/0x244) from [<c038bedc>] (platform_drv_probe+0x20/0x24)


The oops is caused by a spurious interrupt that occurs when request_irq
is called. mv64xxx_i2c_fsm() tries to read drv_data->msg, which is NULL.

I noticed that hardware init is done after requesting irq. Thus any
pending irq from previous hardware usage may cause this.

The following patch fixes it:


Signed-off-by: Maxime Bizon <mbizon at freebox.fr>

--- linux-2.6.19.1/drivers/i2c/busses/i2c-mv64xxx.c.old	2007-01-04 18:08:00.000000000 +0100
+++ linux-2.6.19.1/drivers/i2c/busses/i2c-mv64xxx.c	2007-01-04 18:08:28.000000000 +0100
@@ -529,6 +529,8 @@
 	platform_set_drvdata(pd, drv_data);
 	i2c_set_adapdata(&drv_data->adapter, drv_data);
 
+	mv64xxx_i2c_hw_init(drv_data);
+
 	if (request_irq(drv_data->irq, mv64xxx_i2c_intr, 0,
 			MV64XXX_I2C_CTLR_NAME, drv_data)) {
 		dev_err(&drv_data->adapter.dev,
@@ -542,8 +544,6 @@
 		goto exit_free_irq;
 	}
 
-	mv64xxx_i2c_hw_init(drv_data);
-
 	return 0;
 
 	exit_free_irq:



-- 
Maxime


-- 
Maxime


